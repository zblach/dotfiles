# define any mercury-specific zsh settings here
# cli syntax highlighting
source ~/.zsh/bundles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# predictive tab completion
source ~/.zsh/bundles/zsh-autosuggestions/autosuggestions.zsh
zle-line-init() {
	zle autosuggest-start
}
zle -N zle-line-init

bindkey '^f' vi-forward-blank-word

# tab-completion for predictive tab completion
autoload predict-on
zle -N predict-on
# define any shell-agnostic settings (like aliases) in $HOME/.aliases/mercury
