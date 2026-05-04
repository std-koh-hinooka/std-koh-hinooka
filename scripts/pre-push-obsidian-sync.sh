#!/usr/bin/env bash
# pre-push-obsidian-sync.sh
# Obsidian vault 同期検証 pre-push フック
#
# 検証内容:
#   1. spec frontmatter YAML 厳密構文 (yq)
#   2. related_issues / related_prs 形式 (#NNN または owner/repo#NNN)
#   3. last_reviewed 妥当日付
#   4. glossary_refs と vault 内 concept 突合
#   5. spec → vault symlink 解決可能性
#   6. ADR 新規追加時の vault adr-index.md 反映
#   7. orphan glossary (WARN)
#
# 動作:
#   - $OBSIDIAN_VAULT_DIR 未設定: silent skip exit 0
#   - yq 未 install: error exit 1
#
# 詳細: ~/.claude/CLAUDE.md §Obsidian (Scope-Shared Vaults)

set -euo pipefail

ERRORS=()
WARNINGS=()

check_requirements() {
  if [ -z "${OBSIDIAN_VAULT_DIR:-}" ]; then
    exit 0
  fi
  for cmd in yq git find awk basename date realpath; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "エラー: 必須コマンド '$cmd' が見つかりません" >&2
      [[ "$cmd" == "yq" ]] && echo "  install: mise use -g yq@latest" >&2
      exit 1
    fi
  done
  # OBSIDIAN_VAULT_DIR を絶対パスに正規化、存在しないか解決不能ならエラー
  local resolved
  resolved=$(realpath -e "$OBSIDIAN_VAULT_DIR" 2>/dev/null) || {
    echo "エラー: OBSIDIAN_VAULT_DIR '$OBSIDIAN_VAULT_DIR' が存在しないか解決できません" >&2
    exit 1
  }
  OBSIDIAN_VAULT_DIR="$resolved"
}

