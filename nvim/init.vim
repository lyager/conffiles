let mapleader = ";"
set ignorecase                " When searching without case, use smartcase which matches both capitalized
set smartcase                 " and not capitalized letters
set listchars=tab:>.,trail:.  " Prefer to have identation pointed out too.
set nowrap                    " As a default, we want the lines not to wrap

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


" YouCompleteMe: https://github.com/Valloric/YouCompleteMe
Plug 'Valloric/YouCompleteMe'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Switch between Header and source https://github.com/derekwyatt/vim-fswitch
" (works only on C and C++?)
Plug 'https://github.com/derekwyatt/vim-fswitch'
nmap <silent> <Leader>h :FSHere<cr>

" Golang plugin
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" Ack (Grep vi AG, we use AG, it's faster than ACK)
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep'

" CtrlP - nice navigation
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
map <leader>j :CtrlP<cr>
" Wait for path input
map <leader>J :CtrlP 

Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()


