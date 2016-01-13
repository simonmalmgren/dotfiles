# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="amuse"
plugins=(git, osx, brew)

# User configuration

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export PATH=/Users/solsson/bin:$PATH
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Aliases
alias g="git"
alias gs="git status -sb"
alias ctags="`brew --prefix`/bin/ctags"
alias ctg="git ls-files | grep -v .min.js | ctags -L - --languages=python,javascript"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
