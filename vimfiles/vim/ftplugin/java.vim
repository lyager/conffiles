" $Id$
set makeprg=ant

"For ant (http://jakarta.apache.org/) the above errorformat has to be modified 
"to honour the leading [javac] in front of each javac output line: 
set errorformat=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%# 
