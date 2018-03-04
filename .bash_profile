export EDITOR="/usr/bin/vim"

# Git config
# git config --global core.editor /usr/bin/vim
# git config --global user.name "Anthony GRIFFON"
# git config --global user.email "anthony.griffon@etu.univ-nantes.fr"

alias ltr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/ /'\'' -e '\''s/-/|/'\'''
alias lr='ls -tr'

alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


function archive() {
  7z a -t7z ${1}.7z -m0=lzma2 -mx=9 -aoa ${1}
}

### Alias

alias vim='nvim'
alias wget="wget -c"
# Alias folders
alias ll="ls -l"

# Alias git
alias gg="git pull"
alias gp="git push"
alias gc="git commit"

alias gaa="git add *"
alias ga="git add"
alias gl="git branch -a"
alias gk="git checkout"
alias gs="git status"
alias cloud='clouddrive'

function transfer() {
  if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
  tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1\n" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile;
}

## Get the process on a given port
function port() {
  lsof -i ":${1:-80}"
}

# Alias tmux
alias tl="tmux list-sessions"
alias ta="tmux attach -t "
alias tn="tmux new -s "
alias tr="tmux source-file ~/.tmux.conf"

# Enable aliases to be sudoâed
alias sudo='sudo '

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

#webserver
alias webserver="python2.7 -m SimpleHTTPServer"

# Quicker navigation
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# MPV
alias mpv="mpv --cache=80000"


export RDTOKEN="NULL"


function rdebrid() {

  LINK=$(curl -s -X POST -H "Authorization: Bearer $RDTOKEN" --data 'link='${1}\' "https://api.real-debrid.com/rest/1.0/unrestrict/link" | grep "download" | cut -d \" -f 4 | sed 's/\\//g')
  mpv "$LINK"
}
function rdl() {

  LINK=$(curl -s -X POST -H "Authorization: Bearer $RDTOKEN" --data 'link='${1} "https://api.real-debrid.com/rest/1.0/unrestrict/link" | grep "download" | cut -d \" -f 4 | sed 's/\\//g')
  wget "$LINK"
}

# export PATH="/Users/anthonygriffon/anaconda/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

### Prompt Colors
# Modified version of @gf3âs Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    BLACK=$(tput setaf 190)
    MAGENTA=$(tput setaf 9)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 190)
    PURPLE=$(tput setaf 141)
    WHITE=$(tput setaf 0)
  else
    BLACK=$(tput setaf 190)
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput dim)
  DIM=$(tput dim)
  RESET=$(tput sgr0)
else
  BLACK="\033[01;30m"
  MAGENTA="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  BOLD=""
  RESET="\033[m"
fi

export GREEN
export BLACK
export MAGENTA
export ORANGE
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
#symbol="â¡  "
symbol="🚀 "

#PS1="\[${BOLD}${MAGENTA}\]\u \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\]\$([[
#-n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
#PS1="\[${BOLD}${MAGENTA}\]\u \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\]\n$symbol"
#PS1='\u ($(f_batt)) in \W ($(parse_git_branch))$symbol '
PS1="\[${BOLD}${MAGENTA}\]\u \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\] (\$(parse_git_branch))\[$PURPLE\]\[$RESET\]\n$symbol"
#PS1='$(f_notifyme)'$PS1
export PS1=$PS1
export PS2="\[$ORANGE\]>\[$RESET\]"

#export PS1='${CYAN}\u${BLUE}@\h:\w\n${symbol}\[\033[00m\]'
#export PS1='$(f_notifyme)'$PS1

### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
#shopt -s extglob # enables extended globbing, usefull for ls !(*.*)
