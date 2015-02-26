#!/bin/bash

dns=dns
for opt in ${!foreign_option_*}
do
   eval "dns=\${$opt#dhcp-option DNS }"
   if [ "$dns" != "dns" ]
       then
          cat >/etc/resolver/$(basename $config .conf)  <<EOF
nameserver $dns
timeout 10
EOF
          exit 0
       fi
done
