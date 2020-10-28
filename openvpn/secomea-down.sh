#!/bin/bash

rm -Rf /etc/resolver/dev.secomea.com
dscacheutil -flushcache
exit 0
