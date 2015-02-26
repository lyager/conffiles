" Vim syntax file
" Language:	Markdown
" Maintainer:	Ben Williams <benw@plasticboy.com>
" URL:		http://plasticboy.com/markdown-vim-mode/
" Version:	8
" Last Change:  2008 April 29 
" Remark:	Uses HTML syntax file
" Remark:	I don't do anything with angle brackets (<>) because that would too easily
"		easily conflict with HTML syntax
" TODO: 	Do something appropriate with image syntax
" TODO: 	Handle stuff contained within stuff (e.g. headings within blockquotes)
"

set tw=72


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlBold     start=/\(^\|\s\)\*\@<!\*\*\*\@!/     end=/\*\@<!\*\*\*\@!\($\|\s\)/   contains=@Spell,htmlItalic
syn region htmlItalic   start=/\(^\|\s\)\*\@<!\*\*\@!/       end=/\*\@<!\*\*\@!\($\|\s\)/      contains=htmlBold,@Spell
syn region htmlBold     start=/\(^\|\s\)_\@<!___\@!/         end=/_\@<!___\@!\($\|\s\)/       contains=htmlItalic,@Spell
syn region htmlItalic   start=/\(^\|\s\)_\@<!__\@!/          end=/_\@<!__\@!\($\|\s\)/        contains=htmlBold,@Spell
syn region htmlString   start="]("ms=s+2             end=")"me=e-1
syn region htmlLink     start="\["ms=s+1            end="\]"me=e-1 contains=@Spell
syn region htmlString   start="\(\[.*]: *\)\@<=.*"  end="$"

"define Markdown groups
syn match  mkdLineContinue ".$" contained
syn match  mkdRule      /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule      /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule      /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule      /^\s*-\{3,}$/
syn match  mkdRule      /^\s*\*\{3,5}$/
syn match  mkdListItem  "^\s*[-*+]\s\+"
syn match  mkdListItem  "^\s*\d\+\.\s\+"
syn match  mkdCode      /^\s*\n\(\(\s\{4,}\|[\t]\+\)[^*-+ ].*\n\)\+/
syn region mkdCode      start=/`/                   end=/`/
syn region mkdCode      start=/\s*``[^`]*/          end=/[^`]*``\s*/
syn region mkdBlockquote start=/^\s*>/              end=/$/                 contains=mkdLineContinue,@Spell
syn region mkdCode      start="<pre[^>]*>"         end="</pre>"
syn region mkdCode      start="<code[^>]*>"        end="</code>"

"HTML headings
syn region htmlH1       start="^\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="^\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="^\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="^\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="^\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="^\s*######"              end="\($\|#\+\)" contains=@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=@Spell

"highlighting for Markdown groups
HtmlHiLink mkdString	    String
HtmlHiLink mkdCode          String
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier


let b:current_syntax = "mkd"

delcommand HtmlHiLink
set ts=4
set sw=4
set tw=78

function! MarkdownFoldLevel()
  let line = getline(v:lnum)
  if line=~"^####"
    return ">4"
  endif
  if line=~"^###"
    return ">3"
  endif
  if line=~"^##"
    return ">2"
  endif
  if line=~"^#"
    return ">1"
  endif
  return "=" " Else use previous fold
endfunction

function! s:MarkdownView()
  "exec "!markdown.py % | lynx -stdin"
  exec "!markdown.py % | w3m -T text/html"
endfunction
command! -n=0 MarkdownView :call s:MarkdownView()
function! s:MarkdownDump()
  exec "!markdown.py % |  lynx -dump -stdin "
endfunction
command! -n=0 MarkdownDump :call s:MarkdownDump()

function! s:MarkdownToHtml()
	let orig_filename = expand("%")
	let dest_filename = fnamemodify(orig_filename, ":r").".html"
  exec "!markdown.py ". orig_filename ." > ". dest_filename
endfunction
command! -n=0 MarkdownToHtml :call s:MarkdownToHtml()

function! s:MarkdownToPdf()
	let orig_filename = expand("%")
	let dest_filename = fnamemodify(orig_filename, ":r").".pdf"
  exec "!markdown.py ". orig_filename ." | htmldoc --cont --headfootsize 8.0 --linkcolor blue --linkstyle plain --format pdf14 - > ". dest_filename
endfunction
command! -n=0 MarkdownToPdf :call s:MarkdownToPdf()


set tw=72

set foldmethod=expr
set foldexpr=MarkdownFoldLevel()

"iab [d:today] <C-R>='[d:' . strftime("%d/%m-%y", localtime()) . ']'<CR>
"iab [d:tom] <C-R>='[d:' . strftime("%d/%m-%y", localtime()+86400) . ']'<CR>
" Needs to be a function to avoid complaints on unmatched searches
"inoremap <buffer> ] <ESC>:s?\[d:\(\d\+\) days?\="[d:".strftime('%d/%m-%y', localtime() + (86400 * submatch(1)))."]"?<CR><S-A>

