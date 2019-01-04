#!/bin/bash

# Utilities installation
#
#

# Install FZF - Fuzzy find
brew install fzf ag

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

# Install Hub
brew install git hub

# Install tmux and tmux plugins
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

