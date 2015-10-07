# INSTALL TOOLS

## BREW
## ---------------------------------------------------------------------------------
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
bew update
brew install cmake git llvm ack
brew doctor

## RVM
## ---------------------------------------------------------------------------------
curl -sSL https://get.rvm.io | bash -s stable --ruby

## Python
## ---------------------------------------------------------------------------------
sudo easy_install pip

## ZSH
## ---------------------------------------------------------------------------------
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## LLVM
## ---------------------------------------------------------------------------------
echo "# LLVM" >> ~/.profile
echo "export PATH=\"$PATH:/usr/local/Cellar/llvm/3.6.2/bin/\"" >> ~/.profile

## Hack Font
## ---------------------------------------------------------------------------------
curl -LO https://github.com/chrissimpkins/Hack/releases/download/v2.015/Hack-v2_015-ttf.zip
unzip Hack-v2_015-ttf.zip -d .
mv Hack-* /Users/vinz/Library/Fonts
pip install --user powerline-status

## FLEX SDK
## ---------------------------------------------------------------------------------
curl -LO "http://download.macromedia.com/pub/flex/sdk/flex_sdk_4.6.zip"
curl -LO "http://hasseg.org/stuff/fcshctl/fcshctl-v0.5.1.zip"
unzip flex_sdk_4.6.zip -d ~/Applications/
unzip fcshctl-v0.5.1.zip -d ~/Applications/
rm flex_sdk_4.6.zip
rm fcshctl-v0.5.1.zip
sed -i'' -e '46,48 s/^/#/' ~/Applications/flex_sdk_4.6/bin/mxmlc
sed -i'' -e '46,48 s/^/#/' ~/Applications/flex_sdk_4.6/bin/fcsh
echo "# Flex SDK" >> ~/.profile
echo "export FLEX_HOME=\"$HOME/Applications/flex_sdk_4.6\"" >> ~/.profile
echo "export PATH=\"$PATH:$FLEX_HOME/bin\"" >> ~/.profile
echo "export PATH=\"$PATH:$HOME/Applications/fcshctl-v0.5.1\"" >> ~/.profile
sudo mkdir "/Library/Application Support/Macromedia"
sudo echo "ErrorReportingEnable=1
TraceOutputFileEnable=1" >> mm.cfg
mv mm.cfg "/Library/Application Support/Macromedia/"

## APACHE
## ---------------------------------------------------------------------------------
sudo echo "<Directory "/Users/vinz/Sites/">
    Options Indexes Multiviews FollowSymLinks
    AllowOverride AuthConfig Limit
    Order allow,deny
    Allow from all
    Require all granted
</Directory>" >> vinz.conf
sudo mv vinz.conf /etc/apache2/users/vinz.conf
sudo sed -i'' -e '493 s/^#//' /private/etc/apache2/httpd.conf
sudo sed -i'' -e '166 s/^#//' /private/etc/apache2/httpd.conf
sudo sed -i'' -e '16 s/^#//' /etc/apache2/extra/httpd-userdir.conf
launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
sudo apachectl start
chmod go-rwx ~/Sites
chmod go+x ~/Sites
sudo chgrp -R _www ~/Sites
chmod -R go-rwx ~/Sites
chmod -R g+rx ~/Sites

## JAVA
## ---------------------------------------------------------------------------------
echo "# JAVA" >> ~/.profile
echo "-export JAVA_HOME=\"$(/usr/libexec/java_home)\"" >> ~/.profile
/usr/libexec/java_home --request
