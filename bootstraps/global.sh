#!/bin/sh

ORIG=$CWD
VERSION=global-6.5
TARBALL=${VERSION}.tar.gz
DEST=/usr/local/stow/${VERSION}

cd /tmp
wget http://tamacom.com/global/${TARBALL}
tar xzf ${TARBALL}
cd ${VERSION}
mkdir -p /usr/local/stow
./configure --disable-gtagscscope --prefix=${DEST}
make -j install

# Cleanup
rm -f ${TARBALL}
cd ${ORIG}

echo ""
echo "=========================="
echo "Installed in ${DEST} use Stow to do the rest"
