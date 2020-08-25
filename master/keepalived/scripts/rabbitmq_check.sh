#!/bin/bash

k1=`/usr/bin/nmap -sS 127.0.0.1 -p 5672 | grep 5672 | awk '{printf $2}'`
if [ "$k1"x != "open"x ]; then
        /usr/sbin/rabbitmq-server -detached
fi
Q1=`/usr/bin/nmap -sS 127.0.0.1 -p 5672 | grep 5672 | awk '{printf $2}'`
if [ "$Q1"x != "open"x ]; then
        systemctl stop keepalived
fi
