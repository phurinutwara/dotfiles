#!/usr/bin/env zsh

# Go environments

# export GOROOT=/usr/local/go

if [[ $ID == "arch" ]]; then
  export GOROOT=/usr/lib/go
elif [[ $OS_TYPE == "darwin"* ]]; then
  export GOROOT="$(brew --prefix golang)/libexec"
fi

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:$PATH
