# jc home

\*NIX configuration files

on osX:
`brew install neovim`
`pip install neovim`

Tell npm where to store globally installed packages
`TARGET=${HOME}/.local`
`npm config set prefix "${TARGET}"`

The following is for CoC to work in neovim
`brew install ripgrep`
`brew install node`
`npm install -g yarn`

Install language servers
`brew install ccls --HEAD`
`brew install clang-format`

`npm i -g bash-language-server` # i := install, -g := --global

`pip install fortran-language-server`

run :checkhealth in neovim

## Setup conda

Copy the following in the ~/.condarc file:

```[bash]
channel_priority: strict
channels:
  - conda-forge
  - defaults
```

install miniconda3, then

```[bash]
conda update conda
conda install conda-forge::conda-libmamba-solver
conda config --set solver libmamba
conda install -c conda-forge ipython numpy matplotlib xarray uxarray scipy pynvim xesmf rasterio pyngl psy-view psyplot proj pandas netcdf4 htop hdf4 hdf5 h5py geos geotiff gdal fortran-language-server esmf cdo cartopy requests folium tmux htop pylint ripgrep mscorefonts f90nml zoxide fzf austin plotly vtk
```
