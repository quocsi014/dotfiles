# Enable Powerlevel10k instant prompt (improves shell startup speed).
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Handle Ctrl+C to display a message and terminate the process.
trap 'echo "Process terminated"; kill -INT $$' INT

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add Go binaries and tools to PATH.
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

# Use the "robbyrussell" theme for Oh My Zsh.
ZSH_THEME="robbyrussell"

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


bindkey '^K' up-line-or-history

# Aliases for common commands.
alias bat="batcat"  # Use batcat for syntax highlighting.
alias ls="eza --icons --group-directories-first"  # Enhanced ls.
alias ll="eza --icons --group-directories-first -al"  # Detailed ls.
alias po="init 0"  # Power off the system.
alias c="clear"  # Clear terminal.
alias ss="source .zshrc"  # Reload .zshrc.

# FZF configuration.
alias fv="fzf -e --preview 'batcat --theme=tokyonight --color=always {}' | xargs nvim"  # Open selected file in Neovim.
alias fp="fzf -e --preview 'batcat --theme=tokyonight --color=always {}'"  # Preview file with batcat.
#docker
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dc="docker compose"
# Powerlevel10k configuration.
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
