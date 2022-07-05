#!/bin/bash

export TGTDSK="/dev/sda" 

sed -e 's/\s*\([+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk ${TGTDSK} 
o
n
p
1

+2G
n
p
2


a
2
p
w
q
EOF
