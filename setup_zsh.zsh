#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.

echo "Enter superuser (sudo) password to edit /etc/shells"
echo '/home/linuxbrew/.linuxbrew/bin/zsh' | sudo tee -a '/etc/shells'

echo "Enter user password to change login shell"
chsh -s '/home/linuxbrew/.linuxbrew/bin/zsh'
