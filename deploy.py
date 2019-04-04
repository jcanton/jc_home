#!/usr/bin/env python
import os, shutil, socket, platform
from subprocess import call
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
	#  fname: file name that will be in the system (symlink)
	# lfname: name of the same file here in the repo
	if (lfname == ''):
		lfname = fname
	fpath  = os.path.join(homedir, fname)
	lfpath = os.path.join(cdir,    lfname)
	if os.path.exists(fpath):
		if (not os.path.islink(fpath)):
			# old file
			usrIn = input('\tFound '+fname+' delete? y/[n] ')
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
# Initialise git submodules
#==============================================================================
call("git submodule init",   shell=True)
call("git submodule update", shell=True)

#==============================================================================
# Deploy
#==============================================================================

#------------------------------------------------------------------------------
# deploy bashrc
#
check_delete_link('.bashrc')

if (hostname[0:8] == 'eu-login'): # we are on Euler.ethz.ch
    check_delete_link('.bashrc.local', '.bashrc.local.euler.ethz.ch')
elif (hostname[0:3] == 'ela'): # we are on ela
    check_delete_link('.bashrc.local', '.bashrc.local.ela.cscs.ch')
else:
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

##------------------------------------------------------------------------------
## deploy atom (NOT FOR NOW)
##
#if (system == 'Darwin'):
#	check_delete_link('.atom', 'atom')

##------------------------------------------------------------------------------
## deploy redshift (LET'S FORGET ABOUT THIS)
##
#if (system == 'Linux'):
#	check_delete_link('.config/redshift.conf', 'redshift.conf.'+hostname)

##------------------------------------------------------------------------------
## deploy terminator (LET'S FORGET ABOUT THIS)
##
#if (system == 'Linux'):
#	check_delete_link('.config/terminator', 'terminator')

#------------------------------------------------------------------------------
# deploy tmux
#
check_delete_link('.tmux',             'tmux-config/tmux')
check_delete_link('.tmux.conf',        'tmux-config/tmux/tmux.conf')
check_delete_link('.tmux.remote.conf', 'tmux-config/tmux/tmux.remote.conf')
os.chdir('tmux-config')
call('./install.sh', shell=True)
os.chdir('..')

#------------------------------------------------------------------------------
# deploy vim
#
check_delete_link('.vim')
check_delete_link('.vimrc')
if (system == 'Darwin'):
    check_delete_link('.vimrc.local', '.vimrc.local.osx')
else:
    check_delete_link('.vimrc.local')

#------------------------------------------------------------------------------
# deploy karabiner
#
if (system == 'Darwin'):
	check_delete_link('.config/karabiner', 'karabiner')

##------------------------------------------------------------------------------
## deploy xoural (LET'S FORGET ABOUT THIS)
##
#if (system == 'Linux'):
#	check_delete_link('.xournal')

#==============================================================================
#==============================================================================
print('\n')
print('------------------------- DONE ------------------------')
print('\n')
#==============================================================================
#==============================================================================
