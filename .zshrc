ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gitster"

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

# Fix weird ssh keys errors (like backspace not working)
export TERM=xterm

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

# Machine
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias sleep="sudo systemctl suspend"
alias hibernate="sudo systemctl hybrid-sleep"

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
if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pip
if [ -d "$HOME/.local/bin" ]; then
  export PATH=$PATH:$HOME/.local/bin/
fi

# <<< VIM mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1
# >>>

# Load the default .profile
if [[ -s "$HOME/.profile" ]]; then
  source "$HOME/.profile"
fi

# Autostart X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
  sleep 1
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
