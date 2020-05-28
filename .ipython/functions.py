def simTime(days, hours, wt=24, addT=None):
    #
    nseconds = wt*3600 / (days*24*3600 + hours*3600) * days*24*3600
    nhours   = int(nseconds / 3600)
    nminutes = int(nseconds / 60 - nhours*60)
    nseconds = int(nseconds - nhours*3600 - nminutes*60)
    #
    print('Useful time: {0:d}:{1:02d}:{2:02d}'.format(nhours, nminutes, nseconds))
    #
    if not(addT is None):
        # addT = 'hh:mm:ss'
        addTs = addT.split(':')
        addS = int(addTs[2])
        addM = int(addTs[1])
        addH = int(addTs[0])
        #
        totS =     (nseconds + addS) % 60
        pluM = int((nseconds + addS) / 60)
        totM =     (nminutes + addM + pluM) % 60
        pluH = int((nminutes + addM + pluM) / 60)
        totH = nhours + addH + pluH
        #
        print('Total time: {0:d}:{1:02d}:{2:02d}'.format(totH, totM, totS))
