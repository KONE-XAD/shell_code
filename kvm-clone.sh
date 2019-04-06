#!/bin/bash
# Author: xad
# Descri: clone kvm
# check soure name exist and not running state
if [ $# -ne 2 ]; then
    echo "Usage: `basename $0` <source domain>  <dest domain>"
    exit 1
fi
Num=`virsh list --state-running | grep -c $1`
if [ ${Num} -ge 1 ]; then
    echo "please shutdown or suspend $1" && exit 1
fi

Sour_Disk=`virsh domblklist $1 | awk 'FNR==3{print $2}'`
Dest_Disk=`dirname ${Sour_Disk}`
Disk_format=${Sour_Disk#*.}

# create new disk
qemu-img create -f ${Disk_format}  -b ${Sour_Disk} ${Dest_Disk}/$2.${Disk_format} 

# install new system  
virt-install --virt-type kvm --os-type=linux --os-variant rhel7 --name $2 --memory 1024 --vcpus 1 --disk ${Dest_Disk}/$2.${Disk_format} --boot hd --network network=default --graphics vnc,listen=0.0.0.0 --noautoconsole
