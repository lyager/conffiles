#!/bin/sh

set -e

for need in stow make tar wget; do
	which $need > /dev/null 2>&1  || (echo "Need $need"; exit 1)
done

if [ ! -d "global-6.5" ]; then
	wget 'http://tamacom.com/global/global-6.5.tar.gz'
	tar xzvf global-6.5.tar.gz
fi
cd global-6.5/

./configure --prefix=/usr/local/stow/global-6.5
make -j
sudo make install
[ ! -d "/usr/local/stow" ] && mkdir -p /usr/local/stow
cd /usr/local/stow/
sudo stow global-6.5/
