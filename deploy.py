#!/usr/bin/env python
import os, shutil, socket, platform
#
#==============================================================================
# get hostname and homedir
#==============================================================================

hostname = socket.gethostname()
homedir  = os.path.expanduser('~')
cdir     = os.getcwd()
system   = platform.system()

#==============================================================================
# deploy configuration files to home folder
#==============================================================================
#
print('\n')
print('--- Deploying configuration files to home directory ---')
print('    hostname:       ' + hostname)
print('    system:         ' + system)
print('    home directory: ' + homedir)
print('\n')

#==============================================================================
# Function definition
#==============================================================================
#
def delete(dpath):
	if os.path.isdir(dpath):
		shutil.rmtree(dpath)
	else:
		os.remove(dpath)

def check_delete_link(fname, lfname=''):
	if (lfname == ''):
		lfname = fname
	fpath  = os.path.join(homedir, fname)
	lfpath = os.path.join(cdir,    lfname)
	if os.path.exists(fpath):
		if (not os.path.islink(fpath)):
			# old file
			usrIn = raw_input('\tFound '+fname+' delete? y/[n] ')
			if (usrIn == 'y'):
				print('    Removing old '+fname)
				delete(fpath)
				os.symlink(lfpath, fpath)
		else:
			# symlink
			if (not os.readlink(fpath) == lfpath):
				delete(fpath)
				os.symlink(lfpath, fpath)
	else:
		# did not exist
		os.symlink(lfpath, fpath)

#==============================================================================
# Deploy
#==============================================================================

#------------------------------------------------------------------------------
# deploy bashrc
#
check_delete_link('.bashrc')

check_delete_link('.bashrc.local', '.bashrc.local.'+hostname)

if (system == 'Darwin'):
	check_delete_link('.bash_profile', '.bash_profile.osx')

#------------------------------------------------------------------------------
# deploy git
#
check_delete_link('.gitconfig')
check_delete_link('.git-completion.bash')

#------------------------------------------------------------------------------
# deploy ipython config
#
check_delete_link('.ipython')

#------------------------------------------------------------------------------
# deploy matplotlib
#
if (system == 'Darwin'):
	check_delete_link('.matplotlib', 'matplotlib')
elif (system == 'Linux'):
	check_delete_link('.config/matplotlib', 'matplotlib')

#------------------------------------------------------------------------------
# deploy atom
#
if (system == 'Darwin'):
	check_delete_link('.atom', 'atom')

#------------------------------------------------------------------------------
# deploy redshift
#
if (system == 'Linux'):
	check_delete_link('.config/redshift.conf', 'redshift.conf.'+hostname)

#------------------------------------------------------------------------------
# deploy terminator
#
if (system == 'Linux'):
	check_delete_link('.config/terminator', 'terminator')

#------------------------------------------------------------------------------
# deploy vim
#
check_delete_link('.vim')
check_delete_link('.vimrc')
check_delete_link('.vimrc.local')

#------------------------------------------------------------------------------
# deploy xoural
#
if (system == 'Linux'):
	check_delete_link('.xournal')

#==============================================================================
#==============================================================================
print('\n')
print('------------------------- DONE ------------------------')
print('\n')
#==============================================================================
#==============================================================================
