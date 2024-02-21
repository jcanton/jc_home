# MAC13 specific settings:

export BASH_SILENCE_DEPRECATION_WARNING=1

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jcanton/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    #eval "$__conda_setup"
    export PATH="/Users/jcanton/miniconda3/bin:$PATH"
else
    if [ -f "/Users/jcanton/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jcanton/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jcanton/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/Applications/VisIt.app/Contents/MacOS:$PATH"
export PATH="/Applications/VisIt.app/Contents/Resources/bin:$PATH"

# Ski# Skim
alias skim="/Applications/Skim.app/Contents/MacOS/Skim"

# homebrew "new" location
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
