# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zen"


# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

set ttymouse=sgr

alias vi="/usr/local/bin/vim"
alias rc="pry -r ./config/environment"
alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'
alias de='ssh -A vincentc@dev4.int.midasplayer.com'
alias kd='ssh -A kingdom@kingdom.qa.midasplayer.com'

alias svnd='svn diff --no-diff-deleted --show-copies-as-adds | colordiff | less'
alias svnl='svn log | less'
alias svns='colorsvn status'
alias svndiff='svn diff --diff-cmd=/Users/vincent.cogne/svndiff.sh'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
