#!/bin/bash

cat >/etc/resolver/dev.secomea.com  <<EOF
nameserver 10.150.30.2
nameserver 10.150.30.7
nameserver 10.150.30.37
nameserver 10.150.1.1
timeout 10
EOF

cat >/etc/resolver/test.secomea.com  <<EOF
nameserver 10.160.30.2 
timeout 10
EOF

dscacheutil -flushcache
exit 0

