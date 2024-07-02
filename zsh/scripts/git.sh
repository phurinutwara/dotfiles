#!/usr/bin/env zsh

if [[ $ID == "ARCH" ]]; then
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias gopen='git config --get remote.origin.url | perl -pe "s/:(?!\/\/)/\//g" | sed "s/^git@/https:\/\//" | sed "s/.git$//" | xargs -I % echo "sensible-browser %" | sh'
  alias gopr='
    git config --get remote.origin.url | \
    perl -pe "s/:(?!\/\/)/\//g" | sed "s/^git@/https:\/\//" | \
    sed "s/.git$//" | \
    xargs -I _ echo "sensible-browser _/pull-requests/new?source=$(git branch --show-current)\&dest=develop" | sh'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias gopen='git config --get remote.origin.url | perl -pe "s/:(?!\/\/)/\//g" | sed "s/^git@/https:\/\//" | sed "s/.git$//" | xargs -I % echo "open %" | sh'
  alias gopr='
    git config --get remote.origin.url | \
    perl -pe "s/:(?!\/\/)/\//g" | \
    sed "s/^git@/https:\/\//" | \
    sed "s/.git$//" | \
    xargs -I _ echo "open _/pull-requests/new?source=$(git branch --show-current)\&dest=develop" | sh'
fi
