#!/bin/sh
#
# vim:noexpandtab:ts=2:sw=2

GIT_PROMPT=""
PIP=pip
if [ "$(uname -v | awk '{print $3}')" = "Debian" ]; then # Debian
	sudo apt-get update
	sudo apt-get install -y global \
		cmake \
		stow \
		ctags \
		vim-nox \
		stow \
		cscope \
		tig \
		xz-utils \
		g++ \
		python-dev \
		ruby-dev \
		ruby \
		tmux \
		jq \
		zsh
	GIT_PROMPT=/usr/lib/git-core/git-sh-prompt
elif [ "$(uname -v | awk '{print $1}')" = "Darwin" ]; then # OSX
	PIP=pip2 # Pip is gone on OSX
	brew update
	brew upgrade
	brew cask install macvim \
		osxfuse \
		1password \
		dropbox \
		virtualbox \
		shiftit \
		spotify \
		telegram \
		nvalt \
		evernote \
		firefox \
		wireshark \
		flux \
		appcleaner \
		vimr
	brew install tmux \
		htop \
		cmake \
		stow \
		jq \
		homebrew/fuse/encfs \
		openconnect \
		tig \
		git \
		pandoc \
		vim \
		iproute2mac \
		neovim
elif [ -e "/etc/redhat-release" ]; then # Redhat
	sudo yum update -y
	sudo yum install -y vim-enhanced \
		tmux \
		xz \
		cmake \
		cscope \
		ctags \
		ncurses-devel \
		stow \
		glibc-devel \
		ruby \
		ruby-devel \
		gcc-c++ \
		python-devel \
		tig \
		bash-completion \
		jq \
		the_silver_searcher \
		telnet \
		neovim \
	  zsh
  # Pygments are used by Gtags to parse, however python-pygments
  # provided in Redhat is rather old and doesn't support Awk
	GIT_PROMPT=/usr/share/git-core/contrib/completion/git-prompt.sh
fi

LNOPT="-s -n $@"    # -n for no-deref (don't jump into the directories)
                    # -s for softlink
                    # -i for interactive, prompt before removing
                    # -f force

${PIP} install --upgrade --user jarg httpie
${PIP} install --upgrade --user pygments gdata
# Yaps installs configparser backports which ruins unittests at work
# ${PIP} install --upgrade --user yapf 
${PIP} install --upgrade --user isort pylint flake8
${PIP} install --upgrade --user neovim

# Vim
ln ${LNOPT} $PWD/vimfiles/vimrc ~/.vimrc

# Global
#
# Global is usually outdated, so script install_global.sh will download,
# compile and install Global
#
ln ${LNOPT} $PWD/global/globalrc ~/.globalrc

# tmux
ln ${LNOPT} $PWD/tmux/tmux.conf ~/.tmux.conf

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln ${LNOPT} $PWD/zshfiles/zshrc ~/.zshrc

# Bash
ln ${LNOPT} $PWD/bashfiles/bashrc ~/.bashrc
[ ! -z "${GIT_PROMPT}" ] && ln ${LNOPT} ${GIT_PROMPT} ~/.git-prompt.sh
cd ~/
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
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

# Nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln ${LNOPT} $PWD/nvim/init.vim ~/.config/nvim

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

# Gdb
mkdir -p ~/.gdb/
[ ! -e ~/.gdb/Boost-Pretty-Printer ] && git clone git://github.com/ruediger/Boost-Pretty-Printer.git ~/.gdb/Boost-Pretty-Printer
ln ${LNOPT} $PWD/gdb/gdbinit ~/.gdbinit

# Bin
[ ! -e ~/bin ] && mkdir ~/bin
ln ${LNOPT} $PWD/bin/* ~/bin/
ln ${LNOPT} $PWD/bin/cscope-py ~/bin/pytags

