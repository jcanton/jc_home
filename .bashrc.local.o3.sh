# o3/argon/co2 specific settings:
#
export OMP_NUM_THREADS=12

export CC=$HOME/.local/bin/gcc
export CXX=$HOME/.local/bin/g++

export GT4PY_BUILD_CACHE_LIFETIME=PERSISTENT
export GT4PY_BUILD_CACHE_DIR=/exclaim/jcanton/icon4py_tmp

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



if [ -n "${VSCODE_INVOKING}" ]; then
    #echo "invoked by vscode"
    # set colors
    export CLICOLOR=1
    # Base16 Shell
    /bin/sh $HOME/jc_home/base16-shell/scripts/base16-solarized-light.sh
fi
