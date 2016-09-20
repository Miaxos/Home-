export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
symbol="🐯: "
GREEN="$(tput setaf 2)"
CYAN="$(tput setaf 6)"
BLUE="$(tput setaf 4)"
RESET="\[\033[00m\]"
archey -o


# Oracle config
export ORACLE_HOME=/Users/anthonygriffon/anaconda3/envs/py3k/lib/oracle
export DYLD_LIBRARY_PATH=$ORACLE_HOME
export LD_LIBRARY_PATH=$ORACLE_HOME

# Git config
git config --global core.editor /usr/bin/vim
git config --global user.name "Anthony GRIFFON"
git config --global user.email "anthony.griffon@etu.univ-nantes.fr"


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


# SSH Tunnel (Thx Guillaume)
function sshTunnel() {
	ssh -f -N -L ${1}:${2}:${3} ${4}
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


alias vim="nvim"

alias python3="source activate py3k"
alias tunnelSSH="sshTunnel 1196 crystalis.tk 22 E158196C@bastion.etu.univ-nantes.fr"
alias tunneltoto="sshTunnel 1197 totodeux.tk 22 E158196C@bastion.etu.univ-nantes.fr"

alias VPNen="sshTunnel 1194 totodeux.tk 1194 E158196C@bastion.etu.univ-nantes.fr" 

alias tunnelVPN1="sshTunnel 1723 totodeux.tk 1723 E158196C@bastion.etu.univ-nantes.fr"
alias tunnelVPN2="sshTunnel 1701 totodeux.tk 1701 E158196C@bastion.etu.univ-nantes.fr"
alias tunnelVPN3="sshTunnel 1194 totodeux.tk 1194 E158196C@bastion.etu.univ-nantes.fr"

alias tunnel1="sshTunnel 49162 crystalis.tk 49162 E158196C@bastion.etu.univ-nantes.fr"
alias tunnel2="sshTunnel 49163 crystalis.tk 49163 E158196C@bastion.etu.univ-nantes.fr"

alias shcry="ssh root@localhost -p1196"

# Alias folders
alias ll="ls -l"

# Alias git
alias gg="git pull"
alias gp="git push"
alias gc="git commit"

alias gaa="git add *"
alias ga="git add"
alias gl="git branch"
alias gk="git checkout"
alias gs="git status"

# Alias tmux
alias tl="tmux list-sessions"
alias ta="tmux attach -t "
alias tn="tmux new -s "

# Open a new finder windows at the location
alias f='open -a Finder ./' 

#Acces oracle par localhost:1506/apex/ USER: SYS
alias oracleWEB="ssh -L 1506:localhost:1506 root@91.121.177.101"
alias prolog="swipl -s"

# added by Anaconda3 2.4.1 installer
export PATH="/Users/anthonygriffon/anaconda3/bin:$PATH"

# added by Anaconda2 2.4.1 installer
# export PATH="/Users/anthonygriffon/anaconda/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# GPG Key
export GPGKEY=A6E234DA # Clé GPG
source /usr/local/etc/bash_completion.d/password-store # Completion pass


export PS1='${CYAN}\u${BLUE}@\h:\w\n${symbol}\[\033[00m\]'
export PS1='$(f_notifyme)'$PS1
