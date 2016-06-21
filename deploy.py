#!/usr/bin/env python
import shutils
#
#==============================================================================
# deploy configuration files to home folder
#==============================================================================
#
#------------------------------------------------------------------------------
# deploy bashrc
#
shutils.copy('.bashrc', '../')

#------------------------------------------------------------------------------
# deploy vim
shutils.copytree('vim/.vim',     '../')
shutils.copy('vim/.vimrc',       '../')
shutils.copy('vim/.vimrc.local', '../')
