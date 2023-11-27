#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.

echo "Enter superuser (sudo) password to edit /etc/shells"
echo $(which -a zsh | head -1) | sudo tee -a '/etc/shells'

echo "Enter user password to change login shell"
chsh -s $(which -a zsh | head -1)

sudo ln -sfv $(which -a zsh | head -1) /private/var/select/sh
