#!/bin/bash

# Show extra debug info
set -e

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

setup_dotfiles () {
    echo "${RED}We are setting up${RESET}"
    echo "${RED}Installing Dotfiles${RESET}"
    cd ~
    git init && \
    git remote add origin https://github.com/bedware/dotfiles.git && \
    git pull origin master && \
    git submodule update --init -j 2 && \
    chmod 0600 .ssh/id_*
}

installing_zsh() {
    echo "${RED}Installing zsh${RESET}"
    sudo apt install -y zsh
}

installing_oh_my_zsh() {
    echo "${RED}Installing oh-my-zsh${RESET}"
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended
}

installing_starship() {
    echo "${RED}Installing Starship${RESET}"
    curl -fsSL https://starship.rs/install.sh | bash -s -- -y
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
}

setup_wsl() {
    echo 'Something for wsl'
    # # Get the IP address of the host from /etc/resolv.conf
    # export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)

    # # Set the display path
    # export DISPLAY=$WSL_HOST:0.0
}

post_step() {
    echo "${RED}Switching to zsh${RESET}"
    eval 'chsh -s $(which zsh)'
    # zsh
}

main() {
    setup_color
    setup_dotfiles
    installing_zsh
    installing_oh_my_zsh
    installing_starship
    setup_wsl
    post_step
}

main "$@"