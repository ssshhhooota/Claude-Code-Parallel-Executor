## tmux コマンドの例
### tmux session 作成の例
```sh
tmux new-session -d -s {{uniqueID}}
tmux rename-window -t {{uniqueID}}:0 'manager'
tmux select-pane -T "manager"
```
### worker作成の例
```sh
for i in $(seq 1 $WORKER_COUNT); do
  tmux split-window -v -t {{uniqueID}}
  tmux select-pane -T "worker$i"
  tmux select-layout -t tiled
done
```
### send-keysコマンドの例
```sh
tmux send-keys -t {{uniqueID}}:0.1 "claude code" C-m
tmux send-keys -t {{uniqueID}}:0.1 "# worker指示書" C-m
tmux send-keys -t {{uniqueID}}:0.1 ""C-m
tmux send-keys -t {{uniqueID}}:0.1 "## あなたの役割" C-m
tmux send-keys -t {{uniqueID}}:0.1 "あなたはworkerです。" C-m
tmux send-keys -t {{uniqueID}}:0.1 "managerから与えられたタスクを遂行してください。" C-m
tmux send-keys -t {{uniqueID}}:0.1 "" C-m
tmux send-keys -t {{uniqueID}}:0.1 "## 作業報告" C-m
tmux send-keys -t {{uniqueID}}:0.1 "タスクが完了したら、managerに報告をしてください。" C-m
tmux send-keys -t {{uniqueID}}:0.1 "tmuxの manager pane がmanagerです。" C-m
tmux send-keys -t {{uniqueID}}:0.1 "報告の際には、完了したタスクの内容と結果を明確に伝えてください。" C-m
```
