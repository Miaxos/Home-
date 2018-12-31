#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# @title: Env part
# @author: Anthony Griffon
# @desc: Alias for bashrc.

# ==================== PATH =======================
## Home local bin
export PATH=$PATH:~/.bin
# Yarn global
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Ruby path
export PATH="/usr/local/opt/ruby/bin:$PATH"

# ==================== GLOBAL =======================
#
# Set global EDITOR for terminal
export EDITOR="/usr/local/bin/nvim"

# Visual is used as EDITOR by some programs
export VISUAL="/usr/local/bin/nvim"

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
# ------------------------------------------------------------
export BLOCKSIZE=1k

