# zshrc - zblach 2015
typeset -gxU path PATH

# Modules
autoload colors zsh/terminfo
autoload -Uz compinit && compinit -u
autoload -U is-at-least

# Load a pre.zshrc file, if exists
if [[ -a "$HOME/.local.pre.zshrc" ]]; then
	source "$HOME/.local.pre.zshrc"
fi
################################################################################
# ZGEN bundle management                                                       #
################################################################################
# https://github.com/tarjoilija/zgen
if [[ -d "$HOME/.zgen" && ! -f "$HOME/.zgen/zgen.zsh" ]]; then
    git clone https://github.com/tarjoilija/zgen "$HOME/.zgen"
fi
if [[ -a "$HOME/.zgen/zgen.zsh" ]]; then
    source "$HOME/.zgen/zgen.zsh"
    if ! zgen saved; then
        echo "zgen not initialized. initializing."

        # Plugins
        zgen load supercrabtree/k
        zgen load unixorn/git-extra-commands
        zgen load zsh-users/zsh-history-substring-search
        zgen load zsh-users/zsh-completions src
        zgen load zsh-users/zsh-autosuggestions
        zgen load zsh-users/zsh-syntax-highlighting

        zgen load jocelynmallon/zshmarks
        zgen load RobSis/zsh-completion-generator

        zgen load bobthecow/git-flow-completion

        zgen save
    fi
fi

################################################################################
# VARIABLES, MODULES, OPTIONS, HISTORY, AND ZSTYLE                             #
################################################################################

# History
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

export HISTFILE="$HOME/.zsh/${HOSTNAME}.history"
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
setopt pushdignoredups
setopt pushdminus
setopt pushdsilent
setopt pushdtohome
setopt share_history

unsetopt nomatch

# ZStyle

# Cache Tab Expansions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
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
zstyle :compinstall filename "$HOME/.zsh/cache/comp_cache"

################################################################################
# MODULES, EXPORTS, PROMPTS, ALIASES, AND COLORS                               #
################################################################################

# Manpage Readability
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

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
bindkey "[A" history-substring-search-up
bindkey "[B" history-substring-search-down
bindkey "^ " end-of-line
bindkey "" forward-word

################################################################################
# TERMINAL DISPLAY HOOKS                                                       #
################################################################################

export TERM=xterm-256color

#zle-keymap-select () {
#	if [ "$TERM" = "xterm-256color" ]; then
#		if [ $KEYMAP = vicmd ]; then
#			echo -ne "\e[4 q"
#		else
#			echo -ne "\e[2 q"
#		fi
#	fi
#}

#zle -N zle-keymap-select

################################################################################
# HOST-SPECIFIC ALIASES AND CONFIGURATIONS                                     #
################################################################################

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
alias -g '@f'='**/*(.mm-61)'

alias f='find . -mmin -61'
alias sl=ls
alias l=ls
alias s=;

cdd() { cd `dirname $1` }

# Prompts
colors

export PS1="%{$fg[default]%}[%{$fg[cyan]%}%n%{$fg[white]%}@%{$fg[red]%}%2m%{$fg[default]%}:%{$fg[green]%}%40<..<%{$fg[magenta]%}%~%{$fg[default]%}]%# "
export RPS1="%{$fg[default]%}[%(?.%{$fg[gray]%}.%{$fg[red]%})%?%{$fg[default]%} %D{%H:%M:%S}]%{$fg[default]%}"

# source local configuration file
if [[ -a "$HOME/.local.zshrc" ]]; then
	source "$HOME/.local.zshrc"
fi
