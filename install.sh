#!/bin/bash
echo We are setting up

cd ~
git init && \
git remote add origin https://github.com/bedware/dotfiles.git && \
git pull origin master && \
git submodule update --init -j 2 && \
chmod 0600 .ssh/id_*

echo Done

# Get the IP address of the host from /etc/resolv.conf
# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

# Set the display path
# export DISPLAY=$WSL_HOST:0.0