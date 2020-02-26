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
            --enable-pythoninterp \
            --enable-cscope
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
