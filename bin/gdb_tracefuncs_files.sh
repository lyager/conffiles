#!/bin/sh
#

arg0=`basename $0`

# Ensure sanity
if [ $# -lt 1 ]; then
	echo ""
	echo "Usage:"
	echo "  ${arg0} <cfiles..>"
	echo ""
	exit 0
fi

tmp=$(mktemp /tmp/${arg0}-XXXXXXXXXX)
echo "set pagination off" > $tmp

ctags -x --c-kinds=f $@ | gawk '
{ 
  if($1 != 0 && $3 != 0) { 
    print "b " $1; 
    print "commands"; 
    print "silent"; 
    print "bt 1"; 
    print "c"; 
    print "end"; 
    print ""; 
  } 
}' >> $tmp;

echo "Run: gdb -command=$tmp --args <binary>"

