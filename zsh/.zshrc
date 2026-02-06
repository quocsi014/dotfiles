# Enable Powerlevel10k instant prompt (improves shell startup speed).
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Handle Ctrl+C to display a message and terminate the process.
trap 'echo "Process terminated"; kill -INT $$' INT

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add Go binaries and tools to PATH.
# export GOPATH="$HOME/go"
# export GOBIN="$GOPATH/bin"
# export GOROOT="/snap/go/current"
# export PATH="$PATH:$GOROOT/bin:$GOBIN"
# Go configuration - Auto-detect installation method
if [ -d "/snap/go/current" ]; then
    # Company machine - Go from snap
    export GOROOT="/snap/go/current"
elif [ -d "/usr/local/go" ]; then
    # Personal machine - Go from tarball
    export GOROOT="/usr/local/go"
fi

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin:$GOBIN"
export GOPRIVATE="gitlab.deepgate.io"
export GOMODCACHE="$GOPATH/pkg/mod"

# Use the "robbyrussell" theme for Oh My Zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Terminal color settings.
export TERM="xterm-256color"

# Add .NET tools to PATH.
export PATH="$PATH:/home/quocsi/.dotnet/tools"
export DOTNET_ROOT=/usr/share/dotnet
export PATH=$PATH:/usr/share/dotnet

# Rust configuration.
. "$HOME/.cargo/env"

# Add local binaries to PATH.
export PATH="$HOME/.local/bin:$PATH"

# Enable plugins for Oh My Zsh.
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh


bindkey '^ ' autosuggest-accept

#vim style
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
export KEYTIMEOUT=1

# Aliases for common commands.
alias bat="batcat"  # Use batcat for syntax highlighting.
alias ls="eza --icons --group-directories-first"  # Enhanced ls.
alias ll="eza --icons --group-directories-first -al"  # Detailed ls.
alias po="init 0"  # Power off the system.
alias c="clear"  # Clear terminal.
alias ss="source ~/.zshrc"  # Reload .zshrc.
alias x="exit"

# FZF configuration.
alias fv="fzf -e --preview 'batcat --theme=tokyonight --color=always {}' | xargs nvim"  # Open selected file in Neovim.
alias fp="fzf -e --preview 'batcat --theme=tokyonight --color=always {}'"  # Preview file with batcat.

#docker
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dc="docker compose"
alias lzd="lazydocker"

#git
alias gaa="git add ."
alias ga="git add"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcom="git checkout main"
alias gcon="git checkout -b"
alias gp="git push"
alias gph="git push -u origin HEAD"
alias gpf="git push -f"
alias gpl="git pull"
alias gst="git status"
alias gplm="git pull origin main"
alias gplo="git pull origin"
alias gm="git merge"
alias gmm="git merge origin/main"
alias gbd="git branch -D"
alias gbm="git branch -m"
alias gb="git branch"
alias gl="git log"
alias grl="git reflog"
alias gcp="git cherry-pick"

alias f="fuck"

eval $(thefuck --alias)
#zayi
alias fm="yazi"

alias web="brave-browser"
# Powerlevel10k configuration.
# source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias cbr="cobra-cli"

#golang
alias gomt="go mod tidy"
alias goi="go install"
alias gor="go run ."
alias gob="go build ."
alias golint="golangci-lint run -c ~/dev/bzt/.golangci.yml --new"
alias golintall="golangci-lint run -c ~/dev/bzt/.golangci.yml"

# pnpm
export PNPM_HOME="/home/quocsi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(thefuck --alias)"
eval "$(thefuck --alias)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -s "/home/quocsi/.gvm/scripts/gvm" ]] && source "/home/quocsi/.gvm/scripts/gvm"
