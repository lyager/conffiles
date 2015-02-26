" ---------------- SVN -------------
" $Id$
" More features to come.
"

function! SVNCommit( filename )
  "Clear g:SVNFilenames in case we're comming from SVNFileSelect()
  let g:SVNfilenames=''

  let tempfname = tempname()
  "let command = CvsCmdString(a:cmd, expand("%"), tempfname)
  "let files = expand("%")
  let files = a:filename
  let command = g:SVNPath." commit -F ".tempfname." ".files
  new
  set nobuflisted " Window doesn't show up as buffer
  call append(0, "\SVN    ".files)
  call append(0, "\SVN Following files will be included:                         SVN")
  call append(0, "\SVN                  type ;cc to commit                       SVN")
  call append(0, "\SVN                 type :q! to abort or                      SVN")
  call append(0, "\SVN           Enter your change comments here                 SVN")
  call append(0, "\SVN                     SVN LOG ENTRY                         SVN")
  exec "write " . tempfname
  exec "map <buffer> <Leader>cc " . ":%! grep -v ^SVN <CR>:w<CR>:!".command."<CR>:q"
endfunction

function! SVNSetPropertyKeyword( filename )
  "Clear g:SVNFilenames in case we're comming from SVNFileSelect()
  let g:SVNfilenames=''

  let tempfname = tempname()
  let files = a:filename
  let command = g:SVNPath." ps svn:keywords -F ".tempfname." ".files
  new
  set nobuflisted " Window doesn't show up as buffer
  call append(0, "\SVN    ".files)
  call append(0, "\SVN Following files will be included:                         SVN")
  call append(0, "\SVN                  type ;cc to commit                       SVN")
  call append(0, "\SVN                 type :q! to abort or                      SVN")
  call append(0, "\SVN               Enter your keywords here                    SVN")
  call append(0, "\SVN                     SVN LOG ENTRY                         SVN")
  exec "write " . tempfname
  exec "map <buffer> <Leader>cc " . ":%! grep -v ^SVN <CR>:w<CR>:!".command."<CR>:q"
endfunction


function! SVNDiff()
  let input = input( "Additional arguments: ")
  let DiffFile = tempname()
  execute '!'.g:SVNPath.' cat '.input.' % >'.DiffFile
  execute 'diffsplit '.DiffFile
  exec "map <buffer> <Leader>cq " . ":q<CR>:diffoff<CR>"
  set nobuflisted " Window doesn't show up as buffer
endfunction

function! SVNFileAppend()
  let line=getline('.')
  let filename=substitute(line, 'Index: ', '', '')
  if (filename != line)
    let g:SVNfilenames=filename.' '.g:SVNfilenames
  endif
  echo g:SVNfilenames
endfunction

function! SVNFileSelect()
  let g:SVNfilenames=''   " Clear filenaes for each select session
  let tempfname = tempname()
  exec ':!'.g:SVNPath.' diff > '.tempfname
  exec ":hide e ".tempfname
  set nobuflisted
  set bt=nowrite
  let g:SVNfilenames=''
  map <buffer> <CR> :call SVNFileAppend()<CR>
  map <buffer> <C-C><C-C> :call SVNCommit(g:SVNfilenames)<CR>
endfunction

function! SVNStat()
  execute '!'.g:SVNPath.' stat'
endfunction

" ---- Main functions
if !exists("g:SVNPath")
  if (executable("svn"))
    let g:SVNPath='svn'
  elseif (executable("/sw/bin/svn"))
    let g:SVNPath='/sw/bin/svn'
  else
    " Commented out, doesn't work on GVim, which quits
    "let g:SVNPath=inputdialog("Unable to locate SVN binary.")
  endif
endif

" Map keys
map <leader>cc :call SVNCommit(expand('%'))<CR>
map <leader>cp :call SVNSetPropertyKeyword(expand('%'))<CR>
map <leader>cf :call SVNFileSelect()<CR>
map <leader>cs :call SVNStat()<CR>
map <leader>cd :call SVNDiff()<CR>
