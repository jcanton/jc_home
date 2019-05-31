# PANDA and FALCON specific settings:

#module purge
#module load gnu mpich #openmpi/3.1.3 fftw # hdf5 fftw

## # for CubismUP
## export FFTWDIR=/home/jcanton/codes/CubismUP_3D/dependencies/build/fftw-3.3.7/
## export HDF5_ROOT=/home/jcanton/codes/CubismUP_3D/dependencies/build/hdf5-1.10.1-parallel/
## export GSL_ROOT_DIR=/home/jcanton/codes/CubismUP_3D/dependencies/build/gsl-2.1/
## export PATH=/home/jcanton/codes/CubismUP_3D/dependencies/build/cmake-3.11.1/bin:$PATH

# for Simson
#ulimit -s unlimited

alias visit="vglrun -c proxy /opt/visit/bin/visit"
alias paraview="vglrun -c proxy paraview"

# initialize pyenv
export PATH="/home/jcanton/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
#alias pip="python -m pip"

#export FLUIDSIM_PATH=/scratch/jcanton/fluidsim/Data
#export FLUIDDYN_PATH_SCRATCH=/scratch/jcanton/fluidsim/scratch
#
## for smarties
#export PATH=/opt/mpich/bin/:$PATH
#export LD_LIBRARY_PATH=/opt/mpich/lib/:$LD_LIBRARY_PATH
