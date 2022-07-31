#!/bin/sh

# Add the lfs user and give them a home directory and password
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

cat << EOF | passwd lfs
lfs
lfs
EOF

# Add directories under the lfs home directory
mkdir -pv /home/lfs/lfs 

mkdir -pv /home/lfs/lfs/{etc,var} /home/lfs/lfs/usr/{bin,lib,sbin}

case $(uname -m) in
  x86_64) mkdir -pv /home/lfs/lfs/lib64 ;;
esac

mkdir -pv /home/lfs/lfs/{tools,sources}

# Give ownership of these new directories to lfs



# Configure .bash_profile and .bashrc for the user
cat > /home/lfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
MAKEFLAGS=-j$(nproc)
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS
EOF
