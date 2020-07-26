#!/bin/bash

# Show extra debug info
set -e

enable_colors() {
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

log() {
    echo ${RED}"$@"${RESET}
}

setup_dotfiles() {
    log "Installing Dotfiles"
    SSH_INSTALL=yes
    printf "${YELLOW}Do you want to skip ssh keys installation? [Y/n]${RESET} "
	read opt
	case $opt in
		y*|Y*|"") echo "Going to next step..."; SSH_INSTALL=no ;;
		n*|N*) echo "Ssh keys are going to install" ;;
		*) echo "Invalid choice. Ssh keys installation will be skipped."; SSH_INSTALL=no ;;
	esac
    cd ~
    rm .zshrc .oh-my-zsh/custom/example.zsh && \
    git init && \
    git remote add origin https://github.com/bedware/dotfiles.git && \
    git pull origin master
    if [ SSH_INSTALL -eq yes ]; then
        git submodule update --init -j 2 && \
        chmod 0600 .ssh/id_*
    fi
}

install_zsh() {
    log "Installing zsh"
    sudo apt install -y zsh
}

install_oh_my_zsh() {
    log "Installing oh-my-zsh"
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- --unattended --keep-zshrc
}

install_starship() {
    log "Installing Starship"
    curl -fsSL https://starship.rs/install.sh | bash -s -- -y
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
}

install_brew() {
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
    echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/$USER/.zprofile
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    sudo apt update
    sudo apt install build-essential -y
}

install_utils() {
    brew install exa tldr hub
    sudo apt install jq -y
}

setup_default_shell() {
    log "Settings zsh default shell"
    sudo chsh $USER -s $(which zsh)
}

post_step() {
    log "Setup complete! Please relogin."
}

main() {
    enable_colors
    install_zsh
    install_oh_my_zsh
    install_starship
    setup_dotfiles
    install_brew
    install_utils
    setup_default_shell
    post_step
}

main "$@"
