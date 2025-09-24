#!/bin/bash

# 引数: 送信先のpane index, 送信するメッセージ
PANE_INDEX=$1
MESSAGE=$2


echo "📤 送信中: $PANE_INDEX ← '$MESSAGE'"
tmux send-keys -t $PANE_INDEX C-c
sleep 0.3
tmux send-keys -t $PANE_INDEX "$MESSAGE"
sleep 0.1
tmux send-keys -t $PANE_INDEX C-m
sleep 0.5