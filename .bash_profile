#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Bash profile
# @author: Anthony Griffon
# @desc: Do what the fuck you want with this.
# https://medium.com/@waxzce/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(/opt/homebrew/bin/brew shellenv)"

# Important to be able to write 'é' or others frenchies' things inside kitty
export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

# We load each .bashrc files inside our prompt
for file in ~/.bashrc.d/*.bashrc;
do
 source "$file"
done

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
# fi

# fzf completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Bash completion with git

# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# If we want to launch a tmux windows each time we launch terminal ?
# if [ "$TMUX" = "" ]; then exec tmux; fi


# source /Users/anthonygriffon/Library/Preferences/org.dystroy.broot/launcher/bash/br

eval "$(starship init bash)"
. "$HOME/.cargo/env"
source "/Users/wizard/.rover/env"

# Created by `pipx` on 2022-02-09 16:34:02
export PATH="$PATH:/Users/wizard/.local/bin"
. "/Users/wizard/.wasmedge/env"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

export SWARMD_INSTALL="/Users/wizard/.swarmd"
export PATH="$SWARMD_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wizard/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wizard/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/wizard/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wizard/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export WASMER_DIR="/Users/wizard/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

