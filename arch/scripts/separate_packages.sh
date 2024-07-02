#!/bin/bash

SCRIPT_NAME="$(basename $0)"
SCRIPT_DIR="$(realpath $(dirname $0))"
# pacman -Qqe > combined_list.txt

# Combined list of all packages
combined_list="$(realpath $SCRIPT_DIR/../pkgs/combined-list.txt)"

# Files to store the separated package lists
pkglist="$(realpath $SCRIPT_DIR/../pkgs/pacman/pkglist.txt)"
aurlist="$(realpath $SCRIPT_DIR/../pkgs/yay/aurlist.txt)"

# Empty the output files
> $pkglist
> $aurlist

while read -r package; do
    if pacman -Si "$package" &> /dev/null; then
        echo "$package" >> $pkglist
    else
        echo "$package" >> $aurlist
    fi
done < "$combined_list"

echo "Official repository packages saved to $pkglist"
echo "AUR packages saved to $aurlist"
