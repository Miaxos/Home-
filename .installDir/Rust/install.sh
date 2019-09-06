#!/bin/bash

curl https://sh.rustup.rs -sSf | sh
rustup component add rustfmt
rustup component add clippy
