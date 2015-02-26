" Determine certain filetypes
if did_filetype() " filetype already set..
  finish    " ..don't do these checks
endif
if getline(1) =~ '^LANG: '
  setfiletype juno
elseif getline(1) =~? '\<drawing\>'
  setfiletype drawing
endif

