#!/bin/bash

# Show extra debug info
set -e

echo 'We are setting up'
echo 'Installing Dotfiles'
cd ~
git init && \
git remote add origin https://github.com/bedware/dotfiles.git && \
git pull origin master && \
git submodule update --init -j 2 && \
chmod 0600 .ssh/id_*

echo 'Installing zsh'
sudo apt install -y zsh

echo 'Installing oh-my-zsh'
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended

curl -fsSL https://starship.rs/install.sh | bash -s -- -y
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'Installing Starship'

echo 'Switching to zsh'
chsh -s $(which zsh) && $(which zsh)

# Get the IP address of the host from /etc/resolv.conf
# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

# Set the display path
# export DISPLAY=$WSL_HOST:0.0
