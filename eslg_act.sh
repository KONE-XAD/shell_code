#!/bin/bash
# Author: xad
# descri: check es and logstash status,using for zabbix
source /etc/profile
Es_port=(9200 9300)
#echo ${Es_port[0]}
#echo ${Es_port[1]}
#echo $Es_aport
#echo $Es_tport
Lg_port=9600

es_check(){
Es_aport=`netstat -tunl | grep ${Es_port[0]}| wc -l`
Es_tport=`netstat -tunl | grep ${Es_port[01]}| wc -l`
if [ $Es_aport -gt 0 -a $Es_tport -gt 0 ]; then
   echo 0
else
   echo 1
fi 
}

logstash_check(){
Lg_cport=`netstat -tunl | grep $Lg_port | wc -l`
if [ $Lg_cport -gt 0 ];then
    echo 0
else
    echo 1
fi
}

case $1 in
    es_check)
        es_check
        ;;
    logstash_check)
        logstash_check
        ;;
    *)
        echo "Usage `basename $0` [es_check|logstash_check]" 
esac
