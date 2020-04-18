ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gitster"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# DISABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"

plugins=(ruby gem vim-mode)

source $ZSH/oh-my-zsh.sh

# Configuration
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vi
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/vinz/.local/bin:/home/vinz/go/bin:$PATH"
export HISTSIZE=1000000
export SAVEHIST=1000000


# Fix weird ssh keys errors (like backspace not working)
# export TERM=xterm

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
# alias gc='git commit'
# alias go='git checkout'
# alias gpr='git pull --rebase'
# alias gsu='git submodule update --recursive --init --jobs=4'

# Machine
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias sleep="sudo systemctl suspend"
alias hibernate="sudo systemctl hybrid-sleep"

# Ripgrep
alias rg="rg --colors 'match:fg:black' --colors 'match:bg:yellow' --colors 'line:style:bold' --colors 'line:fg:yellow' --colors 'path:fg:green' --colors 'path:style:bold'"

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

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# >>>

# Autostart X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
  sleep 1
fi

# Play youtube videos
youtube() {
    youtube-dl -q -o- "$1" | ffplay -x 1920 -y 1080 -
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.tup,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

ff() {
    fzf --color=border:-1 --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {}) 2> /dev/null | head -500' --preview-window right:65%
}

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

gf() {
    is_in_git_repo || return

    git -c color.status=always status --short | fzf --color=border:-1 -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' | cut -c4- | sed 's/.* -> //'
}

gh() {
    is_in_git_repo || return

    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always | fzf --color=border:-1 --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES | grep -o "[a-f0-9]\{7,\}"
}


source /home/vinz/.config/broot/launcher/bash/br
