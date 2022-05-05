#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
# CONFIG_FILE=${CONFIG_FILE:-/etc/libvirt/libvirtd.conf}
# SOCKET_GROUP_KEY=${SOCKET_GROUP_KEY:-unix_sock_group}
# SOCKET_GROUP_VALUE=${SOCKET_GROUP_VALUE:-libvirt}
# SOCKET_RW_PERM_KEY=${SOCKET_RW_PERM_KEY:-unix_sock_rw_perms}
# SOCKET_RW_PERM_VALUE=${SOCKET_RW_PERM_VALUE:-0770}
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo -e "${red}-I- Not running as root, exit${reset}"
    exit
fi
echo -e "${green}-I- Installing virt-manager dependencies${reset}"
sudo pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs
# sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables libguestfs
echo -e "${green}-I- Done"
echo -e "-I- Enabling and starting libvirtd.service${reset}"
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
echo -e "${green}-I- Done${reset}"
systemctl status libvirtd.service
# echo -e "${green}-I- Modifying config file${reset}"
# sudo sed -n -i "s/\($SOCKET_GROUP_KEY *= *\).*/\1\"$SOCKET_GROUP_VALUE\"/" $CONFIG_FILE
# sudo sed -n -i "s/\($SOCKET_RW_PERM_KEY *= *\).*/\1\"$SOCKET_RW_PERM_VALUE\"/" $CONFIG_FILE
# echo -e "${green}-I- Done"
echo -e "-I- Modifying group permissions${reset}"
sudo usermod -a -G libvirt-qemu $(whoami)
sudo usermod -a -G libvirt $(whoami)
echo -e "${green}-I- Done"
echo -e "-I- Restarting libvirtd.service${reset}"
sudo systemctl restart libvirtd.service
echo -e "${green}-I- Done${reset}"

#taken from: https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/
