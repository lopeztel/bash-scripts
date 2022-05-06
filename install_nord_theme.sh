#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo -e "${red}-I- Not running as root, exit${reset}"
    exit
fi
echo -e "${green}-I- Updating with pacman${reset}"
sudo pacman -Syu
echo -e "${green}-I- Updated with pacman"
echo -e "-I- Updating with paru${reset}"
sudo paru -Syu
echo -e "${green}-I- Updated with paru${reset}"
sudo pacman -S --noconfirm gnome-tweaks
paru -S --noconfirm gdm-tools
cd
#echo -e "${green}-I- cloning Nordic gtk/kvantum theme${reset}"
#git clone https://github.com/EliverLara/Nordic.git
#sudo cp -r Nordic /usr/share/themes
#echo -e "${green}-I- Nordic theme installed, it should be on the list in gnome tweaks"
#echo -e "-I- Installing Nordic gdm theme"
#sudo set-gdm-theme set Nordic
#echo -e "-I- Installed Nordic gdm theme${reset}"
#echo -e "${green}-I- cloning nord-gnome-terminal theme${reset}"
#git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
#nord-gnome-terminal/src/nord.sh
#echo -e "${green}-I- Nordic GNOME Terminal theme installed, it should be on the list in gnome-terminal profiles"
#echo -e "-I- cloning nord-gedit theme${reset}"
#git clone https://github.com/arcticicestudio/nord-gedit.git
#cd nord-gedit
#./install.sh
#cd ../
#echo -e "${green}-I- Nordic gedit theme installed, it should be on the list under Fonts & Colors tab"
#echo -e "-I- Installing papirus icons${reset}"
#sudo pacman -S --noconfirm papirus-icon-theme papirus-folders
#paru -S --noconfirm papirus-nord
#papirus-folders -t Papirus-Dark -C nordic
#echo -e "${green}-I- papirus icons installed, it should be on the list in gnome tweaks, need to set to Papirus-Dark"

#echo -e "-I- Installing oh-my-zsh${reset}"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#echo -e "${green}-I- Installed oh-my-zsh"
#echo -e "-I- Installing necessary plugins for oh-my-zsh${reset}"
#sudo pacman -S --noconfirm zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k
#echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
#echo 'source /usr/share/zsh/plugins/zsh-completions/zsh-completions.zsh' >>~/.zshrc
#echo 'source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh' >>~/.zshrc
#echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
#echo -e "${green}-I- Installed necessary plugins for oh-my-zsh"

#echo -e "-I- Installing neovim${reset}"
#sudo pacman -S --noconfirm fd ripgrep fd neovim neovim-qt python-pynvim
#echo -e "${green}-I- Installing vim-plug${reset}"
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#echo -e "${green}-I- Installed vim-plug"
#echo -e "-I- Installed neovim${reset}"
