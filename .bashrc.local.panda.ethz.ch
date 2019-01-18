# PANDA and FALCON specific settings:

module purge
module load gnu openmpi/3.1.3 fftw # hdf5 fftw

## # for CubismUP
## export FFTWDIR=/home/jcanton/codes/CubismUP_3D/dependencies/build/fftw-3.3.7/
## export HDF5_ROOT=/home/jcanton/codes/CubismUP_3D/dependencies/build/hdf5-1.10.1-parallel/
## export GSL_ROOT_DIR=/home/jcanton/codes/CubismUP_3D/dependencies/build/gsl-2.1/
## export PATH=/home/jcanton/codes/CubismUP_3D/dependencies/build/cmake-3.11.1/bin:$PATH

# for Simson
ulimit -s unlimited

alias visit="vglrun -c proxy /opt/visit/bin/visit"
alias paraview="vglrun -c proxy paraview"

PATH="/home/jcanton/codes/tmux/bin:$PATH"

## FUCKING FUCK FUCK
#export LANG="en_US.utf8"
#export LC_MEASUREMENT="en_US.utf8"
#export LC_NUMERIC="en_US.utf8"
#export LC_MONETARY="en_US.utf8"
#export LC_CTYPE="en_US.utf8"

# export PYTHONPATH="/home/jcanton/codes/spectralDNS/build/lib/python2.7/site-packages/"

export PATH="/home/jcanton/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export FLUIDSIM_PATH=/scratch/jcanton/fluidsim/Data
export FLUIDDYN_PATH_SCRATCH=/scratch/jcanton/fluidsim/scratch

# for smarties
export PATH=/opt/mpich/bin/:$PATH
export LD_LIBRARY_PATH=/opt/mpich/lib/:$LD_LIBRARY_PATH

# git
#export PATH="/home/jcanton/bin:$PATH"
