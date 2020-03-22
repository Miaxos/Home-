#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Functions
# @author: Anthony Griffon
# @desc: Functions for bashrc.

# =========================== EXTRACT ========================
#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
function extract () {
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

# =========================== ARCHIVE ========================
#   archive:  Archive a file or folder
#   ---------------------------------------------------------
function archive() {
  7z a -t7z ${1}.7z -m0=lzma2 -mx=9 -aoa ${1}
}

# =========================== PORT ========================
#   port: Get process runinng on the port
#   ---------------------------------------------------------
function port() {
  lsof -i ":${1:-80}"
}

# =========================== TRANSFER ========================
#   transfer:  Host a file to transfer.sh
#   ---------------------------------------------------------
function transfer() {
  if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
  tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1\n" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile;
}

# =========================== REAL-DEBRID ========================
#   rdebrid:  mpv over the network of a brided host.
# ================================================================
function rdebrid() {
  LINK=$(curl -s -X POST -H "Authorization: Bearer $RDTOKEN" --data 'link='${1}\' "https://api.real-debrid.com/rest/1.0/unrestrict/link" | grep "download" | cut -d \" -f 4 | sed 's/\\//g')
  mpv "$LINK"
}

# =========================== REAL-DEBRID ========================
#   rdl:  wget over the network of a brided host.
# ================================================================
function rdl() {

  LINK=$(curl -s -X POST -H "Authorization: Bearer $RDTOKEN" --data 'link='${1} "https://api.real-debrid.com/rest/1.0/unrestrict/link" | grep "download" | cut -d \" -f 4 | sed 's/\\//g')
  wget "$LINK"
}

# =========================== TEA ========================
#   tea:  Notify for tea when it's ready to drink.
#
# ================================================================
#

function tea() {
  local STEEP_TIME=${STEEP_TIME:=180}

  echo "🍵 Thé en préparation..."
  [[ "$STEEP_TIME" != [0-9]* ]] && exit 1
  sleep "$STEEP_TIME"

  terminal-notifier -title '🍵 Un petit thé ?' -message "C'est prêt !!" -appIcon 'https://www.emojibase.com/resources/img/emojis/apple/x2615.png.pagespeed.ic.fUhSj-YPGK.png'
}

# =========================== utility functions ========================
# Functions that'll be used by other bashrc files. Do not use this
# inside a prompt without knowing what you are doing.
# ======================================================================

# f_batt: Get battery %
function f_batt {
  pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
}

# Git branch details
# function parse_git_dirty() {
#   [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
# }
# function parse_git_branch() {
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
# }

function parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Send OSX notification after long process exit
function f_notifyme {
  case "$OSTYPE" in
    darwin*)
      LAST_EXIT_CODE=$?
      CMD=$(history 1 | sed 's/^ *[^ ]* *//')
      reattach-to-user-namespace ~/.notifier "$CMD" "$LAST_EXIT_CODE" &
      ;;
    *);;
  esac
}

# Get something but don't remeber what
# TO DO INVESTIGATE
function dm-env() {
  eval "$(docker-machine env dev)"
}
