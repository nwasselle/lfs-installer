#!/bin/sh

sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

cat << EOF | passwd lfs
lfs
lfs
EOF

mkdir -pv /home/lfs/lfs 

mkdir -pv /home/lfs/lfs/{etc,var} /home/lfs/lfs/usr/{bin,lib,sbin}

case $(uname -m) in
  x86_64) mkdir -pv /home/lfs/lfs/lib64 ;;
esac
