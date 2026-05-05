# ロードマップ

> **規約**: 本 ROADMAP は **常に 1 つ以上の Active マイルストーン** を持つ。Active 0 状態は禁止。
> 完了したマイルストーンは「完了済」セクションへ移動する。
> 詳細: `~/.claude/CLAUDE.md` §Milestone Specification

## Active マイルストーン

### v0.2.0 — docs 構造 migration とプロフィール継続改善

**目標日**: 2026-05-31
**開始日**: 2026-05-04

#### 含まれる ISSUE と spec

| ISSUE | spec | 状態 |
|---|---|---|
| [#9](https://github.com/std-koh-hinooka/std-koh-hinooka/issues/9) docs 構造全面改修 (vault 不要 pilot) | `docs/specs/_uncategorized/github-profile-readme.md` | [x] |

<!--
更新ルール (CLAUDE.md §post-merge follow-up checklist 参照):
- 機能完了 PR merge 後: 該当行の `[ ]` を `[x]` に更新
- 仕様変更 (scope/粒度/遅延/前倒し/キャンセル): 該当行を直接編集
- ISSUE/spec 追加: 行追加 (PR で commit)
- 全行 [x] 達成: §Milestone Specification の完了条件 を実施し本セクションを「完了済」へ mv
-->

## 完了済

### v0.1.0 — プロフィール README リデザイン

**完了日**: 2026-04-14
**git tag**: (該当なし、本 PR 以前の運用ではマイルストーン仕様未導入のため tag を遡及付与しない)
**リリース ADR**: (該当なし、同上)

#### 含まれた ISSUE と spec

| ISSUE | spec | 状態 |
|---|---|---|
| [#7](https://github.com/std-koh-hinooka/std-koh-hinooka/issues/7) GitHub プロフィール README リデザイン | `docs/specs/_uncategorized/github-profile-readme.md` | [x] |

## 参照

- 実装計画: `docs/plans/` (Branch-scoped: `<yyyy-MM-dd>-<branch>.md`)
- 仕様書: `docs/specs/` (Feature-unit: `{_uncategorized,<bounded-context>}/<feature-slug>.md`)
- ADR: `docs/adr/` (`NNNN-<title>.md`)
- マイルストーン仕様: `~/.claude/CLAUDE.md` §Milestone Specification
- post-merge checklist: `~/.claude/CLAUDE.md` §post-merge follow-up checklist
