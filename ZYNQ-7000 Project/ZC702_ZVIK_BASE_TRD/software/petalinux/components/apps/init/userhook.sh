#!/bin/sh

# Cache shared libraries from /etc/ld.so.conf
ldconfig

# Execute userhook if present
USERHOOK=/media/card/autostart.sh
if [ -f $USERHOOK ]
then
  sh $USERHOOK
fi
