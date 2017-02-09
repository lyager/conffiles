#!/bin/sh
#
# - get and install latest version of Vim
#

if [ ! -d vim ]; then
  git clone https://github.com/vim/vim.git
fi

cd vim/src/
git fetch -ap
git reset --hard origin/master
./configure --prefix=/usr/local/stow/vim-HEAD --enable-pythoninterp
make install
