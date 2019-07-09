" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


" -- Completion {{{
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all'}
" -- https://github.com/davidhalter/jedi-vim (Python code navigation (think
"  ctags))
"
" TODO Well, can't get ale to work with virtualenv - deoplete-jedi works, but
" can't navigate - and ALE is really agressiv in Python
Plug 'w0rp/ale', { 'for': ['c', 'cpp'] }

" -- Navigation
Plug 'https://github.com/derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'multilobyte/gtags-cscope' 

" -- Languages and filetypes
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] } " Very good, but needs compile_commands.json (from Clang)
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }  " Python
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'do': 'cargo install racer', 'for': 'rust' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'jenkins' }


let g:deoplete#enable_profile = 1
let g:jedi#completions_enabled = 0
Plug 'zchee/deoplete-jedi', { 'do': 'pip install --upgrade jedi pynvim', 'for': ['python'] }  " Jedi: Introspection tool fyr python
Plug 'deoplete-plugins/deoplete-go', { 'for': ['go'], 'do': 'make'}
Plug 'davidhalter/jedi-vim', { 'for': ['python'] }  " Jedi: Introspection tool fyr python, but is deoplete-jedi for completion
"
"--- Linters and checkers 
Plug 'neomake/neomake', { 'for': ['rust', 'go'] }

" -- Colors, highlights and spelling
Plug 'sheerun/vim-polyglot', { 'do': './build' } " Loads of syntax highlighting
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ujihisa/neco-look'  " Spelling suggestions with deoplete

" --- Editor helpers
Plug 'tpope/vim-fugitive'
Plug 'Asheq/close-buffers.vim'
Plug 'embear/vim-localvimrc'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-dispatch'

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
	colors solarized8
endif

" Might as well set default indentation here
set ts=2
set sw=2
set et

set makeprg=gmake

autocmd Filetype gitconfig setl sw=2 ts=2 noet
autocmd Filetype html setl sw=2 ts=2
autocmd Filetype ruby setl sw=2 ts=2 et
autocmd Filetype yaml setl sw=2 sts ts=2 et
autocmd Filetype markdown setl et sw=4 ts=4 tw=79

" - Python - use pymode for lint's as it opens a new window (sadly not in
"   cope)
let g:pymode_paths = ["~/.local/bin"]  " Prefer latest console tools installed with Pip
let g:pymode_lint = 1
let g:pymode_lint_ignore = ["E501"]
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal nonumber sw=4 ts=4 et

" - Plug 'fatih/vim-go', { 'for': 'go' }
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

" Jenkinsfile
autocmd Filetype Jenkinsfile setlocal et sw=4 ts=4 nowrap foldmethod=syntax
autocmd Filetype Jenkinsfile setlocal foldmethod=marker foldmarker={,}


" - JSON
autocmd Filetype json set et sw=4 ts=4 nowrap foldmethod=syntax

" - Plug 'multilobyte/gtags-cscope'
" To use the default key/mouse mapping:
let GtagsCscope_Auto_Map = 1
" To ignore letter case when searching:
let GtagsCscope_Ignore_Case = 1
" To use absolute path name:
let GtagsCscope_Absolute_Path = 1
" To deterring interruption:
let GtagsCscope_Keep_Alive = 1
" If you hope auto loading:
let GtagsCscope_Auto_Load = 1
" To use 'vim -t ', ':tag' and '<C-]>'
set cscopetag
" To auto update tags when a file is saved
let GtagsCscope_Auto_Update = 0 " This still takes too long
let GtagsCscope_Quiet = 1 " Supress 'GTAGS not found' error
:nmap <C-\>I :cs find i <C-R>=expand("%:t")<CR><CR>
:nmap <C-@>I :scs find i <C-R>=expand("%:t")<CR><CR>
:nmap <C-@><C-@>I :vert scs find i <C-R>=expand("%:t")<CR><CR>

" " - YouCompleteMe: https://github.com/Valloric/YouCompleteMe
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
" let g:ycm_warning_symbol = '.'
" let g:ycm_error_symbol = '..'
" let g:ycm_server_use_vim_stdout = 1
" nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
" nnoremap <leader>gt :YcmCompleter GetType<CR>
" nnoremap <leader>gD :YcmCompleter GetDoc<CR>
" let g:ycm_filetype_blacklist = { 'markdown': 1 }

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

" - Plug 'w0rp/ale'
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'c': ['clang-format'],
      \ 'javascript': ['eslint'],
      \}
let g:ale_c_cppcheck_executable = '/usr/local/bin/cppcheck'

" - Plug 'racer-rust/vim-racer'
let g:racer_experimental_completer = 1
au FileType rust nmap <leader>rx <Plug>(rust-doc)
au FileType rust nmap <leader>rd <Plug>(rust-def)
au FileType rust nmap <leader>rs <Plug>(rust-def-split)

" - Plug 'neomake/neomake', {....
if exists("neomake")
  call neomake#configure#automake('w')
  let g:airline#extensions#neomake#enabled = 1
endif

" Localvimrc
" - whitelist
let g:localvimrc_whitelist=['/Volumes/workspace/rdm/']

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
