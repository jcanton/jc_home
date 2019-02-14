# EULER specific settings:

#module purge

PATH="/cluster/home/jcanton/codes/bin:$PATH"
INCLUDE="/cluster/home/jcanton/codes/include:$INCLUDE"
LD_LIBRARY_PATH="/cluster/home/jcanton/codes/lib:$LD_LIBRARY_PATH"


### FUCKING FUCK FUCK
##export LANG="en_US.utf8"
##export LC_MEASUREMENT="en_US.utf8"
##export LC_NUMERIC="en_US.utf8"
##export LC_MONETARY="en_US.utf8"
##export LC_CTYPE="en_US.utf8"

# export PATH="/home/jcanton/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# for smarties
module purge
#module load new modules gcc/6.3.0 mvapich2/2.2 binutils/2.25 hwloc/1.11.0 openblas/0.2.13_seq
module load new gcc/6.3.0 open_mpi/2.1.1 hwloc/1.11.0 fftw_sp/3.3.4 openblas/0.2.13_seq python/3.6.1

# # git
# #export PATH="/home/jcanton/bin:$PATH"
