#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
AUR_HELPER=paru
if [[ $(which $AUR_HELPER &>/dev/null) -eq 0 ]]; then
	echo -e "${red}-E- paru not found, using yay${reset}";
	AUR_HELPER=yay;
	echo -e "${green}-I- Done${reset}";
fi
echo -e "${green}-I- Updating with aur helper and installing dependencies${reset}"
$AUR_HELPER -Syu
$AUR_HELPER -S papirus-folders papirus-nord papirus-icon-theme chrome-gnome-shell #gdm-tools #GDM theme is broken, don't do this one
echo -e "${green}-I- Updated with aur helper"
echo -e "-I- cloning Nordic gtk/kvantum theme${reset}"
git clone https://github.com/EliverLara/Nordic.git
sudo cp -r Nordic /usr/share/themes
rm -rf Nordic/
echo -e "${green}-I- Done, Nordic theme it should be on the list in gnome tweaks${reset}"
echo -e "${green}-I- cloning nord-gnome-terminal theme${reset}"
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
nord-gnome-terminal/src/nord.sh
rm -rf nord-gnome-terminal/
echo -e "${green}-I- Done, Nordic GNOME Terminal theme installed, it should be on the list in gnome-terminal profiles"
echo -e "-I- cloning nord-gedit theme${reset}"
git clone https://github.com/arcticicestudio/nord-gedit.git
cd nord-gedit
./install.sh
cd ../
rm -rf nord-gedit/
echo -e "${green}-I- Done, Nordic gedit theme installed, it should be on the list under Fonts & Colors tab"
echo -e "-I- Installing papirus icons${reset}"
papirus-folders -t Papirus-Dark -C nordic
echo -e "${green}-I- Done, papirus icon colors changed, it should be on the list in gnome tweaks, need to set to Papirus-Dark${reset}"
#echo -e "${green}-I- Installing Nordic gdm theme${reset}"
#set-gdm-theme set Nordic #GDM theme is broken, don't do this one
#echo -e "${green}-I- Installed Nordic gdm theme${reset}"
