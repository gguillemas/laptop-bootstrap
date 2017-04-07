# If shell is interactive.
[[ $- != *i* ]] && return

export PS1='\u@\h : \[\e[90m\]\w\[\e[0m\] $ '

# Definitions.
export EDITOR=$(which vim)
export GOPATH=~/src/go
export PATH=$PATH:/sbin/:/usr/sbin/:~/bin/:~/scripts/:~$GOPATH/bin/
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
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Fill buffer to fix urxvt window resize bug.
for i in {1...$LINES}; do echo; done; clear
