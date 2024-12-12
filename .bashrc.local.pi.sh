# pi specific settings:

export GT4PY_BUILD_CACHE_LIFETIME=PERSISTENT
export GT4PY_BUILD_CACHE_DIR=/home/jcanton/localRepos/related_icon4py/gt4py_cache

# set colors
export CLICOLOR=1

# Base16 Shell
BASE16_SHELL="$HOME/jc_home/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
# # automatically change colors based on time of day
# if command -v "sunshine" >/dev/null; then
#   # Replace "@45 15" with your location string, e.g. "#Barcelona"
#   if [[ "$(sunshine -s "@47 8")" = "day" ]]; then
#     base16_solarized-light
#   else
#     base16_solarized-dark
#   fi
# fi
base16_solarized-light

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
