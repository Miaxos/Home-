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

# ====================================================

# Find large files and directories
alias fat='du -a | sort -n -r | head -n 20'

# Memory
alias meminfo='free -m -l -t'

# Get top process eating memory
alias psmem='ps aux | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'

# Get top process eating cpu
alias pscpu='ps aux | sort -nr -k 3'
alias pscpu10='ps aux | sort -nr -k 3 | head -10'


# iptables
alias ipt='iptables'
alias iptlist='iptables -L -n -v --line-numbers'
alias iptlistin='iptables -L INPUT -n -v --line-numbers'
alias iptlistout='iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='iptables -L FORWARD -n -v --line-numbers'
alias firewall='iptlist'
alias ban='iptables -I INPUT -j DROP -s'
alias unban='iptables -D INPUT -j DROP -s'
alias banin='iptables -I INPUT -j DROP -s'
alias unbanin='iptables -D INPUT -j DROP -s'
alias banout='iptables -I OUTPUT -j DROP -s'
alias unbanout='iptables -D OUTPUT -j DROP -s'
alias listbans='iptables -L -v -n | grep -e Chain -e DROP'

# IP addresses
alias localip="ipconfig getifaddr en5"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"


# ====================================================

# Google alias
alias g='googler -n 7 -c en -l en '

# ======================= Tunnelblick =================

alias tlc='tli connect $(tli list | fzf)'
alias tld='tli disconnect $(tli status | grep CONNECTED | cut -d" " -f 1 | fzf)'

# ======================= Nomad =======================

nomad-status() {
  local job

  job=$(nomad job status | tail +2 | fzf -1 -q "$1" | awk '{ print $1 }')

  [[ -n "$job" ]] && nomad job status "$job"
}

nomad-log() {
  local allocation job

  job=$(nomad job status | tail +2 | fzf -1 -q "$1" | awk '{ print $1 }')
  allocation=$(nomad job status "$job" | awk '/Allocations/,EOF' | tail +3 | fzf -1 -q "$1" | awk '{ print $1 }')

  [ -n "$allocation" ] && nomad alloc logs -tail -f -n 300 "$allocation"
}


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
alias mpv="mpv"
alias mpvs="mpv --video-sync=display-resample"

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
alias gaf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add '

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
alias tre="tmux source-file ~/.tmux.conf"
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
# alias ls="command ls ${colorflag}"
# ls long
# alias ll="ls -l ${colorflag}"
# all files, in long format
# alias l="ls -lF ${colorflag}"
# to show directory's tree
alias ltr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/ /'\'' -e '\''s/-/|/'\'''
# to show hidden files
# alias la="ls -laF ${colorflag}"
# to show only directoies
# alias lsd='ls -lF ${colorflag} | grep "^d"'

alias l="exa --long --header --git --all --git-ignore --sort name"
alias ls="exa"
alias ll="exa -l"
alias la="exa -laF"
alias lsd='exa -lF | grep "^d"'
alias cat='bat'


# Open a new finder windows at the location
alias f='open -a Finder ./'

# ======================= DEV =======================
# Remove old docker images
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'

#webserver
alias webserver="http-server . --ssl --color --cert='/Users/anthonygriffon/Downloads/crt.txt' --key='/Users/anthonygriffon/Downloads/key.txt' -p "

# Rg fuzzy find
alias rgf="rg --column --line-number --hidden --ignore-case --no-heading --color=always "
