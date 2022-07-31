#!/bin/sh

# Simple script to run all other scripts sequentially 

# Install the host system requirements
bash req-install.sh
bash req-linker.sh

# Create the build environment
bash create-env.sh
