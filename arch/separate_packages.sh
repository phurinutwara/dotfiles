#!/bin/bash

pacman -Qqe > combined_list.txt

# Combined list of all packages
combined_list="combined_list.txt"

# Files to store the separated package lists
pkglist="pkglist.txt"
aurlist="aurlist.txt"

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
