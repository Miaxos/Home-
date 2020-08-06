#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Env part
# @author: Anthony Griffon
# @desc: Alias for bashrc.

export GOPATH=~/go/
# ==================== PATH =======================
## Home local bin
export PATH=$PATH:~/.bin
# Yarn global
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Ruby path
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
# Rust path
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# Kafka path
export PATH="$HOME/.kafka/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# ==================== Kubernetes ===================
export KUBECONFIG=/Users/anthonygriffon/kubetest/kubeconfig

export JAVA_HOME=/Users/anthonygriffon/.bin/graalvm/Contents/Home

# ==================== Vi Bindings ==================

set -o vi

# ==================== THEFUCK =======================

# eval $(thefuck --alias)

# Coz it's to slow to eval the command
function fuck () {
  TF_PYTHONIOENCODING=$PYTHONIOENCODING;
  export TF_SHELL=bash;
  export TF_ALIAS=fuck;
  export TF_SHELL_ALIASES=$(alias);
  export TF_HISTORY=$(fc -ln -10);
  export PYTHONIOENCODING=utf-8;
  TF_CMD=$(
      thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
      ) && eval "$TF_CMD";
  unset TF_HISTORY;
  export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
  history -s $TF_CMD;
}


# ==================== HUB =======================

# eval "$(hub alias -s)"
alias git=hub

# ==================== GH Completion =======================

eval "$(gh completion -s bash)"

# ==================== Autojum =======================

# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# ==================== Fzf =======================

# Ignore node_modules
# export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
export FZF_DEFAULT_COMMAND='fd --hidden --type f .'

# ==================== GLOBAL =======================
#
# Set global EDITOR for terminal
export EDITOR="/usr/local/bin/nvim"

# Visual is used as EDITOR by some programs
export VISUAL="/usr/local/bin/nvim"

# Set terminal color
export TERM="screen-256color";

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
# ------------------------------------------------------------
export BLOCKSIZE=1k

