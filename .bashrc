# Shell Options
shopt -s histappend
shopt -s cdspell
shopt -s autocd

# language
export LANG="en_US.UTF-8"

# Bash Completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# PS1
case $TERM in
  xterm*|linux*)
    PS1='\[\033[0;37m\][\[\033[0;34m\]\u\[\033[0;37m\]@\[\033[0;31m\]\h \[\033[0;32m\](0:\j) \[\033[0;35m\]\W\[\033[0;37m\]]\[\033[0m\]\$ '
  ;;
  screen*)
    PS1='\[\033k\033\\\]\[\033[0;37m\][\[\033[1;33m\]($?) \[\033[0;35m\]\W\[\033[0;37m\]]\[\033[0m\]\$ ' 
  ;;
esac

# Screen-specific aliases
if [[ $TERM =~ screen* ]]; then
  man() {
    echo -n -e "\033kman:$1\033\0134";
    command man $@;
  }
  ssh() {
    echo -n -e "\033kssh:$1\033\0134";
    command ssh $@;
  }
  vim() {
    echo -n -e "\033kvim:$1\033\0134";
    command vim $@;
  }
  sudo() {
    echo -n -e "\033ksudo:$1\033\0134";
    command sudo $@;
  }
  nano() {
    echo -n -e "\033knano:$1\033\0134";
    command nano $@;
  }
fi

# manpage readability exports
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# default editor export
export EDITOR=vim

# Parse device-specific profile info
SHORTHOST=${HOSTNAME//[0-9]/}

if [ -f "$HOME/.bashrc.$SHORTHOST" ]; then
  source "$HOME/.bashrc.$SHORTHOST"
fi
