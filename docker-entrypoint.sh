#!/bin/bash -ex

##
## author: Piotr Stawarski <piotr.stawarski@zerodowntime.pl>
##

confd -onetime || exit 2

echo "I'm $(whoami) !"

HOME=~redis exec chroot --userspec=redis / /usr/bin/redis-server /etc/redis.conf "$@"
