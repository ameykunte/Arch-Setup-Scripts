#!/bin/bash
set -e

# Function to install snapd package manager
function install_snapd {
    echo "Installing snapd..."
    sudo pacman -S snapd --noconfirm
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
}

# Function to install snap packages
function install_snap_packages {
    echo "Installing snap packages..."
    read -p "Install Discord? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install discord | pv -p -t -e >/dev/null
    fi

    read -p "Install Notion? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install notion-snap | pv -p -t -e >/dev/null
    fi

    read -p "Install Spotify? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install spotify | pv -p -t -e >/dev/null
    fi

    read -p "Install WhatsApp for Linux? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install whatsapp-for-linux | pv -p -t -e >/dev/null
    fi

    read -p "Install Teams? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install teams | pv -p -t -e >/dev/null
    fi

    read -p "Install VLC? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install vlc | pv -p -t -e >/dev/null
    fi

    read -p "Install Prospect Mail? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install prospect-mail | pv -p -t -e >/dev/null
    fi

    read -p "Install VS Code? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo snap install code --classic | pv -p -t -e >/dev/null
    fi
}

# Function to install basic tools
function install_basic_tools {
    echo "Installing basic tools..."
    sudo pacman -S git curl wget base-devel python python-pip nodejs npm --noconfirm | pv -p -t -e >/dev/null
}

# Function to update the system
function update_system {
    echo "Updating the system..."
    sudo pacman -Syu --noconfirm | pv -p -t -e >/dev/null
    sudo pacman -S preload htop tlp --noconfirm | pv -p -t -e >/dev/null
    sudo systemctl enable --now preload tlp
}

# Function to clean up the system
function clean_up {
    echo "Cleaning up the system..."
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm | pv -p -t -e >/dev/null
}

# Main function
function main {
    echo "Downloading and installing important apps..."
    install_snap_packages
    install_basic_tools
    update_system
    clean_up
    echo "All done! Enjoy your new laptop."
}

main
