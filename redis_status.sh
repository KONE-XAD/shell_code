#!/bin/bash
# Author: xad
# Descri: monitor to redis

Proc=/usr/bin/redis-cli
Host=172.16.0.12
Rpasswd=238277056
Port=63799

redis_status(){
    $Proc -h $Host -p $Port -a $Rpasswd info | grep $1 | awk -F':' '{print  $2}'
}
menu(){
    cat <<-EOF
    hello
    hello
    hello
EOF
}
case $1 in
    uptime_in_seconds)
        redis_status ${1}:
        ;;
    uptime_in_days)
        redis_status ${1}:
        ;;
    connected_clients)
        redis_status ${1}:
        ;;
    client_longest_output_list)
        redis_status ${1}:
        ;;
    client_biggest_input_buf)
        redis_status ${1}:
        ;;
    blocked_clients)
        redis_status ${1}:
        ;;
    used_memory)
        redis_status ${1}:
        ;;
    used_memory_rss)
        redis_status ${1}:
        ;;
    used_memory_peak)
        redis_status ${1}:
        ;;
    total_system_memory)
        redis_status ${1}:
        ;;
    total_connections_received)
        redis_status ${1}:
        ;;
    total_commands_processed)
        redis_status ${1}:
        ;;
    instantaneous_ops_per_sec)
        redis_status ${1}:
        ;;
    used_memory_lua)
        redis_status ${1}:
        ;;
    menu)
        menu
        ;;

    *)
        echo "Usage: `basename $0`"
        ;;
esac
