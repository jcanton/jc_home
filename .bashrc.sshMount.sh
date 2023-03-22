sshmount() {

    diskName=$1
    diskDir=/Users/jcanton/sshfsVolumes/$diskName

    cd
    if [[ ! -e ${diskDir} ]]; then
        mkdir -p $diskDir
    else
        diskutil umount force $diskDir
    fi

    if [ "$diskName" == "ela" ]; then
        sshfs ela:/users/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "daint" ]; then
        sshfs daint:/users/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "daintScratch" ]; then
        sshfs daint:/scratch/snx3000/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "pr133" ]; then
        sshfs daint:/project/pr133/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "g142" ]; then
        sshfs daint:/store/g142/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "d121" ]; then
        sshfs daint:/project/d121/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "o3" ]; then
        sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa jcanton@fog2.ethz.ch:/net/argon/hymet_nobackup/jcanton  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "pi" ]; then
        sshfs pi:/home/pi  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "erebos" ]; then
        sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa jcanton@erebos.mech.kth.se:/scratch/jcanton ./$diskDir

    else
        echo "Unknown host name"

    fi

    cd $diskDir
}
