#!/bin/bash
echo We are setting up
cd ~
git init && \
git remote add origin https://github.com/bedware/dotfiles.git && \
git pull origin master && \
git submodule update --init -j 2 && \
chmod 0600 .ssh/id_*
echo 'Common things done'

sudo apt install -y zsh
chsh -s $(which zsh)
echo `zsh --version` installed

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'Installing Oh-my-zsh done'

curl -fsSL https://starship.rs/install.sh | bash -s --force
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'Installing Starship done'

echo Done
# zsh

# Get the IP address of the host from /etc/resolv.conf
# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

# Set the display path
# export DISPLAY=$WSL_HOST:0.0