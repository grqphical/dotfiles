ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir - p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias neofetch='fastfetch --logo linux'
alias vim=nvim
alias sd="cd ~ && cd \$(find * -type d | fzf)"
alias devenv="create-dev-env.sh"

# Git aliases
alias gs='git status --short'
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

# Tmux aliases
alias tn="tmux new-session -s"
alias tl="tmux list-sessions"
alias ta="tmux attach-session"
alias tk="tmux kill-session"
alias td="create-dev-tmux.sh"

export GOROOT=/usr/local/go
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/language-servers:$PATH
export PATH=$PATH:/home/grqphical/.local/bin
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export EDITOR="/opt/nvim-linux-x86_64/bin"
export GPG_TTY=$(tty)


eval "$(oh-my-posh init zsh --config ~/posh-themes/grqphical.toml)"
eval "$(fzf --zsh)"

# print my custom header
echo "                 _   _         _ "
echo " ___ ___ ___ ___| |_|_|___ ___| |"
echo "| . |  _| . | . |   | |  _| .'| |"
echo "|_  |_| |_  |  _|_|_|_|___|__,|_|"
echo "|___|     |_|_|  "
echo

# fnm
FNM_PATH="/home/grqphical/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/grqphical/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
