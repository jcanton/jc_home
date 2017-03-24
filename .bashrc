#------------------------------------------------------------------------------
# machine specific configuration
#
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

#------------------------------------------------------------------------------
# git autocompletion
#
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
################################################
#                 My settings                  #
################################################

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
   # We have color support; assume it's compliant with Ecma-48
   # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
   # a case would tend to support setf rather than setaf.)
   color_prompt=yes
    else
   color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='[\u@\h \W]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='[\u@\h \W]\$ '
fi
unset color_prompt force_color_prompt

### # If this is an xterm set the title to user@host:dir
### case "$TERM" in
### xterm*|rxvt*)
###     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
###     ;;
### *)
###     ;;
### esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep  --color=auto'
    alias grepl='grep -n'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more aliases
#
alias matlabs='matlab -nodesktop -nosplash'
function svim() { gvim "$@" &> /dev/null ;}
alias du='du -h --max-depth=1'
alias gig='git log --graph --all --decorate --oneline'

alias 2abisko='ssh -Y jcanton@abisko.hpc2n.umu.se'
alias 2erebos='ssh -Y jcanton@erebos.mech.kth.se'
alias 2ferlin='ssh -X jcanton@ferlin.pdc.kth.se'
alias 2tegner='ssh -X jcanton@tegner.pdc.kth.se'
alias 2beskow='ssh -X jcanton@beskow.pdc.kth.se'
alias 2sisu='ssh -X pr1s0109@sisu.csc.fi'
alias 2triolith='ssh -X x_jacca@triolith.nsc.liu.se'
