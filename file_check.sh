#/bin/bash
# Author: xad
# Descri: check file size or dir size an files's num

function dir_size(){
    du -s $1 | awk '{print $1*1024}'
}

function file_nums(){
    ls -l  $1 | grep ^- | wc -l    
}

case $1 in
    dir_size)
        dir_size $2
        ;;
    file_nums)
        file_nums $2
        ;;
    *)
        echo "Usage: `basename $0` [dir_size|file_nums]"
esac
