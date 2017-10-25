" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'https://github.com/derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }
Plug 'fatih/vim-go', { 'for': 'go' }  " Go
Plug 'lyager/vim-markdown', { 'for': 'mkd' }
Plug 'https://github.com/lyager/python-mode', { 'for': 'python' }  " Python
Plug 'vim-syntastic/syntastic'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'


" Initialize plugin system
call plug#end()

let mapleader = ";"
set ignorecase                " When searching without case, use smartcase which matches both capitalized
set smartcase                 " and not capitalized letters
set listchars=tab:>.,trail:.  " Prefer to have identation pointed out too.
set nowrap                    " As a default, we want the lines not to wrap
set nofoldenable              " Do not fold to begin with

" - Markdown
autocmd Filetype mkd setl et sw=4 ts=4

" - Colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1   " Transparent bg
colorscheme solarized

" - Python - use pymode for lint's as it opens a new window (sadly not in
"   cope)
let g:pymode_lint = 1
let g:pymode_lint_ignore = "E501"
autocmd FileType python setlocal nonumber

" - Golang plugin
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" - C++
" Switch between Header and source https://github.com/derekwyatt/vim-fswitch
" (works only on C and C++?)
nmap <silent> <Leader>h :FSHere<cr>
autocmd Filetype cpp set et sw=2 ts=2 nowrap cino+=(0  " Napatech style
nmap <silent> <Leader>h :FSHere<cr>
autocmd Filetype cpp set et sw=2 ts=2 nowrap cino+=(0  " Napatech style

" - JSON
autocmd Filetype json set et sw=4 ts=4 nowrap

" - YouCompleteMe: https://github.com/Valloric/YouCompleteMe
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gD :YcmCompleter GetDoc<CR>
let g:ycm_filetype_blacklist = { 'mkd': 1 }

" - Ack (Grep vi AG, we use AG, it's faster than ACK)
let g:ackprg = 'ag --vimgrep'
nnoremap <Leader>a :Ack!<Space>

" - CtrlP - nice navigation
map <leader>j :CtrlP<cr>
" Wait for path input
map <leader>J :CtrlP 

" - FZF Possible alternative to CtrlP
map <leader>f :FZF<cr>
map <leader>F :History<cr>

" - Syntastic
let g:syntastic_python_flake8_args='--ignore=E501'

" - Airline
let g:airline#extensions#tagbar#enabled = 1
