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

# Install git-standup
brew install git-standup

# Install autojump
brew install autojump

# Install tmux and tmux plugins
brew install tmux
# Install reattach-to-user-namespace
brew install reattach-to-user-namespace
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install jira
gem install terjira

# Git utility
brew install tig
git config --global core.excludesfile ~/.gitignore_global


