#!/bin/sh
#
# - get and install latest version of Vim
#

set -eux
DL_FOLDER="dl/nvim"
INSTALL_FOLDER="/usr/local/stow/nvim-HEAD"
if [ ! -d ${DL_FOLDER} ]; then
  git clone https://github.com/neovim/neovim.git ${DL_FOLDER}
fi

cd ${DL_FOLDER}
rm -rf build
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${INSTALL_FOLDER}" CMAKE_BUILD_TYPE=Release
make install
