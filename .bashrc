# If shell is interactive.
[[ $- != *i* ]] && return

export PS1='\u@\h : \[\e[90m\]\w\[\e[0m\] $ '

# Definitions.
export EDITOR=$(which vim)
export GOPATH=~/src/go
export CDPATH=.:$GOPATH/src/github.schibsted.io/spt-security/
export PATH=$PATH:/sbin/:/usr/sbin/:~/bin/:~/scripts/:/usr/local/go/bin/:$GOPATH/bin/
export TERM='xterm-256color'
export _JAVA_AWT_WM_NONREPARENTING=1

# Aliases.
alias ls='ls --color=auto'
alias ll='ls -alhrtF'
alias l='ll'
alias bang='disown & exit'
alias newest='ls -rt | tail -1'

# History options.
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

# Adapt buffer size.
shopt -s checkwinsize

# Advanced completion.
CWPATH=$GOPATH/src/github.com/gguillemas
CWPATH=$CWPATH:$GOPATH/src/github.schibsted.io/spt-security
CWPATH=$CWPATH:$GOPATH/src/github.schibsted.io/gerard-guillemas

cw() {
   CDPATH=$CWPATH cd $@
}

_cw() {
   CDPATH=$CWPATH _cd
}

complete -o nospace -F _cw cw

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Fill buffer to fix urxvt window resize bug.
for i in {1...$LINES}; do echo; done; clear
