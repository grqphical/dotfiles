# grqphical's dotfiles

These are my personal dotfiles for ZSH, TMUX, Oh-My-Posh and Neovim running on Debian with WSL 2

I also have included utility scripts of mine for things like creating reuseable TMUX sessions

## Install

Clone this repository to your home directory

```bash
git clone https://github.com/grqphical/dotfiles
```
Or better yet use something like `stow` to manage your dotfiles

```bash
# Install it first (use whatever package manager you have)
sudo apt install stow
git clone https://github.com/grqphical/dotfiles ~/dotfiles
cd dotfiles
stow .
```

## License

The dotfiles are public domain whilst any script in the `scripts/` folder is licensed under the MIT license, outlined in `LICENSE`
