" Vim syntax file
" Language:	APT - Almost Plain Text
" Maintainer:	Jesper L. Nielsen (lyager[at]phunkbros[dot]dk)
" Last change: $Id$

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists ("b:current_syntax")
    finish
endif

" case off
syn case ignore

" Sections
syn match  AptSection   "^\*\+ .*"
syn match  AptSection   "^[^ ].*"

" Comments 
syn match  AptComment	"\~.*"

" Verbatim
syn region AptVerbatim start="^-\+" end="^-\+"

" Title
syn match AptTitle "^\s\+---*"

" Define the default hightlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cfg_syn_inits")
    if version < 508
	let did_cfg_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif
    " Some color links
    " Label, Comment, Type, String, Keyword, Constant, Directory
    HiLink AptComment   Comment
    HiLink AptVerbatim  Keyword
    HiLink AptSection   Type
    HiLink AptTitle     Label


    delcommand HiLink
endif
let b:current_syntax = "apt"
" vim:ts=8
