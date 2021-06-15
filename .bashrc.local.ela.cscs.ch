# ELA (Daint) specific settings:


alias sc='cd $SCRATCH'
alias pj='cd $PROJECT'

alias sq='squeue -u jcanton -o "%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E"'
function wsq {
    watch -n 1 "squeue -u jcanton -o '%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E'"
}

export PATH="/users/jcanton/.gem/ruby/2.5.0/bin:$PATH"

# COSMO
PATH="/oprusers/osm/bin:$PATH"
#module load ncview NCO CDO
#module load cudatoolkit/10.1.105_3.27-7.0.1.1_4.1__ga311ce7
#module load Boost/1.70.0-CrayGNU-19.10-python3

function conda_setup() {
    export PATH="/users/jcanton/miniconda3/bin:$PATH"
    export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
}
export PATH="/users/jcanton/miniconda3/bin:$PATH"
export PYTHONPATH="/users/jcanton/miniconda3/lib/python3.7/site-packages:$PYTHONPATH"
# alias nvim='conda_setup; nvim'
# alias ipython='conda_setup; ipython'
