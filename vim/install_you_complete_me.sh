#!/usr/bin/env bash

set -eu
set -o pipefail

pushd $HOME/.vim/plugged/YouCompleteMe

# Ask for the administrator password upfront
sudo -v

# Prepare dependencies
if [ "$(uname)" == "Darwin" ]; then
	brew install macvim cmake
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	apt update -y
	apt install -y build-essential cmake vim-nox python3-dev
fi

python3 install.py --all
