#!/usr/bin/env python
import os, shutil
#
#==============================================================================
# deploy configuration files to home folder
#==============================================================================
#
#------------------------------------------------------------------------------
# deploy bashrc
#
shutil.copy('.bashrc', '../')

#------------------------------------------------------------------------------
# deploy vim
#
if os.path.exists('../.vim'):
	print('removing old .vim folder')
	shutil.rmtree('../.vim')

shutil.copytree('vim/.vim',     '../.vim')
shutil.copy('vim/.vimrc',       '../')
shutil.copy('vim/.vimrc.local', '../')
