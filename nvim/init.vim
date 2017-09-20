let mapleader = ";"
set ignorecase                " When searching without case, use smartcase which matches both capitalized
set smartcase                 " and not capitalized letters
set listchars=tab:>.,trail:.  " Prefer to have identation pointed out too.
set nowrap                    " As a default, we want the lines not to wrap

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


" - YouCompleteMe: https://github.com/Valloric/YouCompleteMe
Plug 'Valloric/YouCompleteMe'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>

" - C++
" Switch between Header and source https://github.com/derekwyatt/vim-fswitch
" (works only on C and C++?)
Plug 'https://github.com/derekwyatt/vim-fswitch'
nmap <silent> <Leader>h :FSHere<cr>
autocmd Filetype cpp set et sw=2 ts=2 nowrap cino+=(0  " Napatech style

" - Golang plugin
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" - Python
Plug 'https://github.com/lyager/python-mode', { 'for': 'python' }
let g:pymode_lint = 0
autocmd FileType python setlocal nonumber

" === General
" - Syntastic
Plug 'vim-syntastic/syntastic'
let g:syntastic_python_flake8_args='--ignore=E501'

" - Ack (Grep vi AG, we use AG, it's faster than ACK)
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep'

" - CtrlP - nice navigation
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
map <leader>j :CtrlP<cr>
" Wait for path input
map <leader>J :CtrlP 

" - Git plugin
Plug 'tpope/vim-fugitive'

" - Solarized Colorscheme
Plug 'altercation/vim-colors-solarized'

" Initialize plugin system
call plug#end()


let g:solarized_termcolors=256
let g:solarized_termtrans=1   " Transparent bg
colorscheme solarized
