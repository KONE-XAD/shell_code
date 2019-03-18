#!/bin/bash
# Auth: xad
# dsri: monitor mysql master&slave status
datetime=`date '+%Y-%m-%d %H:%M:%S'`
Slave_status_file=`mktemp`
Mysql_user=root
Mysql_host=10.0.0.51
Mysql_pwd=00000000
Mysql_proc=/app/mysql/bin/mysql
Mysql_socket=/data/3308/mysql.sock
Mysql_ipconn_cmd="$Mysql_proc -u $Mysql_user -p${Mysql_pwd} -h $Mysql_host"
Mysql_sockconn_cmd="$Mysql_proc -S ${Mysql_socket}"
#echo $Mysql_conn_cmd
$Mysql_sockconn_cmd -e "show slave status\G" > $Slave_status_file
function io_check(){
    io_statu=`grep -i slave_io_running $Slave_status_file | awk '{print $2}'`
    if [ "$io_statu" == "Yes" ]; then 
        echo 0
    else
        echo 1
    fi
}
function sql_check(){
    sql_statu=`grep -i "slave_sql_running:" $Slave_status_file | awk '{print $2}'`
    if [ "$sql_statu" == "Yes" ]; then
        echo 0
    else
        echo 1
    fi
}
function check_statu(){
    sql_statu=`grep -i "slave_sql_running:" $Slave_status_file | awk '{print $2}'`
    io_statu=`grep -i slave_io_running $Slave_status_file | awk '{print $2}'`
#    echo $sql_statu
#    echo $io_statu
    if [[ "$io_statu" == "Yes" && "$sql_statu" == "Yes" ]]; then
        echo 0
    else 
        echo 1
    fi
}
case $1 in 
    check_statu)
        check_statu
        ;;
    sql_check)
        sql_check
        ;;
    io_check)
        io_check
        ;;
    *)
        echo "Usage:`basename $0` [check_statu|io_check|sql_check]"
esac
rm -f $Slave_status_file
