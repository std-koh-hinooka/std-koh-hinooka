# GitHub プロフィール README リデザイン実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** GitHub プロフィール README を CTO の名刺として機能するリッチなデザインに刷新する

**Architecture:** capsule-render バナー（ヘッダー・フッター）と HTML 中央寄せレイアウトを組み合わせ、tokyonight 配色で全体を統一する。README.md 1ファイルの全面書き換えで完結する。

**Tech Stack:** GitHub Flavored Markdown, HTML (GitHub 対応サブセット), capsule-render, shields.io, github-readme-stats (自前 Vercel), streak-stats.demolab.com

---

## ファイル構成

- Modify: `README.md` — 全面リデザイン（既存内容を完全に置き換える）

---

### Task 1: GitHub ISSUE を作成しブランチを切る

**Files:**
- なし（Git 操作のみ）

- [ ] **Step 1: GitHub ISSUE を作成する**

```bash
gh issue create --title "feat: プロフィール README を CTO 名刺デザインにリデザインする" --body "## 概要

README.md を CTO の名刺として機能するリッチなデザインに全面リデザインする。

## 変更内容

- capsule-render ウェーブバナー（ヘッダー・フッター）を追加する
- 名前・役職・一言自己紹介を中央寄せで配置する
- Tech Stack バッジを中央寄せに変更し、6言語を追加する
- Philosophy セクションを引用ブロックに変更し、h1 タイトルのテキストと統合する
- Stats カードの表示項目を整理し、カードサイズを拡大する
- 全セクションを tokyonight 配色で統一する

## 設計書

docs/superpowers/specs/2026-04-14-github-profile-readme-redesign.md

## 変更対象

- README.md: 全面リデザイン"
```

- [ ] **Step 2: 作業ブランチを作成する**

```bash
git checkout main
git pull origin main
git checkout -b feat/<ISSUE番号>-profile-readme-redesign
```

ISSUE 番号は Step 1 の出力から取得する。

- [ ] **Step 3: コミットする**

設計書ファイルが未コミットの場合、先にコミットする。

```bash
git add docs/superpowers/specs/2026-04-14-github-profile-readme-redesign.md
git commit -m "docs: プロフィール README リデザインの設計書を追加する"
```

---

### Task 2: README.md を全面リデザインする

**Files:**
- Modify: `README.md`

- [ ] **Step 1: README.md を以下の内容で全面書き換える**

```markdown
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1a1b27,50:70a5fd,100:38bdae&height=200&section=header&text=Koshiro%20Hinooka&fontSize=36&fontColor=a9b1d6&fontAlignY=35&desc=CTO%20%7C%20Infrastructure%20of%20Ideas&descSize=16&descColor=70a5fd&descAlignY=55" width="100%" />

<div align="center">

### アイデアが最もスムーズに流れる土台を設計し、負債を一切作らせない

</div>

<div align="center">

## Tech Stack

### Languages

![C](https://img.shields.io/badge/-C-A8B9CC?style=flat-square&logo=c&logoColor=white)
![C++](https://img.shields.io/badge/-C%2B%2B-00599C?style=flat-square&logo=cplusplus&logoColor=white)
![C#](https://img.shields.io/badge/-C%23-239120?style=flat-square&logo=csharp&logoColor=white)
![F#](https://img.shields.io/badge/-F%23-378BBA?style=flat-square&logo=fsharp&logoColor=white)
![Rust](https://img.shields.io/badge/-Rust-000000?style=flat-square&logo=rust&logoColor=white)
![Go](https://img.shields.io/badge/-Go-00ADD8?style=flat-square&logo=go&logoColor=white)
![Python](https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=python&logoColor=white)
![TypeScript](https://img.shields.io/badge/-TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)
![JavaScript](https://img.shields.io/badge/-JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)
![Java](https://img.shields.io/badge/-Java-437291?style=flat-square&logo=openjdk&logoColor=white)
![Ruby](https://img.shields.io/badge/-Ruby-CC342D?style=flat-square&logo=ruby&logoColor=white)
![PHP](https://img.shields.io/badge/-PHP-777BB4?style=flat-square&logo=php&logoColor=white)

### Infrastructure

![AWS](https://img.shields.io/badge/-AWS-232F3E?style=flat-square&logo=amazonwebservices&logoColor=white)
![GCP](https://img.shields.io/badge/-GCP-4285F4?style=flat-square&logo=googlecloud&logoColor=white)
![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

</div>

<div align="center">

## Philosophy

> **怠惰・傲慢・短気**
>
> 面倒なことは、今すぐ、絶対に、直す。
> 土台を手抜きするな。手戻りは最大の負債だ。
>
> プログラマーの価値は、お金を生むことではない。
> 負債を減らすことだ。
>
> それができれば、一流。

</div>

<div align="center">

## Stats

<img src="https://github-readme-stats-std-koh-hinookas-projects.vercel.app/api?username=std-koh-hinooka&show_icons=true&theme=tokyonight&hide_border=true&include_all_commits=true" height="195" />
<img src="https://streak-stats.demolab.com?user=std-koh-hinooka&theme=tokyonight&hide_border=true" height="195" />

</div>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1a1b27,50:70a5fd,100:38bdae&height=120&section=footer" width="100%" />
```

