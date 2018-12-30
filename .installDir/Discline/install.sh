#!/bin/bash

# Script to instal discline to macOs

# Install pyenv 
brew install pyenv 

pyenv install 3.5.0

mkdir ~/.bin/
cp discline ~/.bin/discline

mkdir ~/.localApps/
cd ~/.localApps/
git clone https://github.com/MitchWeaver/Discline.git

~/.pyenv/versions/3.5.0/bin/pip3.5 install asyncio discord blessings pyyaml async_timeout==2.0.1

