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
        sshfs daint:/store/g142/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "d121" ]; then
        sshfs daint:/project/d121/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "tsa" ]; then
        sshfs tsa:/scratch/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "balfrin" ]; then
        sshfs balfrin:/scratch/mch/jcanton/  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "co2" ]; then
        sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa jcanton@fog2.ethz.ch:/net/co2/exclaim/jcanton  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "pi" ]; then
        sshfs pi:/home/pi  $diskDir  -o auto_cache,reconnect,defer_permissions,noappledouble

    elif [ "$diskName" == "ciccia" ]; then
        sshfs ciccia:/var/services/homes/jacopo $diskDir -o auto_cache,reconnect,defer_permissions,noappledouble

    else
        echo "Unknown host name"

    fi

    cd $diskDir
}
