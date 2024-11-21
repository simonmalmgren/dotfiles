alias g="git"
alias gp="git pull"
alias gs="git status -sb"
alias gl="gcloud auth login --update-adc "
set -U FZF_TMUX 1
set -U EDITOR nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -g fish_user_paths "/usr/local/opt/elasticsearch@5.6/bin" $fish_user_paths
set -gx TERM screen-256color-bce;
fish_add_path /opt/homebrew/sbin
source "$HOME/.cargo/env"

function nvm
  bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent
