# Run setup.sh first

## Update Vundle
vim -c VundleUpdate -c quitall

## Compile command-t
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb 
make
cd -

## You Complete Me
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --gocode-completer

