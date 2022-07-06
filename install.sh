#!/bin/bash

# Bash script to automate installation of linux from scratch 

# TODO:
# Figure out a way to allow the user to customize what the environment variables are.

# -----------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------

# $FILESYSTEM - What filesystem do we want the root partition to use?
export FILESYSTEM="ext4"

# $LFS - Where do we want to mount the root filesystem in relation to the host?
export LFS="/mnt/lfs"

# $TGTDSK - What disk are we installing on?
export TGTDSK="/dev/sda" 

####################################################################
# Part 2: Preparing the Host System
####################################################################

# -----------------------------------------------------------------
# Partition the Hard Drive
# -----------------------------------------------------------------

# Specify the disk we are to partition, in this case the primary disk
export TGTDSK="/dev/sda" 

# Use a here document to partition our drive, in this case we have 2GB of swap and the rest allocated to the root filesystem
# Sed is used to remove comments before piping the instructions to fdisk
sed -e 's/\s*\([+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk ${TGTDSK} 
o # Clear the partition table
n # New partition
p # Primary partition
1 # Partition 1
  # Default, start at the start of the disk
+2G # 2 Gigabyte partition
n # New partition
p # Primary partition
2 # Partition 2
  # Default, start at the end of the last partition
  # Default, end at the end of the disk
a # Make partition bootable
2 # Partition 2 
w # Write the new partition table
q # Quit
EOF

# -----------------------------------------------------------------
# Create filesystems
# -----------------------------------------------------------------


# Initialize swap partition
sudo mkswap /dev/sda1

# Make an ext4 filesystem on the root partition
sudo mkfs -v -t $FILESYSTEM /dev/sda2

# -----------------------------------------------------------------
# Mount the root filesystem
# -----------------------------------------------------------------

# Makes the $LFS directory
sudo mkdir $LFS

# Mounts the directory 
sudo mount -v -t $FILESYSTEM /dev/sda2 $LFS

# Turns on the swap partition
sudo /sbin/swapon -v /dev/sda1

####################################################################
# Part 3: Packages and Patches
####################################################################





