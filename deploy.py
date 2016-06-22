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
#
#------------------------------------------------------------------------------
# deploy bashrc
#
shutil.copy('.bashrc', '../')

#------------------------------------------------------------------------------
# deploy vim
#
if os.path.exists('../.vim'):
	print('   WARNING: removing old .vim folder')
	shutil.rmtree('../.vim')

shutil.copytree('.vim',     '../.vim')
shutil.copy('.vimrc',       '../')
shutil.copy('.vimrc.local', '../')

#------------------------------------------------------------------------------
# deploy git
#
shutil.copy('.gitconfig', '../')

#------------------------------------------------------------------------------
# deploy xoural
#
if os.path.exists('../.xournal'):
	print('   WARNING: removing old .xournal folder')
	shutil.rmtree('../.xournal')

shutil.copytree('.xournal', '../.xournal')

#------------------------------------------------------------------------------
# deploy matplotlib
#
if os.path.exists('../.config/matplotlib'):
	print('   WARNING: removing old .config/matplotlib folder')
	shutil.rmtree('../.config/matplotlib')

shutil.copytree('.config/matplotlib', '../.config/matplotlib')
