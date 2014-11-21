#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

sudo apt-get install -y proxychains && sed s/socks.*/socks5\s127.0.0.1\s9150/ /etc/proxychains.conf

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl

# change prompt to have the git branch
mkdir ~/.bash && cd ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git

# curl https://raw.github.com/creationix/nvm/master/install.sh | sh
rm -f install.sh* && wget https://raw.github.com/creationix/nvm/master/install.sh && sh install.sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.24
nvm use v0.10.24

# Using http instead of https
npm config set registry http://registry.npmjs.org/

# Install jshint to allow checking of JS code within emacs
# http:/5A/jshint.com/
npm install -g jshint

npm install -g bower
npm install -g grunt-cli
npm install -g yo
npm install -g underscore

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
# sudo add-apt-repository -y ppa:cassou/emacs
# sudo apt-get -qq update
# sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
# wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
# cd $HOME
if [ -d ~/dotfiles/ ]; then
    mv ~/dotfiles ~/dotfiles.old
fi
if [ -d ~/.emacs.d/ ]; then
    mv ~/.emacs.d ~/.emacs.d~
fi

cp -r dotfiles/ ~/

cd $HOME
# git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

