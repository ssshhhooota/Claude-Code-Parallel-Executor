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

### 自分のpane index確認
```bash
tmux display-message -p "#{pane_index}"
```

### 全pane一覧表示
```bash
tmux list-panes -F "#{pane_index} #{pane_title}"
```

### Manager のpane index確認
```bash
tmux list-panes -F "#{pane_index} #{pane_title}" | grep manager
```

### Workerの のpane index確認
```bash
tmux list-panes -F "#{pane_index} #{pane_title}" | grep worker
```

### Workerへ指示出し
```bash
tmux send-keys -t {{ managerかworkerのpane index }} "claude code" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "# worker指示書" C-m
tmux send-keys -t {{ managerかworkerのpane index }} ""C-m
tmux send-keys -t {{ managerかworkerのpane index }} "## あなたの役割" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "あなたはworkerです。" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "managerから与えられたタスクを遂行してください。" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "## 作業報告" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "タスクが完了したら、managerに報告をしてください。" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "tmuxの manager pane がmanagerです。" C-m
tmux send-keys -t {{ managerかworkerのpane index }} "報告の際には、完了したタスクの内容と結果を明確に伝えてください。" C-m
```
