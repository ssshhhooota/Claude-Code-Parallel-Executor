# Claude Code Parallel Executor

> 🚀 複数の Claude Code インスタンスを tmux 上で並列実行し、効率的なタスク分散処理を実現するツール

## 🎯 概要

Claude Code Parallel Executor は、1つのマネージャーが複数のワーカーを管理・調整することで、大規模なタスクを並列処理できるシステムです。tmux セッション内で動作し、Claude Code の能力を最大限に活用します。

## ✨ 主要機能

- 🔄 **並列処理**: 複数の Claude Code ワーカーによる同時タスク実行
- 🎯 **タスク管理**: マネージャーによる作業の分配と進捗管理
- 💬 **リアルタイム通信**: ワーカー間でのメッセージ送受信
- 📊 **作業報告**: 各ワーカーの作業結果を自動的に収集・レポート
- 🖥️ **tmux 統合**: tmux セッションによる効率的なターミナル管理

## 📁 ディレクトリ構成

```
Claude-Code-Parallel-Executor/
├── .claude/                    # Claude Code 設定
│   └── commands/
│       └── parallel.md         # /parallel コマンド定義
├── instructions/               # 指示書ファイル
│   ├── manager.md              # マネージャー用指示書
│   ├── worker.md               # ワーカー用指示書
│   └── tmux.md                 # tmux 使用例
├── scripts/                    # 実行スクリプト
│   ├── create-worker.sh        # ワーカー作成
│   ├── delete-worker.sh        # ワーカー削除
│   ├── list-worker.sh          # ワーカー一覧表示
│   └── send-message.sh         # メッセージ送信
├── tmp/                        # 一時ファイル・作業結果
│   └── <ユニークID>/
│       ├── worker[N].md        # 各ワーカーの作業記録
│       └── summary.md          # 最終報告書
└── CLAUDE.md                   # プロジェクト指示書
```

## 🚀 クイックスタート

### 1. 環境準備

```bash
# tmux セッション作成 & Claude Code 起動
tmux new-session -d -s parallel-work
tmux send-keys -t parallel-work "claude" C-m
tmux attach -t parallel-work
```

### 2. 並列実行の開始

Claude Code 内で以下のコマンドを実行：

```bash
/parallel <実行したいタスク内容>
```

例：
```bash
/parallel プロジェクト内の全てのJavaScriptファイルをリファクタリングして、ESLintエラーを修正する
```

## 🏗️ システム構成

### 🎭 マネージャーの役割
- タスクの分析・分解
- ワーカーへの作業指示
- 進捗監視・調整
- 最終報告の作成

### 👷 ワーカーの役割
- 割り当てられたタスクの実行
- 作業進捗の報告
- 成果物の記録・保存

## 🔧 主要スクリプト

### ワーカー管理

```bash
# ワーカー作成（指定数のワーカーパネルを作成）
./scripts/create-worker.sh <ワーカー数> <ユニークID>

# ワーカー一覧表示
./scripts/list-worker.sh

# 全ワーカー削除
./scripts/delete-worker.sh
```

### メッセージ送信

```bash
# 指定パネルにメッセージ送信
./scripts/send-message.sh <パネルインデックス> "<メッセージ>"
```

## 📊 パネル操作・情報取得

```bash
# ワーカーのパネルインデックス取得
tmux list-panes -F "#{pane_index} #{pane_title}" | grep worker

# マネージャーのパネルインデックス取得
tmux list-panes -F "#{pane_index} #{pane_title}" | grep manager

# 現在のパネルインデックス取得
tmux display-message -p "#{pane_index}"

# 全パネル一覧表示
tmux list-panes -F "#{pane_index} #{pane_title}"
```

## 📋 作業結果・レポート

各実行では `tmp/<ユニークID>/` ディレクトリに以下が生成されます：

- `worker[N].md`: 各ワーカーの詳細な作業記録
- `summary.md`: マネージャーによる全体の最終報告

## 💡 活用例

- 🔄 **大規模リファクタリング**: 複数ファイルの同時改修
- 🧪 **テスト作成**: 各機能のテストを並列作成
- 📚 **ドキュメント生成**: API ドキュメントの分散生成
- 🎨 **コード品質改善**: ESLint/Prettier の一括適用
- 🔍 **コードレビュー**: 複数モジュールの同時レビュー

## 🛠️ 必要な環境

- **tmux**: セッション管理
- **Claude Code CLI**: AI アシスタント
- **Bash**: スクリプト実行環境

## 🎮 使用方法の詳細

### 基本フロー

1. **タスク受信**: `/parallel` コマンドでタスクを指定
2. **タスク分解**: マネージャーがタスクを分析・分割
3. **ワーカー作成**: 必要数のワーカーパネルを自動生成
4. **作業実行**: 各ワーカーが並列でタスクを実行
5. **進捗管理**: マネージャーが全体の進捗を監視
6. **結果統合**: 完了後、結果をまとめて報告

### マネージャーとワーカーの通信

ワーカーからマネージャーへの報告：
```bash
scripts/send-message.sh $(tmux list-panes -F "#{pane_index} #{pane_title}" | grep manager | awk '{print $1}') "Worker1: タスク完了しました"
```

## 📄 ライセンス

MIT License