validate_spec_yaml_and_concepts() {
  local spec_files
  spec_files=$(find docs/specs -name "*.md" -type f 2>/dev/null | grep -vE '(README\.md|\.gitkeep)$' || true)
  while IFS= read -r file; do
    [ -z "$file" ] && continue
    local fm_file
    fm_file=$(mktemp -t spec-fm.XXXXXXXXXX)
    chmod 600 "$fm_file"
    awk '/^---$/{n++; if(n==2)exit; next} n==1' "$file" > "$fm_file"

    if ! yq -e . "$fm_file" >/dev/null 2>&1; then
      ERRORS+=("Spec frontmatter YAML parse 失敗: $file")
      rm -f "$fm_file"
      continue
    fi

    local last_reviewed
    last_reviewed=$(yq -r '.last_reviewed' "$fm_file" 2>/dev/null || echo "")
    if [ -n "$last_reviewed" ] && [ "$last_reviewed" != "null" ]; then
      if ! date -d "$last_reviewed" >/dev/null 2>&1; then
        ERRORS+=("last_reviewed 妥当日付違反: $file (値: '$last_reviewed')")
      fi
    fi

    local issues prs
    mapfile -t issues < <(yq -r '.related_issues[]?' "$fm_file" 2>/dev/null || true)
    for issue in "${issues[@]}"; do
      [ -z "$issue" ] && continue
      [ "$issue" = "null" ] && continue
      if ! [[ "$issue" =~ ^#[0-9]+$ || "$issue" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+#[0-9]+$ ]]; then
        ERRORS+=("related_issues 形式違反: $file 要素 '$issue' (期待: #NNN または owner/repo#NNN)")
      fi
    done
    mapfile -t prs < <(yq -r '.related_prs[]?' "$fm_file" 2>/dev/null || true)
    for pr in "${prs[@]}"; do
      [ -z "$pr" ] && continue
      [ "$pr" = "null" ] && continue
      if ! [[ "$pr" =~ ^#[0-9]+$ || "$pr" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+#[0-9]+$ ]]; then
        ERRORS+=("related_prs 形式違反: $file 要素 '$pr' (期待: #NNN または owner/repo#NNN)")
      fi
    done

    local refs
    mapfile -t refs < <(yq -r '.glossary_refs[]?' "$fm_file" 2>/dev/null || true)
    for ref in "${refs[@]}"; do
      [ -z "$ref" ] && continue
      [ "$ref" = "null" ] && continue
      if [ ! -f "$OBSIDIAN_VAULT_DIR/glossary/$ref.md" ]; then
        ERRORS+=("Glossary 不在: $file の glossary_refs に '$ref' が指定されていますが、$OBSIDIAN_VAULT_DIR/glossary/$ref.md が存在しません")
      fi
    done

    rm -f "$fm_file"
  done <<< "$spec_files"
}

validate_spec_symlink() {
  [ ! -d docs/specs ] && return 0
  local project_name
  project_name=$(basename "$(pwd)")
  local symlink="$OBSIDIAN_VAULT_DIR/specs/$project_name"
  if [ -L "$symlink" ]; then
    local target expected
    target=$(realpath "$symlink" 2>/dev/null || echo "")
    expected=$(realpath "docs/specs" 2>/dev/null || echo "")
    if [ "$target" != "$expected" ]; then
      ERRORS+=("Vault symlink 不整合: $symlink が docs/specs を指していません (target: $target, expected: $expected)")
    fi
  fi
}

validate_adr_index_entry() {
  # base: upstream tracking branch があれば優先、無ければ HEAD~1 にフォールバック
  # 初回 commit のみで HEAD~1 解決不能時は検証 skip (return 0)
  local base=""
  # shellcheck disable=SC1083
  if base=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null); then
    :
  elif git rev-parse HEAD~1 >/dev/null 2>&1; then
    base="HEAD~1"
  else
    return 0
  fi
  local new_adrs
  new_adrs=$(git diff --diff-filter=A --name-only "${base}...HEAD" 2>/dev/null | grep '^docs/adr/.*\.md$' || true)
  while IFS= read -r adr; do
    [ -z "$adr" ] && continue
    local fname
    fname=$(basename "$adr")
    [[ "$fname" == ".gitkeep" ]] && continue
    if ! grep -qF "$fname" "$OBSIDIAN_VAULT_DIR/adr-index.md" 2>/dev/null; then
      ERRORS+=("ADR index 未反映: 新規 ADR $adr が $OBSIDIAN_VAULT_DIR/adr-index.md に未追加です")
    fi
  done <<< "$new_adrs"
}

detect_orphan_glossary() {
  [ ! -d "$OBSIDIAN_VAULT_DIR/glossary" ] && return 0
  local readme="$OBSIDIAN_VAULT_DIR/README.md"
  [ ! -f "$readme" ] && return 0
  local new_glossary
  new_glossary=$(find "$OBSIDIAN_VAULT_DIR/glossary" -name "*.md" -newer "$readme" 2>/dev/null | grep -v '\.gitkeep$' || true)
  while IFS= read -r gloss; do
    [ -z "$gloss" ] && continue
    local concept
    concept=$(basename "$gloss" .md)
    if ! grep -rq "glossary_refs:.*$concept" docs/specs/ 2>/dev/null && \
       ! grep -rqE "(^- $concept\$|^  - $concept\$)" docs/specs/ 2>/dev/null; then
      WARNINGS+=("Orphan glossary: $gloss はいずれの spec の glossary_refs からも参照されていません")
    fi
  done <<< "$new_glossary"
}

report_errors_and_warnings() {
  if [ ${#ERRORS[@]} -gt 0 ] || [ ${#WARNINGS[@]} -gt 0 ]; then
    echo "========================================"
    echo " pre-push: Obsidian 同期チェック"
    echo "========================================"
    for err in "${ERRORS[@]}"; do
      echo "[ERROR]   $err"
    done
    for warn in "${WARNINGS[@]}"; do
      echo "[WARN]    $warn"
    done
    echo ""
    echo "規約の詳細は ~/.claude/CLAUDE.md §Obsidian (Scope-Shared Vaults) を参照してください。"
  fi
  if [ ${#ERRORS[@]} -gt 0 ]; then
    exit 1
  fi
  exit 0
}

main() {
  check_requirements
  validate_spec_yaml_and_concepts
  validate_spec_symlink
  validate_adr_index_entry
  detect_orphan_glossary
  report_errors_and_warnings
}

main "$@"
