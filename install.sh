#!/bin/zsh

cat << "EOF"

 _____ ______ ___________ _   _ _____ _____   ___   _     
|  __ \| ___ \  _  | ___ \ | | |_   _/  __ \ / _ \ | |    
| |  \/| |_/ / | | | |_/ / |_| | | | | /  \// /_\ \| |    
| | __ |    /| | | |  __/|  _  | | | | |    |  _  || |    
| |_\ \| |\ \\ \/' / |   | | | |_| |_| \__/\| | | || |____
 \____/\_| \_|\_/\_\_|   \_| |_/\___/ \____/\_| |_/\_____/
                                                          
                                                          
EOF

echo "Installing dependencies..."

sudo apt update
sudo apt upgrade
sudo apt install -y build-essential git fastfetch tmux stow

echo "Installed tmux, git, gcc, fastfetch, tmux, stow"

rm ~/.zshrc
rm -rf ~/.config
rm -rf ~/scripts

cd ~/dotfiles && stow .

"Added dotfiles to stow"

if ! command -v zsh >/dev/null 2>&1; then
    echo "Installing ZSH..."
    sudo apt install -y zsh
    sudo chsh -s $(which zsh)
fi

if ! command -v nvim >/dev/null 2>&1; then
    echo "Installing Neovim..."
    mkdir ~/.temp
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -O ~/.temp/
    mkdir -p ~/.local/bin
    tar -xvf ~/.temp/nvim-linux-x86_64.tar.gz -C ~/.local/bin
fi

echo "All dependencies have been installed. Enjoy my dotfiles!"
