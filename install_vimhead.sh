#!/bin/sh
#
# - get and install latest version of Vim
#

set -eu
DL_FOLDER="dl/vim"
INSTALL_FOLDER="/usr/local/stow/vim-HEAD"
if [ ! -d ${DL_FOLDER} ]; then
  git clone https://github.com/vim/vim.git ${DL_FOLDER}
fi

cd ${DL_FOLDER}/src/
git fetch -ap
git reset --hard origin/master
./configure --prefix=${INSTALL_FOLDER} --enable-pythoninterp
make -j install
