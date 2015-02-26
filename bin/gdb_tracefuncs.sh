#!/bin/sh
#

file=$1
arg0=`basename $0`

# Ensure sanity
if [ $# -lt 1 ]; then
	echo ""
	echo "Usage:"
	echo "  ${arg0} <elf-executable>"
	echo ""
	exit 0
fi

tmp=$(mktemp /tmp/${arg0}-XXXXXXXXXX)
echo "set pagination off" > $tmp
readelf -s ${file} | gawk '
{ 
  if($4 == "FUNC" && $2 != 0) { 
    print "# code for " $NF; 
    print "b *0x" $2; 
    print "commands"; 
    print "silent"; 
    print "bt 1"; 
    print "c"; 
    print "end"; 
    print ""; 
  } 
}' >> $tmp;

echo "Run: gdb -command=$tmp --args $file"

