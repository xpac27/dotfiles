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
plugins=(git brew encode64 gem web-search)

source $ZSH/oh-my-zsh.sh

# Configuration
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vi
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Hide mouse
set ttymouse=sgr

# Random shortcuts
alias rc="pry -r ./config/environment"
alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'

# SVN shortcuts
alias svnd='svn diff --no-diff-deleted --show-copies-as-adds | colordiff | less'
alias svnl='svn log | less'
alias svns='colorsvn status'
alias svndiff='svn diff --diff-cmd=/Users/vincent.cogne/svndiff.sh'

# Add RVM to PATH for scripting
[[ -d "$HOME/.rvm" ]] && PATH=$PATH:$HOME/.rvm/bin

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# added by travis gem
[ -f /Users/vinz/.travis/travis.sh ] && source /Users/vinz/.travis/travis.sh
