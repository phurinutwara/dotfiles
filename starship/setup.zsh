#!/usr/bin/env zsh

echo "\n<<< Starting oh-my-zsh Setup >>>\n"

if command starship >/dev/null 2>&1; then
	echo -n 'starship exists, skipping install\n'
elif [[ $OSTYPE == "darwin"* ]]; then
	echo -n 'this is macos, starship will be installed via homebrew\n'
else
	curl -sS https://starship.rs/install.sh | sh
fi
