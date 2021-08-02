# ELA (Daint) specific settings:

alias sc='cd $SCRATCH'
alias pj='cd $PROJECT'

case $HOSTNAME in
    daint???)
        echo "We're on one of daint's login nodes"
        
        alias sq='squeue -u jcanton -o "%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E"'
        function wsq {
            watch -n 1 "squeue -u jcanton -o '%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E'"
        }
        # Ruby
        export PATH="/users/jcanton/.gem/ruby/2.5.0/bin:$PATH"
        # COSMO
        PATH="/oprusers/osm/bin:$PATH"
        #module load ncview NCO CDO
        # Python
        export PATH="/users/jcanton/miniconda3/bin:$PATH"
        export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
        export MPLCONFIGDIR="/scratch/snx3000/jcanton/.matplotlib"
        ;;
    ela?)
        echo "We're on ela"
        # Though ela does not have access to /project anymore...
        ;;
    nid*)
        echo "We're on one of daint's compute nodes"
        ;;
    *)
        echo "hostname not recognized in .bashrc.local"
        ;;
esac
