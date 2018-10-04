# PANDA and FALCON specific settings:

module purge
module load gnu openmpi hdf5

ulimit -s unlimited # for Simson

alias visit="vglrun -c proxy /opt/visit/bin/visit"
alias paraview="vglrun -c proxy paraview"

PATH="/home/jcanton/codes/tmux/bin:$PATH"

# FUCKING FUCK FUCK
export LANG="en_US.utf8"
export LC_MEASUREMENT="en_US.utf8"
export LC_NUMERIC="en_US.utf8"
export LC_MONETARY="en_US.utf8"
export LC_CTYPE="en_US.utf8"
