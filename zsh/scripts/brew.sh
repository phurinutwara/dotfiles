#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  export BREWFILE_PATH="$HOME/dotfiles/macos/Brewfile"
  mkdir -p "$(dirname "$BREWFILE_PATH")"
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $(uname -r) == *'WSL'* ]]; then
  export BREWFILE_PATH="$HOME/dotfiles/linux/WSL/Brewfile"
  mkdir -p "$(dirname "$BREWFILE_PATH")"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export BREWFILE_PATH="$HOME/dotfiles/linux/$ID/Brewfile"
  mkdir -p "$(dirname "$BREWFILE_PATH")"
  # TODO: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

function bbd() {
  if [[ ("$OSTYPE" != "darwin"* && "$OSTYPE" != "linux-gnu"*) ]]; then
    echo "Unknown \$OSTYPE, aborting process"
  else
    brew bundle dump --force --describe --file "$BREWFILE_PATH"
    zsh -c "echo \"\" >> $BREWFILE_PATH && echo -e \"# vim:ft=ruby\" >> $BREWFILE_PATH"
  fi
}
