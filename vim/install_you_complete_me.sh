#!/usr/bin/env bash

set -eu
set -o pipefail

pushd $HOME/.vim/plugged/YouCompleteMe

# Prepare dependency
if [ "$(uname)" == "Darwin" ]; then
	[ "$UID" -eq 0  ] || exec sudo bash -c "brew install macvim cmake"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	[ "$UID" -eq 0  ] || exec sudo bash -c "apt update -y; apt install -y build-essential cmake vim-nox python3-dev"
fi

python3 install.py --all

