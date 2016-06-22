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
	print('   WARNING: removing old .vim folder')
	shutil.rmtree('../.vim')

if os.path.exists('../.xournal'):
	print('   WARNING: removing old .xournal folder')
	shutil.rmtree('../.xournal')

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
shutil.copytree('.vim',     '../.vim')
shutil.copy('.vimrc',       '../')
shutil.copy('.vimrc.local', '../')

#------------------------------------------------------------------------------
# deploy xoural
#
shutil.copytree('.xournal', '../.xournal')

#==============================================================================
#==============================================================================
print('\n')
print('---                       DONE                      ---')
print('\n')
#==============================================================================
#==============================================================================
