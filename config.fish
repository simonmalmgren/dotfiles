alias g="git"
alias gs="git status -sb"
alias gl="git log"
alias gp="git pull"
alias japaleno="git reset HEAD --hard"
alias ctags="`brew --prefix`/bin/ctags"
alias ctg="git ls-files | grep -v .min.js | ctags -L - --languages=python,javascript"
set -U FZF_TMUX 1
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

#set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
