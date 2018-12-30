#!/bin/bash

# Script to ncmpcpp to macOs

# Install mpd
brew install mpd

# Install ncmcpp with vizualizer
brew install ncmpcpp --with-outputs --with-visualizer --with-clock --enable-clock --enable-outputs --enable-unicode --enable-visualizer --with-curl --with-taglib

# Install beets for metadata
pip install beets
pip install requests pylast

