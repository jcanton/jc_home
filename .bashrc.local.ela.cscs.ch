# ELA (Daint) specific settings:

alias sc='cd $SCRATCH'
alias pj='cd /project/pr133/jcanton'
alias pe='cd /store/g142/jcanton'
alias st='cd /store/c2sm/pr04/jcanton/data_lmp'

#module load daint-gpu ncview NCO CDO

# MCH stuff
# source /users/osm/.opr_setup_dir
# export PATH=$OPR_SETUP_DIR/bin:$PATH
# export MODULEPATH=$MODULEPATH\:$OPR_SETUP_DIR/modules/modulefiles
ulimit -s unlimited # for not getting segmentation faults
export OMP_STACKSIZE=500M
export OMP_PLACES=sockets
export OMP_PROC_BIND="spread,close,close"
export PATH="/project/s83c/fieldextra/daint/bin:$PATH"
export PATH="/project/s83c/fieldextra/daint/tools:$PATH"
alias fieldextra='/project/s83c/fieldextra/daint/bin/fieldextra_gnu_opt_omp'
alias grins='/project/s83c/fieldextra/daint/tools/grins'

loadSpack() {
    #module load cray-python
    source /project/g110/spack/user/daint/spack/share/spack/setup-env.sh
    export PATH="/project/g110/spack-install/daint/icontools/c2sm-master/gcc/mxikzrglofw6sz6ew25bowqwdenvmpzd/bin:$PATH"
}

loadMyPythonEnv() {
    # Ruby
    export PATH="/users/jcanton/.gem/ruby/2.5.0/bin:$PATH"
    # COSMO
    #PATH="/oprusers/osm/bin:$PATH"
    #module load daint-gpu ncview NCO CDO
    # Python
    #module purge
    export PATH="/users/jcanton/miniconda3/bin:$PATH"
    #export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
    export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages"
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
        loadMyPythonEnv
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
