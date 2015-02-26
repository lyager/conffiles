set tw=78      " textwidth
set ai         " Auto Indent
set ts=2       " Tabsize 1
set sw=2       " Shiftwidth 1 
set expandtab  " To hold format, don't us tabs.
set comments="" " Comments are the empty string, don't be smart, there are no comments mate.

function! APTConvert(convertTo, args)
	let orig_filename = expand("%")
	let dest_filename = substitute(orig_filename, '\([^\.]*\).*', '\1.'.a:convertTo, '')
	execute '!aptconvert '.a:args.' '.dest_filename.' '.orig_filename
endfunction

" aptconvert commands
map <C-A><C-H> :w<CR>: call APTConvert("html", "-nonum -toc")<CR><CR>
map <C-A><C-P> :w<CR>: call APTConvert("pdf", "-toc")<CR><CR>
map <C-A><C-X> :w<CR>: call APTConvert("html", "-toc -nonum -pi html css default.css")<CR><CR>
