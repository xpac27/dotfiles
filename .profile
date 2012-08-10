export PATH="/Library/Developer/flex_sdk_4.6.0.23201_mpl/bin":$PATH
export PATH="/Library/Developer/AdobeAIRSDK/bin":$PATH
export PATH="/usr/local/bin":$PATH;

alias francoiscogne='ssh francoisxx@ftp.francoiscogne.com'
alias vincent='ssh vincent@91.121.195.230'
alias zaptele='ssh zaptele@188.165.239.57'
alias bonplan='ssh alertebo@ssh.cluster006.ovh.net'

alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'

alias mongostart='mongod run --config /usr/local/Cellar/mongodb/2.0.4-x86_64/mongod.conf'
alias mongod_repair='sudo rm -f /var/lib/mongodb/mongod.lock && mongod --repair --dbpath /var/lib/mongodb/'

alias elasticstart='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.19.3/config/elasticsearch.yml'
alias elasticstop='launchctl unload -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist'

alias backup='cd /Volumes/HD\ External/Scripts/ && ./backup_kimsuffi.sh && cd -'

if [ -f ~/Github/vis/vis.sh ]; then
   source ~/Github/vis/vis.sh
fi

if [ -f ~/.rvm/scripts/rvm ]; then
    source ~/.rvm/scripts/rvm
fi

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export RUBYOPT=''
export LANG=en_US.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm*|rxvt*)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\ [\\\\\1]\/`\[\033[37m\]\[\033[00m\] '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
*)
esac
