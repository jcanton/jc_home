# load /etc/bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

################################################
#                 My settings                  #
################################################

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
    alias grep='grep  --color=auto'
    alias grepl='grep -n'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias gr="grep --exclude='tags'"
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
alias matlabs='matlab -nodesktop -nosplash'
function svim() { gvim "$@" &> /dev/null ;}
alias gig='git log --graph --all --decorate --oneline'
alias tm='tmux'
alias tml='tmux ls'
alias tmn='tmux new -s'
alias tma='tmux attach -t'

alias 2beskow='ssh -X jcanton@beskow.pdc.kth.se'
alias 2tegner='ssh -X jcanton@tegner.pdc.kth.se'
alias 2abisko='ssh -Y jcanton@abisko.hpc2n.umu.se'
alias 2kebnekaise='ssh -Y jcanton@kebnekaise.hpc2n.umu.se'
alias 2erebos='ssh -Y jcanton@erebos.mech.kth.se'
alias 2kratzer='ssh -Y jcanton@kratzer.mech.kth.se'
alias 2sisu='ssh -X pr1s0109@sisu.csc.fi'
alias 2triolith='ssh -X x_jacca@triolith.nsc.liu.se'
alias 2panda='ssh -Y jcanton@panda.ethz.ch'
alias 2falcon='ssh -Y jcanton@falcon.ethz.ch'
alias 2euler='ssh -Y jcanton@129.132.93.102' #'ssh -Y jcanton@euler.ethz.ch'

#------------------------------------------------------------------------------
# git autocompletion
#
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

#------------------------------------------------------------------------------
# machine specific configuration
#
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
