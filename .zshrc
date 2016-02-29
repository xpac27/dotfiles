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

# Make FZF use AG
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Hide mouse
set ttymouse=sgr

# Random shortcuts
alias rc="pry -r ./config/environment"
alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'
alias v='vim -p $(fzf -m)'

# SVN shortcuts
alias svnd='svn diff --no-diff-deleted --show-copies-as-adds | colordiff | less'
alias svnl='svn log | less'
alias svns='colorsvn status'
alias svndiff='svn diff --diff-cmd=/Users/vincent.cogne/svndiff.sh'

# Ctags
alias ctags-refresh='rm -f ./.git/tags && find `pwd` \( -name "*.c" -or -name "*.h" -or -name "*.cpp" -or -name "*.hpp" \) -exec ctags --append=yes -f ./.git/tags {} \;'


# Copy paste
alias cc='pbcopy'
alias pp='pbpaste'

# FZF Git commit browser
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
    --bind "ctrl-m:execute:
      echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R'"
}

# Add RVM to PATH for scripting
[[ -d "$HOME/.rvm" ]] && PATH=$PATH:$HOME/.rvm/bin

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# added by travis gem
[ -f /Users/vinz/.travis/travis.sh ] && source /Users/vinz/.travis/travis.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
