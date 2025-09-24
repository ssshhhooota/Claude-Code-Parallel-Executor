# 並列タスク実行コマンド

このコマンドは、与えられたタスクを複数のワーカーで並列実行するためのシステムです。

## 概要

1. **入力**: `$1` にタスクの内容が渡されます
2. **処理**: マネージャーにタスクを渡します
3. **出力**: マネージャーが完了したタスクのサマリを報告します

## 前提条件
### 必要なファイル
- `@instructions/manager.md` - マネージャーの動作指示
- `@instructions/worker.md` - ワーカーの動作指示
- `@instructions/tmux.md` - tmuxセッション管理の例

### 環境のクリーンアップ
実行前に、現在のpane以外を削除：

```bash
tmux list-panes -F '#{pane_id}' | grep -v $(tmux display-message -p '#{pane_id}') | xargs -I {} tmux kill-pane -t {}
```

## 実行開始
1. タスクに基づくユニークID作成
2. マネージャーの作成
3. マネージャーにタスクの依頼

### 1. タスクに基づくユニークID作成
ユニークIDを作成してください。
作成後、tmp/配下に{ユニークID}のディレクトリを作成してください。
```
tmp/
└── {uniqueID}/
```

`tmux rename-session {ユニークID}`でセッション名を変更してください

### 2. マネージャーの作成
`tmux select-pane -T "manager"` の実行

### 3. マネージャーにタスクの依頼
`@instructions/manager.md` の指示に従ってタスクを実行してください
