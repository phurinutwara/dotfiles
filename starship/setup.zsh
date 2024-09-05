#!/usr/bin/env zsh

echo "\n<<< Starting oh-my-zsh Setup >>>\n"

if exists starship; then
	echo 'starship exists, skipping install'
else
	curl -sS https://starship.rs/install.sh | sh
fi
