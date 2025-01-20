#!/usr/bin/env zsh

echo -e "\n<<< Starting brew setup >>>\n"

if exists brew; then
  echo "brew already installed, skipped"
else
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
