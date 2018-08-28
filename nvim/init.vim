" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all'}
Plug 'https://github.com/derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }  " Python
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'vim-syntastic/syntastic'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'Asheq/close-buffers.vim'
Plug 'embear/vim-localvimrc'


Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

let mapleader = ";"
set ignorecase                " When searching without case, use smartcase which matches both capitalized
set smartcase                 " and not capitalized letters
set listchars=tab:>.,trail:.  " Prefer to have identation pointed out too.
set nowrap                    " As a default, we want the lines not to wrap
set nofoldenable              " Do not fold to begin with
if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
	let g:solarized_use16 = 0
	let g:solarized_termcolors=256
	let g:solarized_termtrans = 1
	set bg=dark
	colors solarized8_dark_high
endif


" - HTML
autocmd Filetype html setl sw=2 ts=2

" - Markdown
autocmd Filetype markdown setl et sw=4 ts=4 tw=79

" - Python - use pymode for lint's as it opens a new window (sadly not in
"   cope)
let g:pymode_paths = ["~/.local/bin"]  " Prefer latest console tools installed with Pip
let g:pymode_lint = 1
let g:pymode_lint_ignore = ["E501"]
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
autocmd Filetype json set et sw=4 ts=4 nowrap foldmethod=syntax

" - YouCompleteMe: https://github.com/Valloric/YouCompleteMe
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_warning_symbol = '.'
let g:ycm_error_symbol = '..'
let g:ycm_server_use_vim_stdout = 1
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gD :YcmCompleter GetDoc<CR>
let g:ycm_filetype_blacklist = { 'markdown': 1 }

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:ultisnips_python_style = "google"
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:snips_author = "Jesper L. Nielsen"
let g:snips_email = ""
let g:snips_github = "https://github.com/lyager"

" Localvimrc
" - whitelist
let g:localvimrc_whitelist=['/Volumes/workspace/gm_rdm/']

" - Ack (Grep vi AG, we use AG, it's faster than ACK)
let g:ackprg = 'ag --vimgrep'
nnoremap <Leader>a :Ack!<Space>

" - FZF
map <leader>f :FZF<cr>
map <leader>FH :History<cr>
map <leader>FB :Buffers<cr>

" - Syntastic
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

" - Airline
let g:airline#extensions#tagbar#enabled = 1
