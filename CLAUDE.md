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

## Quick Start

```bash
# README.md ローカル preview (公開前確認)
grip README.md  # http://localhost:6419 で GitHub 風 markdown render

# プロフィール変更を公開 (commit message は日本語、Conventional Commits prefix のみ英語可)
git commit -m "feat: プロフィールに <変更内容> を追加する"
git push origin <branch>
gh pr create  # PR/ISSUE は public visible、機密含めない
```

## GitHub アカウント設定

本 repo は `std-koh-hinooka` user 専用。`.envrc` で commit author を分離:

- `GIT_AUTHOR_NAME=koh-hinooka` / `GIT_COMMITTER_EMAIL=...@std-koh-hinooka.users.noreply.github.com`
- 他 repo (主用 koh-hinooka account) と混同しないよう `direnv allow` 必須
- SSH host alias: `git@github.com-student:std-koh-hinooka/std-koh-hinooka.git`

## 開発ルール

グローバル CLAUDE.md (`~/.claude/CLAUDE.md`) の原則に従う。プロジェクト固有の例外なし。

## Gotchas

- **公開 repo**: ISSUE / PR / commit message / branch 名すべて public。秘匿情報を含めない
- **画像サービス依存**: capsule-render / shields.io / streak-stats.demolab.com が落ちると README が崩れる。github-readme-stats のみ自前 Vercel で安定性最高
- **`.gitignore` 最小構成**: 本 repo は `.gitignore` で secret 標準パターン (`.env`, `*.pem`, `credentials.json`, `*_rsa` 等) と OS 生成物のみカバー。新規パターンが必要になったら追記し、`.gitleaks.toml` の allowlist と二重で運用する

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
