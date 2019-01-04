#!/bin/bash

git clone https://github.com/insanum/gcalcli.git
cd gcalcli
python3 setup.py install
cd ../
rm -rf gcalcli

