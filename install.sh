#!/bin/bash
echo 'We are setting up'
cd ~
git init && \
git remote add origin https://github.com/bedware/dotfiles.git && \
git pull origin master && \
git submodule update --init -j 2 && \
chmod 0600 .ssh/id_*
echo 'Common things done'

sudo apt install -y zsh
echo 'Zsh installed'

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended
echo 'Installing Oh-my-zsh done'

curl -fsSL https://starship.rs/install.sh | bash -s -- -y
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'Installing Starship done'

echo 'Post-step: run in the console command below:'
echo 'chsh -s $(which zsh)'
echo 'Then relogin'
# zsh

# Get the IP address of the host from /etc/resolv.conf
# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

# Set the display path
# export DISPLAY=$WSL_HOST:0.0
