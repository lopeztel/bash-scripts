#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"


if ! [ -x "$(command -v alacritty)" ]; then
	echo -e "${red}-E- alacritty not found, installing alacritty ${reset}";
	sudo pacman -S alacritty
    mkdir ~/.config/alacritty
    cp /usr/share/doc/alacritty/example/alacritty.yml
	echo -e "${green}-I- Done${reset}";
fi
if ! [ -x "$(command -v zsh)" ]; then
	echo -e "${red}-E- zsh not found, installing zsh ${reset}";
	sudo pacman -S zsh
	chsh -s /usr/bin/zsh
	echo -e "${green}-I- Done${reset}";
elif [[ $SHELL != zsh ]]; then
	echo -e "${red}-E- default shell is not zsh, making default ${reset}";
	chsh -s /usr/bin/zsh
	echo -e "${green}-I- Done${reset}";
fi
echo -e "${green}-I- Installing oh-my-zsh${reset}"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo -e "${green}-I- Installed oh-my-zsh"
echo -e "-I- Installing necessary plugins for oh-my-zsh${reset}"
sudo pacman -S zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
#echo 'source /usr/share/zsh/plugins/zsh-completions/zsh-completions.zsh' >>~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh' >>~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo -e "${green}-I- Installed necessary plugins for oh-my-zsh"

echo -e "${green}-I- Installing agave nerd font${reset}"
paru -S nerd-fonts-agave
echo -e "${green}-I- Done${reset}";

if ! [ -x "$(command -v nvim)" ]; then
	echo -e "${red}-E- neovim not found, installing neovim ${reset}";
	sudo pacman -S neovim
	echo -e "${green}-I- Done${reset}";
fi
echo -e "-I- Installing neovim complements${reset}"
sudo pacman -S ripgrep fd neovim python-pynvim nodejs npm yarn lazygit python-pip
paru -S clang-format-static-bin
pip install compiledb
echo 'export PATH=/opt/clang-format-static:~/.local/bin:$PATH' >>~/.zshrc
echo -e "${green}-I- Installing vim-plug${reset}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo -e "${green}-I- Installed vim-plug"
echo -e "-I- Installed neovim${reset}"
echo -e "-I- Installing init.vim"
cd ~/
git clone https://github.com/lopeztel/bash-scripts.git
mkdir -p .config/nvim/ 
cp bash-scripts/init.vim .config/nvim/
rm -rf bash-scripts
echo -e "${green}-I- Installed init.vim${reset}"
nvim -c PlugInstall
