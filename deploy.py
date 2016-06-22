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

shutil.copytree('vim/.vim',     '../.vim')
shutil.copy('vim/.vimrc',       '../')
shutil.copy('vim/.vimrc.local', '../')
