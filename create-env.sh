#!/bin/sh

sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

cat << EOF | passwd lfs
lfs
lfs
EOF
