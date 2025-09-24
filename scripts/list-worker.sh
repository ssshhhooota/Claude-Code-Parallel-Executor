#!/bin/bash

tmux list-panes -F "#{pane_index} #{pane_title}" | grep worker
