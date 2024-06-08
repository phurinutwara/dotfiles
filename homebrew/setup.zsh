#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

if exists brew; then
	echo "brew exists, skipping install"
else
	echo "brew doesn't exist, continuing with install"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		sudo apt-get update
		sudo apt-get install build-essential procps curl file git
	fi
fi

# TODO: Keep an eye out for a different `--no-quarantine` solution.
# Currently, you can't do `brew bundle --no-quarantine` as an option.
# It's currently exported in zshrc:
# export HOMEBREW_CASK_OPTS="--no-quarantine"
# https://github.com/Homebrew/homebrew-bundle/issues/474

if [[ "$SHELL" != "/bin/zsh" ]]; then
	echo "Please change your shell to zsh to use brew bundle"
	exit 1
else
	if [[ "$OSTYPE" == "darwin"* ]]; then
		brew bundle --verbose --file='./homebrew/Brewfile/'
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		brew bundle --verbose --file='./homebrew/Brewfile/'
	fi
fi
