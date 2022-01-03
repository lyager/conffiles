#!/bin/bash

rm -Rf /etc/resolver/dev.secomea.com
rm -Rf /etc/resolver/test.secomea.com
dscacheutil -flushcache
exit 0
