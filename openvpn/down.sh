#!/bin/bash

rm -Rf /etc/resolver/$(basename $config .conf)
/usr/sbin/lookupd -flushcache
exit 0
