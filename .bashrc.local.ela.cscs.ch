# ELA (Daint) specific settings:


alias sc='cd $SCRATCH'
alias pj='cd $PROJECT'

alias sq='squeue -u jcanton -o "%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E"'
function wsq {
    watch -n 1 "squeue -u jcanton -o '%.8i %.8u %.7a %.9P %.12j %.8T %.13S %.10M %.10L %.6D %.5C %.11r %E'"
}

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


# COSMO with Spack
# source /project/g110/spack/user/daint/spack/share/spack/setup-env.sh
# e.g.:
# spack: cosmo@master%gcc@8.3.0~claw cosmo_target=gpu
#   +cppdycore~debug~eccodes+parallel~pollen~production real_type=double
#   ~serialize slave=tsa ~verbose
#
# first check if available
# > spack list cosmo
#
# then check configurations and variants:
# > spack info cosmo
#
# check the specifications and what exactly is going to be installed
# > spack speck <package>@<version>blablabla
#
# Then install (you can use --keep-stage to keep the source and build files)
# > spack install <package>@<version> blablabla
# will install in /scratch/$USER/spack-install/<machine>
# module files are placed in /scratch/$USER/modules/
#
# Find your installed packages and the details
# > spack find -lpv <package>
#
# Compile your own local source
# > cd source
# > spack dev-build <specifications> -until=build (if you want to skip the installation)
# or, to build local dycore + cosmo
# > spack devbuildcosmo cosmo@dev-build%<compiler> +<variants> -c for a clean build
# e.g.
# > spack devbuildcosmo cosmo@dev-build%pgi real_type=double cosmo_target=gpu +cppdycore +claw
# > spack devbuildcosmo cosmo@dev-build%gcc real_type=double cosmo_target=cpu ~cppdycore
