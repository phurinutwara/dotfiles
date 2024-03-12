#!/usr/bin/env zsh

TPM_PATH=~/.tmux/plugins/tpm

echo "\n<<< Starting Tmux Plugin Manager Setup >>>\n"

if ls $TPM_PATH >/dev/null 2>&1; then
	echo "tpm exists, skipping install"
else
	echo "tpm doesn't exist, continuing with install"
	git clone https://github.com/tmux-plugins/tpm $TPM_PATH
fi

if exists tmuxinator; then
	sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
fi
