#!/bin/bash

while true; do
    read -p "Do you wish to install this program [y/n]? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

function install(){
	sudo apt install wslu

	sudo add-apt-repository ppa:kisak/kisak-mesa
	sudo apt upgrade
	sudo apt install mesa-utils vulkan-tools

	# install emoji font
	sudo apt install fonts-noto-color-emoji

	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
		installer=nightly \
		launch=n

	sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/kitty
}
