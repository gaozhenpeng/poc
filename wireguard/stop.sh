docker-compose down

TMUX_CURRENT_SESSION=$(tmux display-message -p '#S')
TMUX_CURRENT_WINDOW=$(tmux display-message -p '#I')
tmux select-window -t $TMUX_CURRENT_WINDOW
tmux select-pane -t 1
tmux send-keys -t 1 exit ENTER

tmux select-window -t $TMUX_CURRENT_WINDOW
tmux send-keys -t 0 "clear" ENTER
