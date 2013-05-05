# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zen"

#{{{ SSH
alias francoiscogne='ssh francoisxx@ftp.francoiscogne.com'
alias vincent='ssh vincent@91.121.195.230'
alias lina='ssh vincent@192.168.1.17'
alias zaptele='ssh zaptele@188.165.239.57'
alias bonplan='ssh alertebo@ssh.cluster006.ovh.net'

#{{{ Rails
alias tall="testdrb -I test ./test/**/*_test.rb"
alias rc="pry -r ./config/environment"

#{{{ Logs
alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'

#{{{ Backups
#alias backup='cd /Volumes/HD\ External/Scripts/ && ./backup_kimsuffi.sh && cd -'
#alias veoday_backup='cd /Volumes/HD\ External/Scripts/ && ./backup_veoday.sh && cd -'

#{{{ Mongodb
alias mongostart='mongod run --rest --config /usr/local/Cellar/mongodb/2.0.4-x86_64/mongod.conf'
alias mongod_repair='sudo rm -f /var/lib/mongodb/mongod.lock && mongod --repair --dbpath /var/lib/mongodb/'

#{{{ Elastic search
alias searchstart='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.19.3/config/elasticsearch.yml'
alias searchstop='launchctl unload -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist'

#{{{ Redis
alias redisstart='redis-server /usr/local/etc/redis.conf'

#{{{ VIS
if [ -f ~/Github/vis/vis.sh ]; then
   source ~/Github/vis/vis.sh
fi

#{{{ Shell Conveniences
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'

#{{{ ZSH
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/heroku/bin:/usr/local/bin:/usr/local/Cellar/ruby/1.9.3-p125/bin:/Library/Developer/AdobeAIRSDK/bin:/Library/Developer/flex_sdk_4.6.0.23201_mpl/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin

export LC_CTYPE=en_US.UTF-8

set ttymouse=sgr