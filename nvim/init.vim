" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')


" -- Deoplete - for async powers in Vim/NVIM
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" --- Completion
" let g:node_client_debug = 1
" let $NVIM_COC_LOG_LEVEL='debug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-snippets']  "" Binding for Ultisnippets
Plug 'neoclide/coc-python', { 'do': ':CocInstall coc-python', 'for': ['python'] }
Plug 'neoclide/coc-rls', { 'do': 'rustup component add rls rust-analysis rust-src; CocInstall coc-rls', 'for': ['rust'] }
Plug 'neoclide/coc-tsserver', { 'do': ':CocInstall coc-tsserver', 'for': ['typescriptreact', 'typescript'] }
Plug 'neoclide/coc-jest', { 'do': ':CocInstall coc-jest', 'for': ['typescriptreact', 'typescript'] }
Plug 'neoclide/coc-yaml', { 'do': ':CocInstall coc-yaml', 'for': ['yaml'] }
Plug 'fannheyward/coc-markdownlint', { 'do': ':CocInstall coc-markdownlint', 'for': ['markdown'] }

Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
if has('macunix')
	let g:deoplete#sources#clang#libclang_path="/usr/local/Cellar/llvm/10.0.0_3/lib/libclang.dylib"
	let g:deoplete#sources#clang#clang_header="/usr/local/Cellar/llvm/10.0.0_3/include/clang"
else
	let g:deoplete#sources#clang#libclang_path="/usr/lib/llvm-7/lib/libclang.so"
	let g:deoplete#sources#clang#clang_header="/usr/lib/llvm-7/include/clang"
endif

Plug 'deoplete-plugins/deoplete-go', { 'for': ['go'], 'do': 'make' }

" Navigation
Plug 'https://github.com/derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


" -tags
Plug 'majutsushi/tagbar'

" -- Languages and filetypes
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'python-mode/python-mode', { 'for': 'python' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'jenkins' }
Plug 'leafgarland/typescript-vim', { 'for': ['typescriptreact', 'typescript'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['typescriptreact', 'typescript'] }

"--- Linters and checkers 
Plug 'neomake/neomake'
" Plug 'w0rp/ale'

" -- Colors, highlights and spelling
" Plug 'sheerun/vim-polyglot', { 'do': './build' } " Loads of syntax highlighting
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
set foldmethod=syntax
if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
	let g:solarized_use16 = 0
	let g:solarized_termcolors=256
	let g:solarized_termtrans = 1
	set bg=dark
	colors solarized8
endif

set completeopt-=preview

" OSX comes with an inferrior Make (use gmake).
if has('macunix')
  set makeprg=gmake
endif

set sw=4 ts=4 et
autocmd Filetype gitconfig setl sw=2 ts=2 noet
autocmd Filetype html setl sw=2 ts=2
autocmd Filetype ruby setl sw=2 ts=2 et
autocmd Filetype typescript setl sw=2 ts=2 et
autocmd Filetype typescriptreact setl sw=2 ts=2 et
autocmd Filetype yaml setl sw=2 sts ts=2 et
autocmd Filetype go setl sw=4 ts=4 noet
autocmd Filetype dockerfile setl sw=4 ts=4 et


" CoC keys and setting
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)



" Markdown
autocmd Filetype markdown setl et sw=4 ts=4 tw=79
autocmd FileType markdown nmap <leader>md :!open -a Marked %<cr>
" - Bullets apperantly clashes with comments https://github.com/plasticboy/vim-markdown/pull/375
let g:vim_markdown_auto_insert_bullets=0

" - Python - use pymode for lint's as it opens a new window (sadly not in
"   cope)
let g:pymode_paths = ["~/.local/bin"]  " Prefer latest console tools installed with Pip
let g:pymode_lint = 1
let g:pymode_lint_ignore = ["E501"]
autocmd FileType python setlocal nonumber sw=4 ts=4 et smartindent

" - Plug 'fatih/vim-go', { 'for': 'go' }
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
" For some reason i need to tell deoplete when to fire the omnicompletion
call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" - C++
" Switch between Header and source https://github.com/derekwyatt/vim-fswitch
" (works only on C and C++?)
nmap <silent> <Leader>h :FSHere<cr>
autocmd Filetype cpp set et sw=4 ts=4 nowrap cino+=(0  " Napatech style

" Jenkinsfile
autocmd Filetype Jenkinsfile setlocal et sw=4 ts=4 nowrap foldmethod=syntax
autocmd Filetype Jenkinsfile setlocal foldmethod=marker foldmarker={,}


" - JSON
autocmd Filetype json set et sw=2 ts=2 nowrap foldmethod=syntax

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

" Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_modules = ['gtags_cscope']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']

" Localvimrc
" - whitelist
let g:localvimrc_whitelist=['/Volumes/workspace/rdm/']

" - Ack (Grep vi AG, we use AG, it's faster than ACK)
let g:ackprg = 'rg --vimgrep'
let g:ack_use_dispatch = 1  " Use vim-dispatch for searching
nnoremap <Leader>a :Ack!<Space>

" - FZF
map <leader>f :FZF<cr>
map <leader>FH :History<cr>
map <leader>FB :Buffers<cr>

" - Airline
let g:airline#extensions#tagbar#enabled = 1
