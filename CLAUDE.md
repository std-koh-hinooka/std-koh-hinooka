# std-koh-hinooka

## 概要

GitHub プロフィール README (`std-koh-hinooka` user の `README.md`) の管理 repository。CTO の名刺として機能するリッチなデザインを維持・改善する。

## 技術スタック

- Markdown + HTML (中央寄せレイアウト)
- 外部画像サービス: capsule-render, shields.io, github-readme-stats (自前 Vercel), streak-stats.demolab.com
- テーマ: tokyonight (`#1a1b27`, `#70a5fd`, `#38bdae`, `#a9b1d6`)

## プロジェクト構成

| パス | 役割 |
|---|---|
| `README.md` | プロフィール本体 (公開ページ) |
| `docs/specs/` | 仕様書 (機能単位) |
| `docs/plans/` | 実装計画 (branch 単位) |
| `docs/adr/` | Architecture Decision Records |
| `docs/ROADMAP.md` | マイルストーン管理 |
| `.github/` | PR/ISSUE template |
| `scripts/` | pre-commit / pre-push hook script |

## 開発ルール

グローバル CLAUDE.md (`~/.claude/CLAUDE.md`) の原則に従う。プロジェクト固有の例外なし。

## Obsidian vault

- **vault 不要 project** (理由: ADR `docs/adr/0001-no-obsidian-vault.md` 参照)
- `.envrc` で `OBSIDIAN_VAULT_DIR` / `OBSIDIAN_VAULT_NAME` は未設定
- pre-push Obsidian 同期 hook (`pre-push-obsidian-sync.sh`) は silent skip 動作

## 参照

- ロードマップ: `docs/ROADMAP.md` (Active マイルストーン管理)
- 仕様書: `docs/specs/{_uncategorized,<bounded-context>}/<feature-slug>.md` (機能単位 + frontmatter 必須)
- 実装計画: `docs/plans/<yyyy-MM-dd>-<branch>.md` (Branch-scoped)
- ADR: `docs/adr/NNNN-<title>.md`
- グローバル規約: `~/.claude/CLAUDE.md`
