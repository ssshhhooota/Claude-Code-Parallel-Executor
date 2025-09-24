# Claude Code Parallel Executor

## 概要

Claude Code Parallel Executor は、tmux を使用して複数の Claude Code インスタンスを並列実行し、タスクを効率的に分散処理するツールです。1 つのマネージャーが複数のワーカーにタスクを割り当て、並列処理を行うことで作業効率を大幅に向上させます。

## 機能

- **並列処理**: 複数の Claude Code ワーカーによる同時タスク実行
- **タスク管理**: マネージャーによる作業の分配と進捗管理
- **リアルタイム通信**: ワーカー間でのメッセージ送受信
- **作業報告**: 各ワーカーの作業結果を自動的に収集・レポート
- **tmux 統合**: tmux セッションによる効率的なターミナル管理

## ディレクトリ構成

```
Claude-Code-Parallel-Executor/
├── .claude/
│   └── commands/
│       └── parallel.md      # 並列実行コマンド定義
├── instructions/          # 指示書ファイル
│   ├── manager.md         # マネージャー用指示書
│   ├── worker.md          # ワーカー用指示書
│   └── tmux.md    # tmux使用例
├── scripts/               # 実行スクリプト
│   ├── prepare-environment.sh    # 環境構築スクリプト
│   ├── send-message.sh           # メッセージ送信スクリプト
│   ├── instructions-to-workers.sh # ワーカーへの指示送信
│   └── report-to-manager.sh      # マネージャーへの報告
└── tmp/                   # 一時ファイル・作業結果
```

## 使用方法

### 1. 環境構築

tmux で session を作成して、session 内で claude code を起動してください。

```bash
tmux
claude
```

### 3. タスク遂行のための指示

```bash:claude
/parallel <タスク内容>
```

## マネージャーとワーカーの役割

### マネージャーの役割

- マネージャーパネルから各ワーカーにタスクを指示
- 進捗管理と作業調整
- 最終報告の作成

### ワーカーの役割

- 割り当てられたタスクの実行
- 作業結果の記録
- マネージャーへの報告

## 主要スクリプト

### prepare-environment.sh

```bash
./scripts/prepare-environment.sh <ワーカー数> <ユニークID>
```

指定された数のワーカーパネルを持つ tmux セッションを作成します。

### send-message.sh

```bash
./scripts/send-message.sh <パネルインデックス> "<メッセージ>"
```

指定されたパネルにメッセージを送信します。

## パネル操作

### パネルインデックスの取得

```bash
# ワーカーのパネルインデックス取得
tmux list-panes -F "#{pane_index} #{pane_title}" | grep worker | awk '{print $1}'

# マネージャーのパネルインデックス取得
tmux list-panes -F "#{pane_index} #{pane_title}" | grep manager | awk '{print $1}'

# 自分のパネルインデックス取得
tmux display-message -p "#{pane_index}"
```

## 作業報告

- 各ワーカーは作業完了後、`tmp/<ユニークID>/`ディレクトリに結果を記録
- マネージャーは最終的に`summary.md`に全体の報告をまとめ

## 利用例

1. 大規模なコードベースのリファクタリング
2. 複数ファイルの同時編集・テスト
3. 並列データ処理タスク
4. ドキュメント生成の分散処理

## 必要な環境

- tmux
- Claude Code CLI
- Bash shell

## ライセンス

This project is licensed under the MIT License.
