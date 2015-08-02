# define any mercury-specific zsh settings here
bindkey '^f' vi-forward-blank-word

# tab-completion for predictive tab completion
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-initautoload predict-on
zle -N predict-on
# define any shell-agnostic settings (like aliases) in $HOME/.aliases/mercury
