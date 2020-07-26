#!/bin/bash

# Show extra debug info
set -e

setup_dotfiles () {
    echo 'We are setting up'
    echo 'Installing Dotfiles'
    cd ~
    git init && \
    git remote add origin https://github.com/bedware/dotfiles.git && \
    git pull origin master && \
    git submodule update --init -j 2 && \
    chmod 0600 .ssh/id_*
}

installing_zsh() {
    echo 'Installing zsh'
    sudo apt install -y zsh
}

installing_oh_my_zsh() {
    echo 'Installing oh-my-zsh'
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended
}

installing_starship() {
    echo 'Installing Starship'
    curl -fsSL https://starship.rs/install.sh | bash -s -- -y
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
}

setup_wsl() {
    # # Get the IP address of the host from /etc/resolv.conf
    # export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

    # # Set the display path
    # export DISPLAY=$WSL_HOST:0.0
}

post_step() {
    echo 'Switching to zsh'
    # chsh -s /bin/zsh 
    zsh
}

main() {
    setup_dotfiles
    installing_zsh
    installing_oh_my_zsh
    installing_starship
    setup_wsl
    post_step
}

main "$@"