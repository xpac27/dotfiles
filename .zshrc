ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zen"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"

plugins=(git ruby gem)

source $ZSH/oh-my-zsh.sh

# Configuration
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vi
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/vinz/bin:$PATH"

# Make FZF use AG
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Hide mouse
set ttymouse=sgr

# Random shortcuts
alias v='vim -p $(fzf -m)'
alias vi="vim"

# Awesome Git aliases
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias go='git checkout'
alias gpr='git pull --rebase'
alias gsu='git submodule update --recursive --init --jobs=4'

# FZF Git commit browser
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
    --bind "ctrl-m:execute:
      echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R'"
}

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pip
export PATH=$PATH:/home/$USER/.local/bin/

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Autostart X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
  sleep 1
fi
