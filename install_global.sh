#!/bin/sh
#
# Global does support Python, if `gtags` complains about:
#   `gtags: cannot open shared object '/usr/local/lib/gtags/pygments-parser'.` 
# you might need this plugin https://github.com/yoshizow/global-pygments-plugin
# if pygments is not already included in Global (which I think it is for
# the currently used version)
#

set -e

VERSION=6.6.3

for need in stow make tar curl; do
	which $need > /dev/null 2>&1  || (echo "Need $need"; exit 1)
done

if [ ! -d "global-${VERSION}" ]; then
	curl -O "ftp://ftp.gnu.org/pub/gnu/global/global-${VERSION}.tar.gz"
	tar xzvf global-${VERSION}.tar.gz
fi
cd global-${VERSION}/

./configure --prefix=/usr/local/stow/global-${VERSION}
make -j
sudo make install
[ ! -d "/usr/local/stow" ] && mkdir -p /usr/local/stow
cd /usr/local/stow/
sudo stow global-${VERSION}
