#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.

expect_zsh=$(which zsh)
sudo cat /etc/shells | grep $expect_zsh >/dev/null
if [ $? = "1" ]; then
	echo "\n[1/3] Enter superuser (sudo) password to edit /etc/shells"
	echo $(which zsh) | sudo tee -a '/etc/shells'
else
	echo "\n[1/3] already have homebrew-installed zsh, skipping edit /etc/shells"
fi

current_shell=$(echo $SHELL)
if [ $current_shell != $expect_zsh ]; then
	echo "\n[2/3] Enter user password to change login shell"
	chsh -s $(which zsh)
else
	echo "\n[2/3] login shell already changed, skipping change login shell"
fi


linked_shell=$(realpath private/var/select/sh 2>&1 >/dev/null)
if [ $linked_shell != $expect_zsh ]; then
	echo -n "\n[3/3] "
	sudo ln -sfv /bin/zsh /private/var/select/sh
else
	echo "\n[3/3] shell already linked, skipping create shell symlink"
fi

exit