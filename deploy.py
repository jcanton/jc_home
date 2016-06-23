#!/usr/bin/env python
import os, shutil, socket
#
#==============================================================================
# get hostname
#==============================================================================

hostname = socket.gethostname()

#==============================================================================
# deploy configuration files to home folder
#==============================================================================
#
print('\n')
print('--- Deploying configuration files to home directory ---')
print('    hostname: ' + hostname)
print('\n')

#==============================================================================
# clear any previously existig folders
#==============================================================================
#
if os.path.exists('../.vim'):
	usrInVim = raw_input('    Found .vim folder. Delete? y/[n] ')
	if (usrInVim == 'y'):
		print('    Removing old .vim folder')
		shutil.rmtree('../.vim')

#------------------------------------------------------------------------------
# deploy bashrc
#
shutil.copy('.bashrc', '../')

if (hostname == 'arch10'):
	shutil.copy('.bashrc.local.arch10',    '../.bashrc.local')
elif (hostname == 'erebos'):
	shutil.copy('.bashrc.local.erebos',    '../.bashrc.local')
elif (hostname == 'bernoulli'):
	shutil.copy('.bashrc.local.bernoulli', '../.bashrc.local')

#------------------------------------------------------------------------------
# deploy git
#
shutil.copy('.gitconfig', '../')

#------------------------------------------------------------------------------
# deploy matplotlib
#
if not os.path.exists('../.config/matplotlib'):
	print('   CREATING .config/matplotlib folder')
	os.makedirs('../.config/matplotlib')

shutil.copy('.config/matplotlib/matplotlibrc', '../.config/matplotlib/')

#------------------------------------------------------------------------------
# deploy redshift
#
shutil.copy('redshift.conf', '../.config/')

#------------------------------------------------------------------------------
# deploy vim
#
if (usrInVim == 'y'):
	shutil.copytree('.vim', '../.vim')

shutil.copy('.vimrc',       '../')

if (hostname == 'arch10'):
	shutil.copy('.vimrc.local.arch10',    '../.vimrc.local')
elif (hostname == 'erebos'):
	shutil.copy('.vimrc.local.erebos',    '../.vimrc.local')
elif (hostname == 'bernoulli'):
	shutil.copy('.vimrc.local.bernoulli', '../.vimrc.local')

#------------------------------------------------------------------------------
# deploy xoural
#
if not os.path.exists('../.xournal'):
	print('\n')
	print('    Creating .xournal folder')
	os.makedirs('../.xournal')

shutil.copy('.xournal/config', '../.xournal/')

#==============================================================================
#==============================================================================
print('\n')
print('------------------------- DONE ------------------------')
print('\n')
#==============================================================================
#==============================================================================
