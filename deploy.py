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
usrInVim = 'n'
if os.path.exists('../.vim'):
	usrInVim = raw_input('    Found .vim folder. Delete? y/[n] ')
	if (usrInVim == 'y'):
		print('    Removing old .vim folder')
		shutil.rmtree('../.vim')
else:
	usrInVim = 'y'

#------------------------------------------------------------------------------
# deploy bashrc
#
shutil.copy('.bashrc', '../')

if (hostname == 'arch10'):
	shutil.copy('.bashrc.local.arch10',    '../.bashrc.local')
elif (hostname == 'arch14'):
	shutil.copy('.bashrc.local.arch14',    '../.bashrc.local')
elif (hostname == 'erebos'):
	shutil.copy('.bashrc.local.erebos',    '../.bashrc.local')
elif (hostname == 'triolith1'):
	shutil.copy('.bashrc.local.arch14',    '../.bashrc.local')
elif (hostname == 'bernoulli'):
	shutil.copy('.bashrc.local.bernoulli', '../.bashrc.local')
elif (hostname == 'mac13'):
	shutil.copy('.bashrc.local.mac13', '../.bashrc.local')
	shutil.copy('.bash_profile.mac13', '../.bash_profile')
elif (hostname == 'work13' ):
	shutil.copy('.bashrc.local.work13', '../.bashrc.local')
	shutil.copy('.bash_profile.mac13',  '../.bash_profile')

#------------------------------------------------------------------------------
# deploy git
#
shutil.copy('.gitconfig', '../')

#------------------------------------------------------------------------------
# deploy ipython config
#
if not os.path.exists('../.ipython/profile_default'):
	print('   CREATING .ipython/profile_default folder')
	os.makedirs('../.ipython/profile_default')

shutil.copy('.ipython/profile_default/ipython_config.py', '../.ipython/profile_default/')

#------------------------------------------------------------------------------
# deploy matplotlib
#
if (hostname == 'mac13' or hostname == 'work13' ):
	if not os.path.exists('../.matplotlib'):
		print('   CREATING .matplotlib folder')
		os.makedirs('../.matplotlib')
	shutil.copy('.config/matplotlib/matplotlibrc', '../.matplotlib/')
else:
	if not os.path.exists('../.config/matplotlib'):
		print('   CREATING .config/matplotlib folder')
		os.makedirs('../.config/matplotlib')
	shutil.copy('.config/matplotlib/matplotlibrc', '../.config/matplotlib/')

#------------------------------------------------------------------------------
# deploy redshift
#
if (hostname != 'mac13' and hostname != 'work13'):
	if (hostname == 'arch10'):
		shutil.copy('.config/redshift.conf.arch10', '../.config/redshift.conf')
	else:
		shutil.copy('.config/redshift.conf.erebos', '../.config/redshift.conf')

#------------------------------------------------------------------------------
# deploy terminator
#
if (hostname != 'mac13' and hostname != 'work13'):
	if not os.path.exists('../.config/terminator'):
		print('   CREATING .config/terminator folder')
		os.makedirs('../.config/terminator')
	#
	if (hostname == 'arch10'):
		shutil.copy('.config/terminator/config.arch10',    '../.config/terminator/config')
	elif (hostname == 'arch14'):
		shutil.copy('.config/terminator/config.arch14',    '../.config/terminator/config')
	elif (hostname == 'erebos'):
		shutil.copy('.config/terminator/config.erebos',    '../.config/terminator/config')
	elif (hostname == 'bernoulli'):
		shutil.copy('.config/terminator/config.bernoulli', '../.config/terminator/config')

#------------------------------------------------------------------------------
# deploy vim
#
if (usrInVim == 'y'):
	shutil.copytree('.vim', '../.vim')

shutil.copy('.vimrc',       '../')

if (hostname == 'arch10'):
	shutil.copy('.vimrc.local.arch10',    '../.vimrc.local')
elif (hostname == 'arch14'):
	shutil.copy('.vimrc.local.arch14',    '../.vimrc.local')
elif (hostname == 'erebos'):
	shutil.copy('.vimrc.local.erebos',    '../.vimrc.local')
elif (hostname == 'bernoulli'):
	shutil.copy('.vimrc.local.bernoulli', '../.vimrc.local')
elif (hostname == 'triolith1'):
	shutil.copy('.vimrc.local.erebos',    '../.vimrc.local')
elif (hostname == 'mac13' or hostname == 'work13'):
	shutil.copy('.vimrc.local.mac13', '../.vimrc.local')
	shutil.copy('mvim', '../.vim/')

#------------------------------------------------------------------------------
# deploy xoural
#
if (hostname != 'mac13' and hostname != 'work13'):
	if not os.path.exists('../.xournal'):
		os.makedirs('../.xournal')
	
	shutil.copy('.xournal/config', '../.xournal/')

#==============================================================================
#==============================================================================
print('\n')
print('------------------------- DONE ------------------------')
print('\n')
#==============================================================================
#==============================================================================
