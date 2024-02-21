# o3 setup

# export OMP_NUM_THREADS=1
# module load gcc gfortran cdo netcdf openmpi

export PATH="/home/jcanton/.gem/ruby/2.5.0/bin:$PATH"

export PROJ_LIB="/home/jcanton/miniconda3/share/proj"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

loadMyPythonEnv() {
    if ! [[ ":$PATH:" == *"miniconda3"* ]]; then
        export NON_CONDA_PATH="$PATH"
        export NON_CONDA_PYTHONPATH=""
        #
        export PATH="$HOME/miniconda3/bin:$PATH"
        export PYTHONPATH="$HOME/miniconda3/lib/python3.11/site-packages:$PYTHONPATH"
    fi
}
unloadMyPythonEnv() {
    export PATH="$NON_CONDA_PATH"
    export PYTHONPATH="$NON_CONDA_PYTHONPATH"
    unalias cd
    unalias cdi
}
loadIcon4py() {
    #
    unloadMyPythonEnv
    #
    #module load daint-mc
    #module swap PrgEnv-cray PrgEnv-gnu
    #module load Boost
    #### export BOOST_ROOT="$HOME/.local/repo/boost_1_82_0"
    #### export CMAKE_PREFIX_PATH="$BOOST_ROOT:$CMAKE_PREFIX_PATH"
    #### export CPATH="$BOOST_ROOT:$CPATH"
    #
    # Install
    ##git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    ##cd ~/.pyenv && src/configure && make -C src
    ##export PYENV_ROOT="$HOME/.pyenv"
    ##command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    ##eval "$(pyenv init -)"
    ##pyenv install 3.10.4
    #
    # Load
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    pyenv shell 3.10.4
}
loadMyPythonEnv
