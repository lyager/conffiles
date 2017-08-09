# Run setup.sh first

## Update Vim-plug
nvim -c PlugUpgrade -c quitall
nvim -c PlugUpdate -c quitall

## You Complete Me
cd ~/.local/share/nvim/plugged/YouCompleteMe/
./install.py --clang-completer --gocode-completer
cd -

