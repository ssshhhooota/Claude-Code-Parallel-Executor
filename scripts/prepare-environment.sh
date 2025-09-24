#!/bin/bash

WORKER_COUNT=$1
UNIQUE_ID=$2

echo "ワーカー数: $WORKER_COUNT"
echo "ユニークID: $UNIQUE_ID"
echo "環境構築中..."

# セッション名の変更
tmux rename-session $UNIQUE_ID

# managerパネルタイトル
tmux select-pane -T "manager"

# ワーカーパネル作成
for i in $(seq 1 $WORKER_COUNT); do
    tmux split-window -v -t $UNIQUE_ID
    tmux select-pane -T "worker$i"
    tmux select-layout -t $UNIQUE_ID tiled

    # workerのpane_idを取得する
    WORKER_PANE_ID=$(tmux list-panes -t $UNIQUE_ID -F '#{pane_id} #{pane_title}' | grep "worker$i" | awk '{print $1}')
    echo "Manager Pane ID: $MANAGER_PANE_ID"
    echo "Worker Pane ID: $WORKER_PANE_ID"
    tmux send-keys -t $WORKER_PANE_ID "claude" C-m
    sleep 0.5  # 少し待つ
done

tmux select-pane -t 1

# 環境構築完了
echo "環境構築完了。tmux attach -t $UNIQUE_ID"