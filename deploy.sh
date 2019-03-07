mkdir -p $HOME/.local/repo

TARGET=$HOME/.local

# vim
cd $TARGET/repo
git clone --depth 1 https://github.com/vim/vim.git || true
cd vim
git pull
cd src
./configure --prefix=$TARGET --with-features=huge
make -j$JOBS
make install
