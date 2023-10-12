export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# Start X at login
if status is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty
  end
end

# direnv
eval (direnv hook fish)

# local bin
set PATH $HOME/.local/bin $PATH
set PYTHONPATH $HOME/.local $PYTHONPATH 

# systemd
export SYSTEMD_EDITOR='vim'

# dracula
# fish_config theme choose "nord"

# nnn
alias n='nnn -QAeodax'
alias na='nnn -QAHeodax'
export NNN_COLORS='3333'
export NNN_PLUG='o:fzopen;d:fzcd;v:imgview;p:preview-tabbed'
export NNN_FIFO=/tmp/nnn.fifo

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
#alias suspend="systemctl suspend"
#alias sleep="systemctl hybrid-sleep"
alias hibernate="systemctl hibernate"

# Exa
alias ll="exa -lh --icons --group-directories-first --git-ignore --no-permissions --no-user --git"
alias lg="exa -lhG --icons --group-directories-first --git-ignore --no-permissions --no-user --git"
alias lt="exa -lhT --icons --group-directories-first --git-ignore --no-permissions --no-user --git"
alias la="exa -lha --icons --group-directories-first --git"
alias lga="exa -lhGa --icons --group-directories-first --git"
alias lta="exa -lhTa --icons --group-directories-first --git"

# Ripgrep
alias rg="rg --colors 'match:fg:black' --colors 'match:bg:yellow' --colors 'line:style:bold' --colors 'line:fg:yellow' --colors 'path:fg:green' --colors 'path:style:bold'"

# Key bindings
# fish_vi_key_bindings

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.tup,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF Dracula - https://draculatheme.com/fzf
# export FZF_DEFAULT_OPTS='
#     --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
#     --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
#     --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
#     --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# FZF Nord scheme - https://github.com/ianchesal/nord-fzf
# export FZF_DEFAULT_OPTS='
#     --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1
#     --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1
#     --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
#     --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# FZF Monochrome
export FZF_DEFAULT_OPTS='
  --color=bg:#1a1a1a,bg+:#2e2e2e,spinner:#dd9922,hl:#dd9922
  --color=fg:#919191,fg+:#ffffff,hl+:#eeee99,info:#ff9999
  --color=border:#4e4e4e,prompt:#ffffff,pointer:#dd9922
  --color=marker:#d7d7d7,header:#919191'

# FZF commands
alias Files="fzf --color=border:-1 --preview '[[ (file --mime {}) =~ binary ]] && echo {} is a binary file ;or (highlight -O ansi -l {}) 2> /dev/null | head -500' --preview-window right:65%"
alias GitLog=" git log --date=short --format=\"%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)\" --graph --color=always | fzf --color=border:-1 --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o \"[a-f0-9]\{7,\}\" <<< {} | xargs git show --color=always | head -'$LINES"

