#!/bin/bash
# Author: XAD
# Descri: backup redis rdbdata
. /etc/profile
### Redis meta
Redis_Port=6379
Redis_Pass=123456
Redis_Host=10.0.0.31
Redis_Rdb_File=/var/lib/redis/dump.rdb
Backup_Dir=/backup/redis/rdbdata
Start_Date=`date +%F-%H-%M-%S`

### Redis cmd
Redis_Exec="redis-cli -p ${Redis_Port} -a ${Redis_Pass} -h ${Redis_Host}"
Bgsave_Exec=`${Redis_Exec} bgsave`

### Redis bak
while :
do
    Bgsave_Status_Check=`${Redis_Exec} info persistence| awk -F: '/rdb_bgsave_in_progress/{print $2}' | sed 's@\r@@g'`
    #Bgsave_Status_Check=`${Redis_Exec} info persistence| awk -F':' '/rdb_bgsave_in_progress/'`
    #echo $Bgsave_Status_Check
    if [ "${Bgsave_Status_Check}" -eq 0 ]; then
        cp -p ${Redis_Rdb_File} ${Backup_Dir}/${Start_Date}-dump.rdb
        exit
    else
        sleep 5s
        continue
    fi
done
