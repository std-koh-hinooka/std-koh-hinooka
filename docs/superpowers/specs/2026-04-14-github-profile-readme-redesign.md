# GitHub プロフィール README リデザイン設計書

## 概要

GitHub プロフィール README を CTO の名刺として機能するリッチなデザインに刷新する。capsule-render バナーで視覚的インパクトを出しつつ、HTML レイアウトでセクションを整形する。テーマカラーは tokyonight で全体を統一する。

## 対象読者

- OSS コントリビューター
- 外部開発者
- 名刺代わりとしてプロフィールを閲覧する人

## デザイン方針

- capsule-render バナー（ヘッダー・フッター）+ HTML 中央寄せレイアウトを組み合わせる
- tokyonight 配色（背景: `#1a1b27`、アクセント青: `#70a5fd`、ティール: `#38bdae`、テキスト: `#a9b1d6`）で統一する
- 外部サービスへの依存を最小限に抑え、安定して表示される構成にする

## セクション構成

### 1. ヘッダーバナー + 自己紹介

capsule-render のウェーブバナーを最上部に配置する。バナー内に名前「Koshiro Hinooka」と「CTO | Infrastructure of Ideas」をレンダリングする。直下に一言自己紹介を中央寄せで配置する。

- バナー: capsule-render waving タイプ、高さ 200px
- グラデーション: `#1a1b27` → `#70a5fd` → `#38bdae`
- 一言自己紹介: 「アイデアが最もスムーズに流れる土台を設計し、負債を一切作らせない」

### 2. Tech Stack

shields.io バッジを中央寄せで配置する。Languages と Infrastructure の2カテゴリに分ける。バッジスタイルは `flat-square` を使用する。

Languages（12言語、系統順）:
C, C++, C#, F#, Rust, Go, Python, TypeScript, JavaScript, Java, Ruby, PHP

Infrastructure（3サービス）:
AWS, GCP, Docker

### 3. Philosophy

引用ブロック（`>`）を中央寄せで配置する。「怠惰・傲慢・短気」を冒頭に太字で記載し、続けて哲学テキストを配置する。現在 h1 タイトルにあるテキストと Philosophy セクションのテキストを1つの引用ブロックに統合する。

### 4. Stats

github-readme-stats の Stats カードと streak-stats の Streak Stats カードを横並びで中央寄せに配置する。

- Stats カード: `include_all_commits=true` で全期間のコミット数を表示する。`show` パラメータは使用しない（項目過多による字の縮小を防ぐ）
- Streak Stats カード: `streak-stats.demolab.com` を使用する
- 両カードの高さ: 195px
- テーマ: tokyonight、枠なし

### 5. フッターバナー

capsule-render のウェーブバナーを `section=footer` で配置する。ヘッダーと同じグラデーション配色を使用する。テキストなし、高さ 120px でヘッダーより控えめにする。

## 外部サービス依存一覧

| サービス | 用途 | GitHub API 使用 | 安定性 |
|----------|------|-----------------|--------|
| capsule-render | ヘッダー・フッターバナー | なし | 高 |
| shields.io | Tech Stack バッジ | なし | 高 |
| github-readme-stats（自前 Vercel） | Stats カード | あり（自前 PAT） | 高 |
| streak-stats.demolab.com | Streak Stats カード | あり（公開インスタンス） | 中 |

## 変更対象ファイル

- `README.md`: 全面リデザイン
