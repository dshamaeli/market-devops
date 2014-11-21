#!/bin/bash

# install development tools
# only for bcrypt npm module
yum groupinstall -y 'development tools'

# install git from source
yum remove git

yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils perl-ExtUtils-MakeMaker
cd /usr/src
wget https://www.kernel.org/pub/software/scm/git/git-2.0.1.tar.gz
tar xzf git-2.0.1.tar.gz
cd git-2.0.1
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /root/.bashrc
source /root/.bashrc


# enable ssh with public key
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
restorecon -Rv ~/.ssh
# Disable password authentication forcing use of keys
# PasswordAuthentication no


# change prompt to have the git branch
mkdir ~/.bash && cd ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git


# Load nvm and install latest production node
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-with-nvm-node-version-manager-on-a-vps

# curl https://raw.github.com/creationix/nvm/master/install.sh | sh
rm -f install.sh* && wget https://raw.github.com/creationix/nvm/master/install.sh && sh install.sh

n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
# The above command is a bit complicated, but all it's doing is copying whatever version of node you have active via nvm into the /usr/local/ directory (where user installed global files should live on a linux VPS) and setting the permissions so that all users can access them.


# Using http instead of https
npm config set registry http://registry.npmjs.org/


npm install -g bower
npm install -g grunt-cli
npm install -g forever


#install mysql
sudo yum install mysql-server sudo /sbin/service mysqld start
#sudo /usr/bin/mysql_secure_installation
mysqladmin -u root password 'new-password'

# open port 9000
iptables -I INPUT 1 -p tcp --dport 9000 -j ACCEPT
