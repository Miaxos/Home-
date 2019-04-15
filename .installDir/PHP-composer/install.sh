#!/bin/bash
brew install mcrypt php@7.2
brew install composer

echo "You should put export PATH=\"$(brew --prefix homebrew/php/php70)/bin:$PATH\" in bashrc"
