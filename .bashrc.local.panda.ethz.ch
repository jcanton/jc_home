# PANDA and FALCON specific settings:

module purge
module load gnu openmpi hdf5

alias visit="vglrun -c proxy /opt/visit/bin/visit"
alias paraview="vglrun -c proxy paraview"

PATH="/home/jcanton/codes/tmux/bin:$PATH"
