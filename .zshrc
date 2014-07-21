typeset -U path
if [[ -a "$HOME/.local.pre.zshrc" ]]; then
	source "$HOME/.local.pre.zshrc"
fi

################################################################################
# VARIABLES, MODULES, OPTIONS, HISTORY, AND ZSTYLE                             #
################################################################################

# Modules
autoload colors zsh/terminfo
autoload -Uz compinit && compinit -u

# History
export HOSTNAME_SHORT=${$(hostname)//[\.\-][0-9]+/}
export EDITOR=vim
export PAGER=less

# Language & Formatting
#export LANG=en_US.UTF-8
#export LC_LANG=$LANG

# Check for existence of ~/.zsh/
if [ ! -d "$HOME/.zsh" ]; then
    colors
    echo "${fg_bold[red]}error: ${fg[default]} could not find ~/.zsh/. Some things may not work as intended." >&2
	#mkdir "$HOME/.zsh/"
fi

if [ ! -f "$HOME/.zsh/${HOSTNAME_SHORT}.history" ]; then
    colors
    echo "${fg_bold[yellow]}warning: ${fg[default]} creating ~/.zsh/${HOSTNAME_SHORT}.history" >&2
	touch "$HOME/.zsh/${HOSTNAME_SHORT}.history"
fi

export HISTFILE="$HOME/.zsh/${HOSTNAME_SHORT}.history"
export HISTSIZE=10000
export SAVEHIST=5000

# Options
setopt autolist
setopt autopushd
setopt cdablevars
setopt correctall
setopt extended_history
setopt globdots
setopt hist_verify
setopt histignoredups
setopt interactivecomments
setopt longlistjobs
setopt nobgnice
setopt noclobber
setopt prompt_subst
#setopt share_history

# ZStyle

# Cache Tab Expansions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache/$HOSTNAME_SHORT"
zstyle ':completion:*:expand:*' tag-order all-expansions

# ...EXCEPT for CVS
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# ...and current working directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Fuzzy match fat fingered commands
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only

# Expanding error tolerance
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Ignore completion for nonexistant functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Menu selection for PIDS in kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Colorful tab-expanded lists
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Messages and prompts
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''


# Don't autocomplete all users
complete_users=(root $USERNAME)
zstyle ':completion:*' users $complete_users

# Offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Tab completion includes file redirection
zstyle :insert-last-word match '*([[:digit:]]?|[[:alpha:]/\\])*'

# Store the expansion cache here
zstyle :compinstall filename "$HOME/.zshrc"

################################################################################
# MODULES, EXPORTS, PROMPTS, ALIASES, AND COLORS                               #
################################################################################

# Manpage Readability
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;35m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

################################################################################
# KEYS AND KEY BINDINGS                                                        #
################################################################################

# Proper key behaviour
bindkey -v 
#bindkey "[3~" delete-char
#bindkey "[1~" beginning-of-line
#bindkey "[4~" end-of-line
#bindkey "[2~" quoted-insert

# History search
bindkey "[A" history-beginning-search-backward
bindkey "[B" history-beginning-search-forward


################################################################################
# HOST-SPECIFIC ALIASES AND CONFIGURATIONS                                     #
################################################################################

# Custom .zshrc
if [ ! -f "$HOME/.zsh/$HOSTNAME_SHORT.zshrc" ]; then
	colors
	echo "${fg_bold[yellow]}warning: ${fg[default]} could not find host-specific zshrc file. Creating empty one." >&2
	echo "# define any ${HOSTNAME_SHORT}-specific zsh settings here\n# define any shell-agnostic settings (like aliases) in \$HOME/.aliases/${HOSTNAME_SHORT}" > "$HOME/.zsh/$HOSTNAME_SHORT.zshrc"
else
    . "$HOME/.zsh/${HOSTNAME_SHORT}.zshrc"
fi

# Additional shell-agnostic aliases
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases";
fi

# Z-shell style aliases
# global aliases
alias -g '@C'='| acat'
alias -g '@S'='| sort'
alias -g '@T'='| tail -f'
alias -g '@U'='| sort | uniq'

# Prompts
colors

#export PS1="[%n@%2m:%40<..<%~]%# "
export PS1="%{$fg[default]%}[%{$fg[cyan]%}%n%{$fg[white]%}@%{$fg[red]%}%2m%{$fg[default]%}:%{$fg[green]%}%40<..<%{$fg[magenta]%}%~%{$fg[default]%}]%# "
#export PS1="%{$fg[black]$bg[cyan]%} %n %{$fg[cyan]$bg[red]%}⮀%{$fg[black]%} ${HOSTNAME_SHORT} %{$fg[red]$bg[magenta]%}⮀%{$fg[black]%} %~ %{$fg[magenta]$bg[default]%}⮀%{$fg[default]$bg[default]%} "

#export RPS1="%{$fg[default](?.$fg[white].$fg[red])%}⮂%{$fg[black]%(?.$bg[white].$bg[red])%} %? %{$fg[grey]%}⮂%{$bg[grey]$fg[white]%} %D{%H:%M:%S}%{$fg[default]$bg[default]%}" 
export RPS1="%{$fg[default]%}[%{%(?.$fg[gray].$fg[red])%}%?%{$fg[default]%} %D{%H:%M:%S}]%{$fg[default]%}"
#export RPS1="[%? %D{%H:%M:%S}]"

# Break ancient xterm compatibility
export TERM=xterm-256color

# source local configuration file
if [[ -a "$HOME/.local.zshrc" ]]; then
	source "$HOME/.local.zshrc"
fi
