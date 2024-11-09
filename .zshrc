# Load and initialise completion system
autoload -Uz compinit
compinit
alias ls="exa -a --icons"
alias ll="exa -al --icons"
alias lt="exa -a --tree --level=1 --icons"
export GTK_THEME=Dracula
export ARUBA_ACCESS_TOKEN="your_token_here"
export PATH=$PATH:$HOME/go/bin
eval "$(starship init zsh)"


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
