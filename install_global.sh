#!/bin/sh -x

sudo apt-get install libncurses5-dev
wget 'http://tamacom.com/global/global-6.5.tar.gz'
tar xzvf global-6.5.tar.gz 
cd global-6.5/

./configure --prefix=/usr/local/stow/global-6.5
make -j
sudo make install
cd /usr/local/stow/
sudo stow global-6.5/
