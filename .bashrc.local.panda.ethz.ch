# PANDA and FALCON specific settings:

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

module purge
module load gnu openmpi hdf5

PATH="/opt/visit/bin:$PATH"
