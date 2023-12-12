sudo apt install wslu

sudo add-apt-repository ppa:kisak/kisak-mesa
sudo apt upgrade
sudo apt install mesa-utils vulkan-tools

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
	installer=nightly \
	launch=n

sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/kitty
