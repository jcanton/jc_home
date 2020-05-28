# ELA (Daint) specific settings:

module load daint-gpu

# PATH="/cluster/home/jcanton/codes/bin:$PATH"
# INCLUDE="/cluster/home/jcanton/codes/include:$INCLUDE"
# LD_LIBRARY_PATH="/cluster/home/jcanton/codes/lib:$LD_LIBRARY_PATH"
#
#
# # for smarties
# module purge
# #module load new modules gcc/6.3.0 mvapich2/2.2 binutils/2.25 hwloc/1.11.0 openblas/0.2.13_seq
# #module load new gcc/6.3.0 open_mpi/2.1.1 hwloc/1.11.0 fftw_sp/3.3.4 openblas/0.2.13_seq #python/3.6.1
#
# # **2
# #module load new gcc/6.3.0 hwloc/1.11.0 mvapich2/2.2
# #export HDF5_MPI="ON"
# #export HDF5_ROOT="/cluster/home/jcanton/codes/dependencies/build/hdf5-1.10.1-parallel/"
# #export HDF5_DIR="$HDF5_ROOT"
# #export FFTWDIR="/cluster/home/jcanton/codes/dependencies/build/fftw-3.3.7/"
# #export FFTW_DIR=$FFTWDIR
#
# # **3
# module load new gcc/4.8.2 hwloc/1.11.0 mvapich2/2.1 fftw/3.3.3 openblas/0.2.13_seq
# export HDF5_MPI="ON"
# export HDF5_ROOT="/cluster/home/jcanton/codes/dependencies/build/hdf5-1.10.1-parallel/"
# export HDF5_DIR="$HDF5_ROOT"
# export FFTWDIR=$FFTW3_ROOT_DIR
# export FFTW_DIR=$FFTW3_ROOT_DIR

# daint modules for Cubism-UP3D
#module unload PrgEnv-cray
#module load PrgEnv-gnu cray-hdf5-parallel cray-fftw daint-gpu cudatoolkit/9.2.148_3.19-6.0.7.1_2.1__g3d9acc8 GSL/2.5-CrayGNU-18.08 CMake/3.12.0
#export FFTW_ROOT=$FFTW_DIR/../
alias mlgnu='module load daint-gpu; module swap PrgEnv-cray PrgEnv-gnu; \
module load cray-python/3.6.1.1 cray-hdf5-parallel cray-fftw cray-petsc/3.8.4.0 \
cudatoolkit/9.2.148_3.19-6.0.7.1_2.1__g3d9acc8 CrayGNU/.18.08 GSL/2.5-CrayGNU-18.08'

alias mlpy='module load daint-gpu h5py' # also switches to GNU and loads: cray-python/3.6.5.1 PyExtensions/3.6.5.1-CrayGNU-18.08


# cubismUP_3D
# module swap PrgEnv-cray PrgEnv-gnu
# module load daint-gpu cray-python/3.6.1.1 cray-hdf5-parallel cray-fftw cray-petsc/3.8.4.0 cudatoolkit/9.2.148_3.19-6.0.7.1_2.1__g3d9acc8 CrayGNU/.18.08 GSL/2.5-CrayGNU-18.08 CMake/3.12.0

# module load daint-gpu
# module swap PrgEnv-cray PrgEnv-intel

#export PATH="/users/jcanton/codes/nek5000_master/bin:$PATH"
#export PATH="/users/jcanton/codes/nek5000_svn_1093/bin:$PATH"

# # pyenv
# export PATH="/users/jcanton/.pyenv/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# python
module load cray-python/3.6.5.7
module load PyExtensions/3.6.5.7-CrayGNU-19.10

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/users/jcanton/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     #eval "$__conda_setup"
#     export PATH="/users/jcanton/miniconda3/bin:$PATH"
#     export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
# else
#     if [ -f "/users/jcanton/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/users/jcanton/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/users/jcanton/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
function conda_setup() {
    export PATH="/users/jcanton/miniconda3/bin:$PATH"
    export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
}
# alias nvim='conda_setup; nvim'
# alias ipython='conda_setup; ipython'

# COSMO
PATH="/oprusers/osm/bin:$PATH"
module load ncview NCO
#module load cudatoolkit/10.1.105_3.27-7.0.1.1_4.1__ga311ce7
#module load Boost/1.70.0-CrayGNU-19.10-python3
