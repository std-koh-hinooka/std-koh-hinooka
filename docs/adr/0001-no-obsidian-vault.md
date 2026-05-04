# ADR 0001: Obsidian vault 不要の判断

**Date**: 2026-05-04
**Status**: Accepted

## Context

`std-koh-hinooka` プロジェクトは GitHub Profile README 用の単一 OSS プロジェクトで、
他 project と用語共有が永続的に発生せず、scope を独立で立てるほどの spec 量も持たない。

グローバル CLAUDE.md (§Scope Catalog) では原則「1 scope = 1 vault」だが、
本 project は例外として「vault 不要」運用とする。

## Decision

本 project は以下 3 条件を満たすため、グローバル CLAUDE.md §Scope Catalog 原則「1 scope = 1 vault」の例外として「vault 不要 project」運用を採択する:

1. **single OSS**: GitHub Profile README の単一管理 repository であり、他 project と統合する計画なし
2. **永続的な用語共有なし**: README コンテンツに使用される concept (CTO, capsule-render, tokyonight 等) は scope 横断で再利用される性質を持たない
3. **spec 量少**: 単一 spec (`github-profile-readme.md`) で完結し、scope 立ち上げコスト (vault 作成 + symlink 維持 + .envrc 設定) > glossary 集約のメリット

## Consequences

- `.envrc` で `OBSIDIAN_VAULT_DIR` / `OBSIDIAN_VAULT_NAME` は未設定
- pre-push Obsidian 同期 hook (`pre-push-obsidian-sync.sh`) は silent skip (exit 0)
- **不変条件**: 本 ADR が Active な期間、本 project の全 spec frontmatter `glossary_refs:` は **空配列 `[]` のみ** 許容 (vault 不在のため参照先が存在しない)。spec 作成・編集時は本不変条件を遵守すること
- 将来 scope 追加が必要になった場合は本 ADR を Superseded にし、新規 ADR で scope 立ち上げを記録する。同時に上記不変条件は失効し、`glossary_refs:` への concept 列挙が可能になる
- 機械的検証: `pre-push-obsidian-sync.sh` の `validate_spec_yaml_and_concepts` 関数で `glossary_refs` の concept ごとに vault 存在確認を行うが、`OBSIDIAN_VAULT_DIR` 未設定時はスクリプト全体が silent skip するため、本不変条件 (空配列のみ) は **人間レビュー** に委ねられる

## References

- グローバル CLAUDE.md §Obsidian (Scope-Shared Vaults), §Scope Lifecycle
- spec: `docs/specs/_uncategorized/github-profile-readme.md`
