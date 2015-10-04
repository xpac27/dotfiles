# INSTALL TOOLS

## BREW
## ---------------------------------------------------------------------------------
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cmake git llvm

## RVM
## ---------------------------------------------------------------------------------
curl -sSL https://get.rvm.io | bash -s stable --ruby

## ZSH
## ---------------------------------------------------------------------------------
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## FLEX SDK
## ---------------------------------------------------------------------------------
cur -O "http://download.macromedia.com/pub/flex/sdk/flex_sdk_4.6.zip"
cur -O "http://hasseg.org/stuff/fcshctl/fcshctl-v0.5.1.zip"
unzip flex_sdk_4.6.zip -d ~/Applications/
unzip fcshctl-v0.5.1.zip -d ~/Applications/
rm flex_sdk_4.6.zip
rm fcshctl-v0.5.1.zip
echo "# Flex SDK" >> ~/.profile
echo "export FLEX_HOME=\"$HOME/Applications/flex_sdk_4.6\"" >> ~/.profile
echo "export PATH=\"$PATH:$FLEX_HOME/bin\"" >> ~/.profile
echo "export PATH=\"$PATH:$HOME/Applications/fcshctl-v0.5.1\"" >> ~/.profile
