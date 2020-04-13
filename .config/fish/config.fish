export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# Start X at login
if status is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
  end
end

# direnv
eval (direnv hook fish)

# local bin
set PATH $HOME/.local/bin $PATH

# rbenv
set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
status --is-interactive; and rbenv init - | source

# Rust
set PATH $HOME/.cargo/bin $PATH

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
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias suspend="systemctl suspend"
alias hibernate="systemctl hybrid-sleep"

# Exa
alias ll="exa -lh --git"
alias lg="exa -lhG --git"
alias lt="exa -lhT --git"
alias lla="exa -lha --git"
alias lga="exa -lhGa --git"
alias lta="exa -lhTa --git"

# Ripgrep
alias rg="rg --colors 'match:fg:black' --colors 'match:bg:yellow' --colors 'line:style:bold' --colors 'line:fg:yellow' --colors 'path:fg:green' --colors 'path:style:bold'"

# Key bindings
fish_vi_key_bindings

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.tup,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF commands
alias Files="fzf --color=border:-1 --preview '[[ (file --mime {}) =~ binary ]] && echo {} is a binary file ;or (highlight -O ansi -l {}) 2> /dev/null | head -500' --preview-window right:65%"
alias GitLog=" git log --date=short --format=\"%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)\" --graph --color=always | fzf --color=border:-1 --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o \"[a-f0-9]\{7,\}\" <<< {} | xargs git show --color=always | head -'$LINES"

starship init fish | source
