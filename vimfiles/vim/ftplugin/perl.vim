" Function folding for Perl
" $Id$

function! GetPerlFold()
    if getline(v:lnum) =~ '^sub' || getline(v:lnum) =~ '^=pod'
        return ">1"
    elseif getline(v:lnum) =~ '^}' || getline(v:lnum) =~ '^=cut'
        return "<1"
    else
        return "="
    endif
endfunction
setlocal foldexpr=GetPerlFold()
setlocal foldmethod=expr
