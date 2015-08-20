#!/bin/sh
#
# $Id$

# sudo apt-get install global cmake stow ctags vim-nox

LNOPT="-s -n $@"    # -n for no-deref (don't jump into the directories)
                 # -s for softlink
                 # -i for interactive, prompt before removing.
		 # -f force
# Vim
#ln ${LNOPT} $PWD/vimfiles/vim ~/.vim
[ ! -e ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln ${LNOPT} $PWD/vimfiles/vimrc ~/.vimrc

# tmux
ln ${LNOPT} $PWD/tmux/tmux.conf ~/.tmux.conf

# zsh
ln ${LNOPT} $PWD/zshfiles/zshrc ~/.zshrc

# Bash
ln ${LNOPT} $PWD/bashfiles/bashrc ~/.bashrc
ln ${LNOPT} /usr/lib/git-core/git-sh-prompt ~/.git-prompt.sh
#ln ${LNOPT} $PWD/bashfiles/git-prompt.sh ~/.git-prompt.sh
#ln ${LNOPT} $PWD/bashfiles/git-completion.sh ~/.git-completion.sh
cd ~/
ln ${LNOPT} .bashrc .bash_profile
cd - > /dev/null

# Common files
ln ${LNOPT} $PWD/commonfiles/rc ~/.rc
   
# Conky
ln ${LNOPT} $PWD/conky/conkyrc ~/.conkyrc

# Screen
ln ${LNOPT} $PWD/screenfiles/screenrc ~/.screenrc

# Openbox
mkdir -p ~/.config/openbox
ln ${LNOPT} $PWD/openbox/rc.xml ~/.config/openbox/rc.xml

# Pypanel
ln ${LNOPT} $PWD/pypanel/pypanelrc ~/.pypanelrc

# Emacs
ln ${LNOPT} $PWD/emacs/emacs ~/.emacs
ln ${LNOPT} $PWD/emacs/emacs.d ~/.emacs.d

# Ratpoison
ln ${LNOPT} $PWD/ratpoison/ratpoisonrc ~/.ratpoisonrc

# Irssi
ln ${LNOPT} $PWD/irssi ~/.irssi
$(cd ~/.irssi/scripts/autorun; \
	ln ${LNOPT} ../trackbar.pl .; \
	ln ${LNOPT} ../hilightwin.pl .; \
)

# Git
ln ${LNOPT} $PWD/git/gitconfig ~/.gitconfig

# RTorrent
ln ${LNOPT} $PWD/rtorrent/rtorrentrc ~/.rtorrentrc


# Bin
if [ ! -e ~/bin ]; then
	mkdir ~/bin
fi
ln ${LNOPT} $PWD/bin/* ~/bin/
ln ${LNOPT} $PWD/bin/cscope-py ~/bin/pytags
