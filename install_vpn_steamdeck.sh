#!/bin/bash
# disable unmutable file system
sudo steamos-readonly disable

# Download and install latest zst package
wget https://archlinux.org/packages/core/any/archlinux-keyring/download -P ~/Downloads
# sudo pacman -U <file_name>

#if above doesn't work
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman-key --refresh keys

# install packages
sudo pacman -S openvpn openconnect networkmanager-openvpn networkmanager-openconnect

# re-enable unmutable file system
sudo steamos-readonly enable
