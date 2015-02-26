" $Id$
set ai      " Auto Indent
set ts=4
set sw=4

function! s:DOTConvert(convertTo)
	let orig_filename = expand("%")
	let dest_filename = substitute(orig_filename, '\([^\.]*\).*', '\1.'.a:convertTo, '')
	execute '!dot -T'.a:convertTo.' -o '.dest_filename.' '.orig_filename
    " This little dummy makes it possibly to see what actually went on.
    echo ""
endfunction

" Export the command
com! -nargs=1 DOTConvert call s:DOTConvert(<args>)

" Key mappings for DOT
map <C-D><C-P><C-P> :w<CR>: :DOTConvert("ps")<CR><CR>
map <C-D><C-P> :w<CR>: :DOTConvert("png")<CR><CR>
map <C-D><C-V> :w<CR>: :DOTConvert("svg")<CR><CR>
