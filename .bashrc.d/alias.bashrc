#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Alias part
# @author: Anthony Griffon
# @desc: Alias for bashrc.

# Enable aliases to be sudoed
alias sudo='sudo '
# Speedtest
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
# Meteo
alias meteo="curl wttr.in/Nantes"

# Random passwd
alias rdmpwd="openssl rand -base64 32 | pbcopy"

# ======================= Music =======================

# To download youtube audio
alias ydl="youtube-dl -x --audio-format=mp3 --add-metadata "
# To add audio to mdp library with metadata
alias bi="beet import "
# To listen to nrj12
alias nrj12="mpv http://cdn.nrjaudio.fm/audio1/fr/30001/mp3_128.mp3?origine=fluxradios"

# ======================= Applications =======================
#
# to use neovim
alias vim='nvim'
# to continue download
alias wget="wget -c"
# to launch VLC
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
# to cache data with mpv
alias mpv="mpv --cache=80000"

# ======================= Git =======================

## Alias git
alias gg="git pull"
alias gp="git push"
alias gc="git commit"

# With fuzzy search
alias gkba='git checkout -b $(git branch -a | fzf)'
alias gba='git checkout $(git branch | fzf)'
alias gbm='git checkout $(git branch --merged | fzf)'
alias gb='git checkout $(git branch --no-merged | fzf)'
alias gaf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add -p'

alias gaa="git add *"
alias ga="git add"
alias gk="git checkout"
alias gs="git status"

alias gam="git commit --amend"
alias gwip="git add *; git commit -m \"wip\";"

# Rebase
alias grc="git rebase --continue"

# Git stand-up
alias gsu="git-standup"

alias gl="git ls"

## Alias random mdp
alias rpwd="openssl rand -base64 32"

# ======================= Tmux =======================

# list sessions
alias tl="tmux list-sessions"
# attach session
alias ta="tmux attach -t "
# create session
alias tn="tmux new -s "
# reload config
alias tr="tmux source-file ~/.tmux.conf"
# kill session
alias tk="tmux kill-session -t "

# ======================= Navigation =======================

## Quicker navigation
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## Alias folders
colorflag="-G"
# ls with color
alias ls="command ls ${colorflag}"
# ls long
alias ll="ls -l ${colorflag}"
# all files, in long format
alias l="ls -lF ${colorflag}"
# to show directory's tree
alias ltr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/ /'\'' -e '\''s/-/|/'\'''
# to show hidden files
alias la="ls -laF ${colorflag}"
# to show only directoies
alias lsd='ls -lF ${colorflag} | grep "^d"'


# Open a new finder windows at the location
alias f='open -a Finder ./'

# ======================= DEV =======================
# Remove old docker images
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'

#webserver
alias webserver="http-server . --ssl --color --cert='/Users/anthonygriffon/.certs/crt.txt' --key='/Users/anthonygriffon/.certs/key.txt' -p "

# Rg fuzzy find
alias rgf="rg --column --line-number --hidden --ignore-case --no-heading --color=always "

