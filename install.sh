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

echo "Installing NodeJS"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

echo "Installing Language Servers"
npm install -g pyright
npm install -g vscode-language-servers-extracted

mkdir ~/language-servers/
wget https://github.com/Myriad-Dreamin/tinymist/releases/download/latest/tinymist-linux-x64 -O ~/language-servers/tinymist
wget https://github.com/LuaLS/lua-language-server/releases/download/3.15.0/lua-language-server-3.15.0-linux-x64.tar.gz
tar -xvf lua-language-server-3.15.0-linux-x64.tar.gz -C ~/lua/
mv ~/lua ~/language-servers/


echo "All dependencies have been installed. Enjoy my dotfiles!"
