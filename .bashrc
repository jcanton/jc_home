# load /etc/bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

################################################
#                 My settings                  #
################################################

#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US.UTF-8"

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

# my compiled software
PATH="$HOME/.local/bin:$PATH"
INCLUDE="$HOME/.local/include:$INCLUDE"
LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

#------------------------------------------------------------------------------
# conda and software installed through it
#
loadMiniconda() {
    if ! [[ ":$PATH:" == *"miniconda3"* ]]; then
        export NON_CONDA_PATH="$PATH"
        export NON_CONDA_PYTHONPATH=""
        #
        export PATH="$HOME/miniconda3/bin:$PATH"
        export PYTHONPATH="$HOME/miniconda3/lib/python3.11/site-packages:$PYTHONPATH"
        export PROJ_LIB="$HOME/miniconda3/share/proj"
        export MATPLOTLIBRC="$HOME/jc_home/matplotlib/matplotlibrc"
    fi
    alias tm='tmux -u'
    alias tml='tmux ls'
    alias tmn='tmux -u new -s'
    alias tma='tmux -u attach -t'
    if command -v rg &> /dev/null; then
        alias rgg='rg --max-depth 1'
        alias grep='rg'
        alias gr='rg'
    fi
    # if command -v zoxide &> /dev/null; then
    #     eval "$(zoxide init bash)"
    #     alias cd='z'
    #     alias cdi='zi'
    # fi
}
unloadMiniconda() {
    export PATH="$NON_CONDA_PATH"
    export PYTHONPATH="$NON_CONDA_PYTHONPATH"
    unalias tm tml tmn tma
    # unalias rgg grep gr
    # unalias cd cdi
}

loadMiniconda

#------------------------------------------------------------------------------
loadIcon4py() {
    #
    #deactivate
    unloadMiniconda
    #
    #
    if [[ $(hostname -s) = daint* ]]; then
        module load daint-mc
        module swap PrgEnv-cray PrgEnv-gnu
        module load Boost
    elif [[ $(hostname -s) = tsa* ]]; then
        module use /apps/common/UES/sandbox/kraushm/tsa-nvhpc/easybuild/modules/all
        module load gcc/8.3.0
        module use /project/g110/install/tsa/python-3.10/module/
        module load python/3.10.4
        module load git
        module load cmake
        source /project/g110/spack/user/tsa/spack/share/spack/setup-env.sh
        spack load openmpi@4.0.2 %gcc    # need mpi.h in order to build mpi4py
        spack load --first cmake@3.18.1
        spack load --first boost@1.77.0 # need boost in order to build serialbox
    elif [[ $(hostname -s) = balfrin* ]]; then
        module use /mch-environment/v5/modules
        module load netcdf-c/4.8.1-nvhpc
        module load hdf5/1.12.2-nvhpc
        module load python/3.10.8
    fi
    #
    if [[ $(hostname -s) = *13 ]] || [[ $(hostname -s) = pi ]] || [[ $(hostname -s) = daint* ]] || [[ $(hostname -s) = argon ]] || [[ $(hostname -s) = o3 ]] || [[ $(hostname -s) = co2 ]]; then
        # not on tsa because that loads it from spack...
        if ! [ -d "$HOME/.pyenv" ]; then
            # Install
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            cd ~/.pyenv && src/configure && make -C src
            export PYENV_ROOT="$HOME/.pyenv"
            command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
            eval "$(pyenv init -)"
            pyenv install 3.10.4
        fi
        #
        # Load
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        pyenv shell 3.10.4
    fi
    export ICON4PY="yes"
}
if [ -n "${VSCODE_ICON4PY}" ]; then
    alias code=`which code`
    alias rg="${HOME}/miniconda3/bin/rg"
    alias htop="${HOME}/miniconda3/bin/htop"
    alias fortls="${HOME}/miniconda3/bin/fortls"
    alias austin="${HOME}/miniconda3/bin/austin"
    alias austinp="${HOME}/miniconda3/bin/austinp"
    loadIcon4py
fi

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
