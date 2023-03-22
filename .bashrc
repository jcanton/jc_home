# load /etc/bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

################################################
#                 My settings                  #
################################################

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# Set the title to user@host dir
PS1='[\u@\h \W]\$ '

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias tree='tree -ahC'
if `uname -a | grep -q -i Darwin`; then
    alias du='du -h -d 1'
else
    alias du='du -h --max-depth=1'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more aliases
#
alias gig='git log --graph --all --decorate --oneline'
alias gis='git status'
alias gic='git commit'
alias gia='git add'

alias vim='nvim'
alias vimdiff='nvim -d'

alias tm='tmux -u'
alias tml='tmux ls'
alias tmn='tmux -u new -s'
alias tma='tmux -u attach -t'

alias 2erebos='ssh -Y jcanton@erebos.mech.kth.se'
alias 2panda='ssh -Y jcanton@panda.ethz.ch'
alias 2falcon='ssh -Y jcanton@falcon.ethz.ch'
alias 2barry='ssh -Y jcanton@barry.ethz.ch'
alias 2euler='ssh -Y jcanton@129.132.93.102' #'ssh -Y jcanton@euler.ethz.ch'
alias 2ela='ssh -Y jcanton@ela.cscs.ch'
alias 2daint='ssh -Y jcanton@daint.cscs.ch'
alias 2fog='ssh -X -Y fog'
alias 2o3='ssh -X -Y o3'
alias 2argon='ssh -X -Y argon'
alias 2pi='ssh -Y pi@192.168.1.102'

# my compiled software
PATH="$HOME/.local/bin:$PATH"
INCLUDE="$HOME/.local/include:$INCLUDE"
LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"


#------------------------------------------------------------------------------
# git autocompletion
#
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

#------------------------------------------------------------------------------
# sshMount
#
if [ -f ~/jc_home/.bashrc.sshMount.sh ]; then
    . ~/jc_home/.bashrc.sshMount.sh
fi

#------------------------------------------------------------------------------
# machine specific configuration
#
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# needs to stay here as it's installed with conda
alias rg='rg --hidden --max-depth 0'
alias grep='rg' # use ripgrep
alias gr='rg' # use ripgrep

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
