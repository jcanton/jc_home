# gitpod specific settings:

export GT4PY_BUILD_CACHE_LIFETIME=PERSISTENT
#export GT4PY_BUILD_CACHE_DIR=/home/jcanton/localRepos/related_icon4py/gt4py_cache

# set colors
export CLICOLOR=1

# Base16 Shell
BASE16_SHELL="$HOME/jc_home/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
base16_solarized-light

# some more aliases
#
alias gig='git log --graph --all --decorate --oneline'
alias gis='git status'
alias gic='git commit'
alias gia='git add'
