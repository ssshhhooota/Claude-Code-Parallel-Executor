#!/bin/bash

tmux list-panes -F '#{pane_id}' | grep -v $(tmux display-message -p '#{pane_id}') | xargs -I {} tmux kill-pane -t {}