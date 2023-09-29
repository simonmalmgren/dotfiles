alias g="git"
alias gs="git status -sb"
set -U FZF_TMUX 1
set -U EDITOR vim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -g fish_user_paths "/usr/local/opt/elasticsearch@5.6/bin" $fish_user_paths
set -gx TERM screen-256color-bce;
fish_add_path /opt/homebrew/sbin
