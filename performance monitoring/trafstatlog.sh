#!/bin/bash

CONN=`netstat -nt | awk '{ print $5}' | cut -d: -f1 | sed -e '/^$/d' | sort -n | uniq | wc -l`
DATE=`date '+%D | %r'`
LOADAVG=`cat /proc/loadavg`

BR1=`cat /sys/class/net/eth0/statistics/rx_bytes`
BT1=`cat /sys/class/net/eth0/statistics/tx_bytes`
sleep 60
BR2=`cat /sys/class/net/eth0/statistics/rx_bytes`
BT2=`cat /sys/class/net/eth0/statistics/tx_bytes`

INKB=$(((($BR2-$BR1) /60) /1024 /1024 *8))
OUTKB=$(((($BT2-$BT1) /60) /1024 /1024 *8))

echo "$DATE | $CONN | $INKB Mbit/s In (eth0) | $OUTKB Mbit/s Out (eth0) | $LOADAVG" >> /var/log/traflog

exit 0

