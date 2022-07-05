#!/bin/bash

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
