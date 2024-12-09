#!/usr/bin/env zsh
[[ -f /etc/os-release ]] && . /etc/os-release

echo -e "\n<<< Starting custom packages build setup >>>\n"

if [[ $ID != "arch" ]]; then
    echo -e "\nThis is not arch distro, all my pre-configure packages will not be built"
    exit 1
fi

for item in *.zsh; do
    if [[ $item == 'setup.zsh' ]]; then continue; fi
    echo -e "\n=> starting $item\n"
    zsh $item
done