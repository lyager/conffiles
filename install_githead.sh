#!/bin/sh
#
# - get and install latest version of Vim
#

set -eu

DL_FOLDER="dl/git"
INSTALL_FOLDER=/usr/local/stow/git-HEAD
if [ ! -d ${DL_FOLDER} ]; then
  git clone https://github.com/vim/vim.git ${DL_FOLDER}
fi

cd ${DL_FOLDER}
autoreconf
git fetch -ap
git reset --hard origin/master
./configure --prefix=${INSTALL_FOLDER}
make -j install
echo ""
echo "Download Git into ${DL_FOLDER} installed in ${INSTALL_FOLDER}"
