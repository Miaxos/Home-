#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Env part
# @author: Anthony Griffon
# @desc: Alias for bashrc.


# Docker for M1
# export DOCKER_HOST="ssh://ubuntu@docker.local"

# Nix
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

export GOPATH=~/go/
export NOMAD_ADDR="https://nomad-server.service.consul:4646"
export NOMAD_CACERT="/opt/homebrew/etc/consul-template/ca.crt"
export NOMAD_CLIENT_CERT="/opt/homebrew/etc/consul-template/certificate.crt"
export NOMAD_CLIENT_KEY="/opt/homebrew/etc/consul-template/pk.key"

nomad () {
    NOMAD_TOKEN=$(op item get --vault Brevz nomad-secret-id --fields password --format json | jq -r '.value') command nomad "$@"
}

export VAULT_ADDR=https://vault.service.consul:8200
vault_login () {
  vault login -method=github token=$(op item get --vault Brevz vault-miaxos-github-token --field password --format json | jq -r '.value')
}

export -f vault_login

vault_token () {
  vault login -method=github token=$(op item get --vault Brevz vault-miaxos-github-token --field password --format json | jq -r '.value') --format=json | jq -r '.auth.client_token'
}

export -f vault_token


export CONSUL_HTTP_ADDR="http://consul.service.consul:8500"
consul () {
    CONSUL_HTTP_TOKEN=$(op item get --vault Brevz consul-secret-id --fields password --format json | jq -r '.value') command consul "$@"
}

# ==================== PATH =======================
## Home local bin
export PATH=$PATH:~/.bin
# Yarn global
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Rust path
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
# n
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# APPLE LLVM SILICON
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# TO HAVE x86 OPENSSL for Cargo at Zenly
# export OPENSSL_DIR="$HOME/Dev/openssl/openssl-mac/"

export GPG_TTY=$(tty)

# start gpg-agent if not already
if [ ! -n "$(pgrep gpg-agent)" ]; then
    eval $(gpg-agent --daemon --pinentry-program /opt/homebrew/bin/pinentry-mac)
fi

# Ulimit increase
# https://github.com/mozilla/sccache/issues/342#issuecomment-1265498807
ulimit -n 10240

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
export EDITOR="/opt/homebrew/bin/nvim"

# Visual is used as EDITOR by some programs
export VISUAL="/opt/homebrew/bin/nvim"

# Set terminal color
export TERM="screen-256color";

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
# ------------------------------------------------------------
export BLOCKSIZE=1k

