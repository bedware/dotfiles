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
    cd ~
    git init && \
    git remote add origin https://github.com/bedware/dotfiles.git && \
    git pull origin master && \
    git submodule update --init -j 2 && \
    chmod 0600 .ssh/id_*
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
    log 'eval "$(starship init zsh)"' >> ~/.zshrc
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
    setup_default_shell
    post_step
}

main "$@"
