# ==== REQUIRED

## Command Line Tools
## ---------------------------------------------------------------------------------
xcode-select --install

## BREW
## ---------------------------------------------------------------------------------
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install cmake git mercurial ack entr fzf ag cscope imagemagick gifsicle gs direnv
brew install ffmpeg --with-fdk-aac --with-x265 --with-libvorbis
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew doctor

## GEMS
## ---------------------------------------------------------------------------------
gem install screengif

## OH MY ZSH
## ---------------------------------------------------------------------------------
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## LLVM
## ---------------------------------------------------------------------------------
brew install homebrew/versions/llvm38
echo "# LLVM" >> ~/.profile
echo "export PATH=\"\$PATH:/usr/local/opt/llvm38/bin\"" >> ~/.profile
echo "export PATH=\"\$PATH:/usr/local/opt/llvm38/share/clang/tools/scan-build\"" >> ~/.profile

## Python
## ---------------------------------------------------------------------------------
sudo easy_install pip

## Hack Font
## ---------------------------------------------------------------------------------
curl -LO https://github.com/chrissimpkins/Hack/releases/download/v2.015/Hack-v2_015-ttf.zip
unzip Hack-v2_015-ttf.zip -d .
mv Hack-* /Users/vinz/Library/Fonts
pip install --user powerline-status

## Vim with 24-bit colors
## ---------------------------------------------------------------------------------
git clone git@github.com:vim/vim.git /tmp/vim
cd /tmp/vim/src
./configure \
  --enable-gui=no \
  --without-x \
  --enable-multibyte \
  --with-tlib=ncurses \
  --enable-cscope \
  --with-features=huge \
  --disable-nls \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-rubyinterp && make
sudo make install
cd -
echo "# Vim" >> ~/.profile
echo "alias vim=\"/usr/local/bin/vim\"" >> ~/.profile
echo "alias vi=\"/usr/local/bin/vim\"" >> ~/.profile
mkdir ~/.vim/swap
mkdir ~/.vim/backup


# ==== OPTIONAL

## RVM
## ---------------------------------------------------------------------------------
curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install 2.1.1

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
echo "export PATH=\"\$PATH:$FLEX_HOME/bin\"" >> ~/.profile
echo "export PATH=\"\$PATH:$HOME/Applications/fcshctl-v0.5.1\"" >> ~/.profile
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
echo "export JAVA_HOME=\"$(/usr/libexec/java_home)\"" >> ~/.profile
/usr/libexec/java_home --request