ファイル末尾に改行を1つ含める。

- [ ] **Step 2: 差分を確認する**

```bash
git diff README.md
```

以下を確認する:
- h1 タイトル「怠惰・傲慢・短気」が削除されている
- capsule-render ヘッダーバナーが先頭に追加されている
- 自己紹介テキストが中央寄せで追加されている
- Tech Stack に C, C++, F#, Ruby, PHP, JavaScript の6言語バッジが追加されている
- Tech Stack 全体が `<div align="center">` で囲まれている
- Philosophy がコードブロックから引用ブロックに変更されている
- Stats カードから `show=reviews,prs_merged,prs_merged_percentage` が削除されている
- Stats カードの height が 195 に変更されている
- capsule-render フッターバナーが末尾に追加されている

- [ ] **Step 3: コミットする**

```bash
git add README.md
git commit -m "feat: プロフィール README を CTO 名刺デザインにリデザインする

capsule-render ウェーブバナー（ヘッダー・フッター）を追加した。
名前・CTO・一言自己紹介を中央寄せで配置した。
Tech Stack に6言語を追加し中央寄せに変更した。
Philosophy を引用ブロックに変更し h1 テキストと統合した。
Stats カードの表示項目を整理しサイズを拡大した。
全セクションを tokyonight 配色で統一した。"
```

---

### Task 3: プッシュして PR を作成・マージする

**Files:**
- なし（Git 操作のみ）

- [ ] **Step 1: リモートにプッシュする**

```bash
git push -u origin feat/<ISSUE番号>-profile-readme-redesign
```

- [ ] **Step 2: PR を作成する**

```bash
gh pr create --title "feat: プロフィール README を CTO 名刺デザインにリデザインする" --body "## Summary

- capsule-render ウェーブバナー（ヘッダー・フッター）を追加した
- 名前（日野岡 幸志郎）・CTO・一言自己紹介を中央寄せで配置した
- Tech Stack に C, C++, F#, Ruby, PHP, JavaScript の6言語バッジを追加し中央寄せに変更した
- Philosophy をコードブロックから引用ブロックに変更し、h1 タイトルのテキストと統合した
- Stats カードの表示項目を整理し（show パラメータ削除）、カードサイズを 165px → 195px に拡大した
- 全セクションを tokyonight 配色で統一した

## Test plan

- [ ] GitHub プロフィールページでヘッダーバナーが tokyonight 配色のグラデーションで表示されることを確認する
- [ ] 名前「Koshiro Hinooka」と「CTO | Infrastructure of Ideas」がバナー内に表示されることを確認する
- [ ] 一言自己紹介が中央寄せで表示されることを確認する
- [ ] Tech Stack バッジ 12言語 + 3インフラが中央寄せで表示されることを確認する
- [ ] Philosophy が引用ブロックとして左側にアクセントラインが付いた状態で表示されることを確認する
- [ ] Stats カードと Streak Stats カードが横並びで表示されることを確認する
- [ ] フッターバナーがページ末尾に表示されることを確認する

Closes #<ISSUE番号>" --base main
```

ISSUE 番号は Task 1 で作成した番号を使用する。

- [ ] **Step 3: ブラウザで PR のプレビューを確認する**

PR ページの Files changed タブで README.md のレンダリングプレビューを確認する。問題がなければ次のステップに進む。

- [ ] **Step 4: PR をマージする**

```bash
gh pr merge <PR番号> --merge
git checkout main
git pull origin main
```

- [ ] **Step 5: GitHub プロフィールページで最終確認する**

https://github.com/std-koh-hinooka にアクセスし、全セクションが設計どおりに表示されていることを確認する。
