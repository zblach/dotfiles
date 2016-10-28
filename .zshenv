# Local zshenv?
if [[ -a "$HOME/.local.zshenv" ]]; then
	source "$HOME/.local.zshenv"
fi

# Colorcat!
alias pyg="pygmentize -f 256 -O bg=dark,style=monokai,linenos=1,encoding=utf-8"
alias acat="pyg -g"
alias bcat="pyg -l bash"
alias jcat="pyg -l java"
alias lcat="pyg -l dcl"
alias xcat="pyg -l xml"

export LESSOPEN='|acat %s'

#fat-fingered ls commands
alias l=ls
alias sl=ls
alias s=;

#fat-fingered cd commands
alias c=cd
alias dc=cd
alias d=;

#nicer default options
alias less='less -R'
alias grep='grep --color=auto -n -C 5'
alias ls='ls -G'

#colorize directory separators
alias cpwd='echo ${PWD//\//"\033[1;32m"\/"\033[0m"}'

cdd() {
	cd `dirname ${1}`
}
u () {
	set -A ud
	ud[1+${1-1}]=
	cd ${(j:../:)ud}
}

# lazy commands
alias f='find . -type f -mmin -61 '
alias -g @f='**/*(.mm-61)'

alias :e='vim '
