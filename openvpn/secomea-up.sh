#!/bin/bash

cat >/etc/resolver/dev.secomea.com  <<EOF
nameserver 10.150.30.2
nameserver 10.150.1.1
timeout 10
EOF
