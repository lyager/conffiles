let mapleader = ";"

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


" YouCompleteMe: https://github.com/Valloric/YouCompleteMe
Plug 'Valloric/YouCompleteMe'


" Golang plugin
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" CtrlP - nice navigation
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
map <leader>j :CtrlP<cr>
" Wait for path input
map <leader>J :CtrlP 

Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()


