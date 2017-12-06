#!/bin/sh
#
# - get and install latest version of RTags
#

set -eu

DL_FOLDER="dl/rtags"
INSTALL_FOLDER=/usr/local/stow/rtags-HEAD
if [ ! -d ${DL_FOLDER} ]; then
  git clone --recursive https://github.com/Andersbakken/rtags.git ${DL_FOLDER}
fi

cd ${DL_FOLDER}
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_INCLUDE_PATH=/usr/lib/llvm-3.5/include/ .
make

echo "Done compiling in ${DL_FOLDER}"
