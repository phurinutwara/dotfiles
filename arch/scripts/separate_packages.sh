#!/bin/bash

SCRIPT_NAME="$(basename $0)"
SCRIPT_DIR="$(realpath $(dirname $0))"

ARGS=$@

C_BLUE='\033[0;34m'
C_LIGHT_GREEN='\033[0;32m'
NC='\033[0m'

# Combined list of all packages
combined_list="$(realpath $SCRIPT_DIR/../pkgs/combined-list.txt)"
# pacman -Qqe > combined_list.txt

# Files to store the separated package lists
pkglist="$(realpath $SCRIPT_DIR/../pkgs/pacman/pkglist.txt)"
aurlist="$(realpath $SCRIPT_DIR/../pkgs/yay/aurlist.txt)"

# Empty the output files
>$pkglist
>$aurlist

# DEPRECATED BUT WORKS
if [[ $ARGS != '--old' ]]; then
    # Multiple line: https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation
    echo 'parallel dumping...'
    read -r -d '' OPERATION <<-EOF
    pacman -Si %s 1>/dev/null 2>&1 &&
    (
        echo '%s: ${C_BLUE}Arch${NC} pkg (official)';
        echo %s >> $pkglist )
    || (
        echo '%s: ${C_LIGHT_GREEN}AUR${NC} pkg';
        echo %s >> $aurlist )
EOF
    cat $combined_list | xargs -P 0 -I %s bash -c "$(echo -e $OPERATION)"

    cat $pkglist | sort --unique --output=$pkglist
    cat $aurlist | sort --unique --output=$aurlist
elif [[ $ARGS == '--old' ]]; then
    echo 'line-by-line dumping...'
    while read -r package; do
        if pacman -Si "$package" &>/dev/null; then
            echo -e "$package: ${C_BLUE}Arch${NC} pkg (official)"
            echo "$package" >>$pkglist
        else
            echo -e "$package: ${C_LIGHT_GREEN}AUR${NC} pkg"
            echo "$package" >>$aurlist
        fi
    done <"$combined_list"
fi

echo "Official repository packages saved to $pkglist"
echo "AUR packages saved to $aurlist"
