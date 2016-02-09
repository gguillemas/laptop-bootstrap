# If interactive shell.
[[ $- != *i* ]] && return

# Prompt
exitlight() {
	if [[ $? == 0 ]]; then
		echo -e "\e[32m•\e[0m"
	else
		echo -e "\e[31m•\e[0m"
	fi
}
export PS1='[$(exitlight)] \e[33m\t\e[0m \u@\h : \e[90m\w\e[0m \n\$ '

# Definitions.
export EDITOR=$(which vim)
export PATH=$PATH:/sbin/:/usr/sbin/:~/scripts/:~/software/
export GOPATH=~/sources/go
export TERM='xterm-256color'

# Aliases.
alias ls='ls --color=auto'
alias ll='ls -alhrtF'
alias l='ll'
alias bang='disown & exit'
alias newest='ls -rt | tail -1'
alias jar='_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING; java -jar'

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
