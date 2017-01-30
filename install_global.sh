#!/bin/sh
#
# Global does support Python, you might need this
# plugin https://github.com/yoshizow/global-pygments-plugin
# if pygments is not already included in Global (which I think it is for
# the currently used version)
#

set -e

for need in stow make tar curl; do
	which $need > /dev/null 2>&1  || (echo "Need $need"; exit 1)
done

if [ ! -d "global-6.5" ]; then
	curl -O 'http://tamacom.com/global/global-6.5.tar.gz'
	tar xzvf global-6.5.tar.gz
fi
cd global-6.5/

./configure --prefix=/usr/local/stow/global-6.5
make -j
sudo make install
[ ! -d "/usr/local/stow" ] && mkdir -p /usr/local/stow
cd /usr/local/stow/
sudo stow global-6.5/
