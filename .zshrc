export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/Library/Developer/flex_sdk_4.6.0.23201_mpl/bin:$PATH"
export PATH="/Library/Developer/AdobeAIRSDK/bin:$PATH"
export PATH="/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zen"

#{{{ SSH
alias francoiscogne='ssh francoisxx@ftp.francoiscogne.com'
alias lina='ssh vincent@192.168.1.25'
alias mini='ssh vincent@192.168.1.23'
alias linda='ssh xpac27@fbx.abernier.name'
alias zaptele='ssh zaptele@188.165.239.57'
alias nodog='ssh zaptele@62.210.137.159'
alias bonplan='ssh alertebo@ssh.cluster006.ovh.net'

#{{{ Rails
alias rc="pry -r ./config/environment"

#{{{ Logs
alias fl='tail -F ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'

#{{{ Backups
#alias backup='cd /Volumes/HD\ External/Scripts/ && ./backup_kimsuffi.sh && cd -'
#alias veoday_backup='cd /Volumes/HD\ External/Scripts/ && ./backup_veoday.sh && cd -'

#{{{ Mongodb
alias mongod_repair='sudo rm -f /var/lib/mongodb/mongod.lock && mongod --repair --dbpath /var/lib/mongodb/'

#{{{ Elastic search
alias elasticsearch_start='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.19.3/config/elasticsearch.yml'

#{{{ Redis
alias redis_start='redis-server /usr/local/etc/redis.conf'

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

export LC_CTYPE=en_US.UTF-8

set ttymouse=sgr

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
