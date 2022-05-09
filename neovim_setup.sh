#!/bin/env bash
set -e
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
echo -e "${green}-I- Installing oh-my-zsh${reset}"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo -e "${green}-I- Installed oh-my-zsh"
echo -e "-I- Installing necessary plugins for oh-my-zsh${reset}"
sudo pacman -S --noconfirm zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k
echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-completions/zsh-completions.zsh' >>~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh' >>~/.zshrc
echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>~/.zshrc
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo -e "${green}-I- Installed necessary plugins for oh-my-zsh"

echo -e "-I- Installing neovim${reset}"
sudo pacman -S --noconfirm ripgrep fd neovim python-pynvim nodejs npm lazygit
python -m pip install clang-format
echo -e "${green}-I- Installing vim-plug${reset}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo -e "${green}-I- Installed vim-plug"
echo -e "-I- Installed neovim${reset}"
