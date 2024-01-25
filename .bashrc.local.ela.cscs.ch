# ELA (Daint) specific settings:

alias sc='cd $SCRATCH'
alias pr133='cd /project/pr133/jcanton'
alias g142='cd /store/g142/jcanton'
alias d121='cd /project/d121/jcanton'
alias st='cd /store/c2sm/pr04/jcanton'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#module load daint-gpu ncview NCO CDO
# COSMO
#PATH="/oprusers/osm/bin:$PATH"
#module load daint-gpu ncview NCO CDO

# PALM
export LD_LIBRARY_PATH="/store/g142/jcanton/repos/palm_build/rrtmg/lib:${LD_LIBRARY_PATH}"
export PATH="/store/g142/jcanton/repos/palm_build/bin:${PATH}"

# # MCH stuff
# # source /users/osm/.opr_setup_dir
# # export PATH=$OPR_SETUP_DIR/bin:$PATH
# # export MODULEPATH=$MODULEPATH\:$OPR_SETUP_DIR/modules/modulefiles
# ulimit -s unlimited # for not getting segmentation faults
# export OMP_STACKSIZE=500M
# export OMP_PLACES=sockets
# export OMP_PROC_BIND="spread,close,close"
# export PATH="/project/s83c/fieldextra/daint/bin:$PATH"
# export PATH="/project/s83c/fieldextra/daint/tools:$PATH"
# alias fieldextra='/project/s83c/fieldextra/daint/bin/fieldextra_gnu_opt_omp'
# alias grins='/project/s83c/fieldextra/daint/tools/grins'

loadSpack() {
    #module load cray-python
    source /project/g110/spack/user/daint/spack/share/spack/setup-env.sh
    export PATH="/project/g110/spack-install/daint/icontools/c2sm-master/gcc/mxikzrglofw6sz6ew25bowqwdenvmpzd/bin:$PATH"
}

loadMyPythonEnv() {
    # Ruby
    #export PATH="/users/jcanton/.gem/ruby/2.5.0/bin:$PATH"
    # Python
    export PATH="/users/jcanton/miniconda3/bin:$PATH"
    export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.11/site-packages:$PYTHONPATH"
    export MPLCONFIGDIR="/scratch/snx3000/jcanton/.matplotlib"
}


case $HOSTNAME in
    daint???)
        alias sq='squeue -u jcanton -o "%.8i %.8u %.7a %.9P %.30j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E"'
        alias sql='squeue -u jcanton -o "%.8i %.8u %.7a %.9P %.50j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E"'
        function wsq {
            watch -n 1 "squeue -u jcanton -o '%.8i %.8u %.7a %.9P %.30j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E'"
        }
        loadMyPythonEnv
        ;;
    nid*)
        # Python
        #loadMyPythonEnv
        #module load cray-python
        alias pyNode='source ~/.pythonComputeNode.env'
        ;;
    ela?)
        echo "We're on ela"
        # Though ela does not have access to /project anymore...
        ;;
    *)
        echo "hostname not recognized in .bashrc.local"
        ;;
esac
