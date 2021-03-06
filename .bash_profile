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

export PATH="$HOME/.cargo/bin:$PATH"

# source /Users/anthonygriffon/Library/Preferences/org.dystroy.broot/launcher/bash/br

eval "$(starship init bash)"
