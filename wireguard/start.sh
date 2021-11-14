if [ ! -z "${TMUX}" ]; then
  TMUX_CURRENT_SESSION=$(tmux display-message -p '#S')
  TMUX_CURRENT_WINDOW=$(tmux display-message -p '#I')

  tmux select-window -t $TMUX_CURRENT_WINDOW
  tmux split-window -v

  tmux select-pane -t 0
  tmux send-keys -t 0 C-z ENTER
  tmux send-keys -t 0 "docker-compose run peerA" ENTER

  tmux select-pane -t 1
  tmux send-keys -t 1 "docker-compose run peerB" ENTER
fi
