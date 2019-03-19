#!/bin/bash
# Auth: xad
# Descri: monitor master&slave delay time
Proc=/usr/bin/pt-heartbeat
User=root
Passwd=123
Port=3307
Pt_database=wordpress
Host=127.0.0.1
Master_id=7
function check_delay(){
    delay_time=`$Proc -u $User -p$Passwd -P $Port -h $Host -D $Pt_database --check --master-server-id=$Master_id`
    echo $delay_time
}
case $1 in 
    check_delay)
    check_delay
    ;;
    *)
    echo "Usage: `basename $0` [check_delay]"
esac
