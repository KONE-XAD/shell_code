#!/bin/bash
# Aythor: xad
# descri: check system status like cpu,memory,disk.... 
source /etc/profile

function login_user(){
    who  | wc -l 
}
function login_user_nroot(){
    who  | awk 'BEGIN{sum=0}{if($1 !~ /^root$/)sum++}END{print sum}'
}

function disk_used(){
    df |grep /$ | awk '{print $2*1024}'
}
function disk_free(){
    df |grep /$ | awk '{print $3*1024}'
}
function disk_available(){
    df |grep /$ | awk '{print $4*1024}'
}

function memory_total(){
    free | awk 'FNR==2{print $2*1024}'
}
function memory_used(){
    free | awk 'FNR==2{print $3*1024}'
}
function memory_available(){
    free | awk 'FNR==2{print ($4+$6)*1024}'
}
function memory_buff_cache(){
    free | awk 'FNR==2{print $6*1024}'
}

function swap_total(){
    free | awk 'FNR==3{print $2*1024}'
}
function swap_used(){
    free | awk 'FNR==3{print $3*1024}'
}
function swap_free(){
    free | awk 'FNR==2{print $4*1024}'
}
#disk_free
#$1


case $1 in
    login_user)
        login_user
        ;;
    login_user_nroot)
        login_user_nroot
        ;;
    disk_used)
        disk_used
        ;;
    disk_free)
        disk_free
        ;;
    disk_available)
        disk_available
        ;;
    memory_total)
        memory_total
        ;;
    memory_used)
        memory_used
        ;;
    memory_available)
        memory_available
        ;;
    memory_buff_cache)
        memory_buff_cache
        ;;
    swap_total)
        swap_total
        ;;
    swap_used)
        swap_used
        ;;
    swap_free)
        swap_free
        ;;
    *)
        echo "Usage: `basename $0` []"
        ;;
esac
