#!/bin/sh

sudo apt-get install -y git
git clone http://192.168.1.151/develop/devops
cd devops
sh ./setup.sh
