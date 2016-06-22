#!/usr/bin/env python
import os, shutil
#
#==============================================================================
# deploy configuration files to home folder
#==============================================================================
#
print('\n')
print('--- deploying configuration files to home directory ---')
print('\n')

#==============================================================================
# clear any previously existig folders
#==============================================================================
#
if os.path.exists('../.vim'):
	usrInVim = raw_input('   Found .vim folder. Delete? [y/n] ')
	if (usrInVim == 'y'):
		print('   Removing old .vim folder')
		shutil.rmtree('../.vim')

#------------------------------------------------------------------------------
# deploy bashrc
#
shutil.copy('.bashrc', '../')

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
# deploy vim
#
if (usrInVim == 'y'):
	shutil.copytree('.vim', '../.vim')

shutil.copy('.vimrc',       '../')
shutil.copy('.vimrc.local', '../')

#------------------------------------------------------------------------------
# deploy xoural
#
if not os.path.exists('../.xournal'):
	print('   CREATING .xournal folder')
	os.makedirs('../.xournal')

shutil.copy('.xournal/config', '../.xournal/')

#==============================================================================
#==============================================================================
print('\n')
print('------------------------- DONE ------------------------')
print('\n')
#==============================================================================
#==============================================================================
