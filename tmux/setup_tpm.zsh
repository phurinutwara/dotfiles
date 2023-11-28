#!/usr/bin/env zsh

TPM_PATH=~/.tmux/plugins/tpm

echo "\n<<< Starting Tmux Plugin Manager Setup >>>\n"

if exa $TPM_PATH >/dev/null 2>&1; then
	echo "tpm exists, skipping install"
else
	echo "tpm doesn't exist, continuing with install"
	git clone https://github.com/tmux-plugins/tpm $TPM_PATH
fi
