alias g="git"
alias gs="git status -sb"
alias ctags="`brew --prefix`/bin/ctags"
alias ctg="git ls-files | grep -v .min.js | ctags -L - --languages=python,javascript"
alias garn="yarn"
set -U FZF_TMUX 1
set -U EDITOR vim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -g fish_user_paths "/usr/local/opt/qt@5.5/bin" $fish_user_paths
status --is-interactive; and source (rbenv init -|psub)
