#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Theme
# @author: Anthony Griffon
# @desc: Theme for bashrc.

### Prompt Colors
# Modified version of @gf3's Sexy Bash Prompt
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

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="λ "

# Only show the current directory's name in the tab
#
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# PS1
# OLD PS1="\[${BOLD}${MAGENTA}\]\u ${PURPLE}(\$(f_batt)) \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\] (\$(parse_git_branch))\[$PURPLE\]\[$RESET\]\n\[$GREEN\]$symbol\[$RESET\]"
# PS1="\[${BOLD}${MAGENTA}\]\u ${PURPLE}(\$(f_batt)) \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\] (\$(parse_git_branch))\[$PURPLE\]\[$RESET\]\n\[$GREEN\]$symbol\[$RESET\]"
PS1="\[${BOLD}${MAGENTA}\]meow ${PURPLE}(\$(f_batt)) \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\] (\$(parse_git_branch))\[$PURPLE\]\[$RESET\]\n\[$GREEN\]$symbol\[$RESET\]"
#PS1='$(f_notifyme)'$PS1
export PS1=$PS1
export PS2="\[$ORANGE\]>\[$RESET\]"
