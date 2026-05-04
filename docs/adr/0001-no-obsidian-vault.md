# ADR 0001: Obsidian vault 不要の判断

**Date**: 2026-05-04
**Status**: Accepted

## Context

`std-koh-hinooka` プロジェクトは GitHub Profile README 用の単一 OSS プロジェクトで、
他 project と用語共有が永続的に発生せず、scope を独立で立てるほどの spec 量も持たない。

グローバル CLAUDE.md (§Scope Catalog) では原則「1 scope = 1 vault」だが、
本 project は例外として「vault 不要」運用とする。

## Decision

`~/.claude/CLAUDE.md` §Scope Lifecycle の「vault 不要 project」例外運用を採択する。

## Consequences

- `.envrc` で `OBSIDIAN_VAULT_DIR` / `OBSIDIAN_VAULT_NAME` は未設定
- pre-push Obsidian 同期 hook (`pre-push-obsidian-sync.sh`) は silent skip (exit 0)
- spec frontmatter `glossary_refs:` は空配列のみ許容
- 将来 scope 追加が必要になった場合は本 ADR を Superseded にし、新規 ADR で scope 立ち上げを記録する

## References

- グローバル CLAUDE.md §Obsidian (Scope-Shared Vaults), §Scope Lifecycle
- spec: `docs/specs/_uncategorized/github-profile-readme.md`
