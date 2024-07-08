#!/usr/bin/env zsh

[[ -f /etc/os-release ]] && . /etc/os-release

echo -e "\n<<< Starting ZSH Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.
if [[ $ID == "arch" ]]; then
	expect_zsh="/bin/zsh"
	if ! command -v zsh &>/dev/null; then
		echo "No zsh installed, installing zsh"
		sudo pacman -S zsh
	else
		echo "zsh installed, continue binding zsh"
	fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	expect_zsh="/usr/bin/zsh"
	echo "This might be WSL"
	if ! command -v zsh &>/dev/null; then
		echo "No zsh installed, installing zsh"
		sudo apt -y install zsh
	else
		echo "zsh installed, continue binding zsh"
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	expect_zsh="/bin/zsh"
	echo "This is MacOS, continue binding zsh"
else
	echo "Unknown OS"
	exit 1
fi

cat /etc/shells | grep $expect_zsh >/dev/null
if [[ ! $? ]]; then
	echo -e "\n[1/3] Enter superuser (sudo) password to edit /etc/shells"
	echo $expect_zsh | sudo tee -a '/etc/shells'
else
	echo -e "\n[1/3] already installed zsh, skipping edit /etc/shells"
fi

current_shell=$SHELL
if [[ $current_shell != $expect_zsh ]]; then
	echo -e "\n[2/3] Enter user password to change login shell"
	chsh -s $expect_zsh
else
	echo -e "\n[2/3] login shell already changed, skipping change login shell"
fi

if [[ $ID == "arch" ]]; then
	echo -e "\n[3/3] arch user, skipping create shell symlink"
elif [[ $OSTYPE =~ darwin* ]]; then
	linked_shell=$(realpath /private/var/select/sh)
	if [[ $linked_shell != $expect_zsh ]]; then
		echo -ne "\n[3/3] Creating shell symlink"
		sudo ln -sfv /bin/zsh /private/var/select/sh
	else
		echo -e "\n[3/3] shell already linked, skipping create shell symlink"
	fi
fi

exit
