export OMP_NUM_THREADS=8

export SCRATCH=/scratch/l_jcanton
alias sc="cd $SCRATCH"

export HTTP_PROXY=proxy.ethz.ch:3128
export HTTPS_PROXY=proxy.ethz.ch:3128
export FTP_PROXY=proxy.ethz.ch:3128
export NO_PROXY="localhost,127.0.0.1,::1"

# Base16 Shell
BASE16_SHELL="$HOME/jc_home/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
base16_solarized-light

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GT4PY_BUILD_CACHE_LIFETIME=PERSISTENT
export GT4PY_BUILD_CACHE_DIR=$SCRATCH
