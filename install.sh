mkdir -p $HOME/.local/repo

TARGET=$HOME/.local

# BEFORE INSTALLING VIM with python support, install whatever python3 version with:
# env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1

# vim
cd $TARGET/repo
git clone --depth 1 https://github.com/vim/vim.git || true
cd vim
git pull
cd src
./configure --prefix=$TARGET \
            --with-features=huge \
            --enable-multibyte \
            --enable-cscope \
            --enable-pythoninterp \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir)
            #--with-python3-config-dir=$HOME/.pyenv/versions/3.7.1/lib
make -j$JOBS
make install

# git (on mac use `brew install git` and `git config --global credential.helper osxkeychain`)
cd $TARGET/repo
git clone --depth 1 https://github.com/git/git.git || true
cd git
git pull
make configure
./configure --prefix=$TARGET
make -j$JOBS
make install


# libevent (needed by tmux)
cd $TARGET/repo
git clone --depth 1 https://github.com/libevent/libevent.git || true
cd libevent
git pull
./autogen.sh
./configure --prefix=$TARGET
make -j$JOBS
make install


# tmux
cd $TARGET/repo
git clone --depth 1 https://github.com/tmux/tmux.git || true
cd tmux
git pull
./autogen.sh                 # the following is needed on computers without libevents
./configure --prefix=$TARGET #CFLAGS="-I$TARGET/include" LDFLAGS="-L$TARGET/lib"
make -j$JOBS
make install

# Nerd fonts
cd $TARGET/repo
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git
cd nerd-fonts
git pull
./install.sh IBMPlexMono # AND set 'BlexMono Nerd Font -> Medium - 13' as terminal font

# or download neovim.appcontainer
# # neovim
# cd $TARGET/repo
# git clone --depth 1 git@github.com:neovim/neovim
# cd neovim
# git pull
# make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$TARGET -j$JOBS
# make install

# # nodejs and npm manually compiling - fails - (https://gist.github.com/isaacs/579814) 
# cd $TARGET/repo
# mkdir node-latest-install
# cd node-latest-install
# curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
# ./configure --prefix=$TARGET
# make install # ok, fine, this step probably takes more than 30 seconds...
# curl https://www.npmjs.org/install.sh | sh
#
# # precompiled
# cd $TARGET/repo
# mkdir node-latest
# wget https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
# tar xvf node-v20.11.0-linux-x64.tar.xz -C node-latest --strip-components 1
# echo PATH="$HOME/.local/repo/node-latest/bin:$PATH" > ~/.bashrc.local
#
# try with nvm
cd $TARGET/repo
mkdir nvm
ln -s $TARGET/repo/nvm $HOME/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# then move the following lines from .bashrc to .bashrc.local
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# then install 16.20.2 (latest compatible on daint due to old glibc, see `ldd --version`)
nvm install 16.20.2
nvm alias default 16.20.2


# libffi on daint
cd $TARGET/repo
wget https://github.com/libffi/libffi/releases/download/v3.3/libffi-3.3.tar.gz
tar -xvf libffi-3.3.tar.gz
cd libffi-3.3
mkdir build; cd build
../configure --prefix=/users/jcanton/.local
make install
