# grqphical's dotfiles

These are my personal dotfiles for ZSH, TMUX, Oh-My-Posh and Neovim running on Debian with WSL 2

If you wish to use language servers, install them manually using `NPM` or by downloading them from their repo (in the case of `lua_ls`). `clangd` can be installed through apt

## Install

Clone this repository to your home directory

```bash
git clone https://github.com/grqphical/dotfiles
```
Use something like `stow` create symlinks in your home directory

```bash
# Install it first (use whatever package manager you have)
sudo apt install stow
git clone https://github.com/grqphical/dotfiles ~/dotfiles
cd dotfiles
stow .
```
