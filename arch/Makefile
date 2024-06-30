.PHONY: pacdump seperate dump pacrestore yayrestore restore


pacdump:
	pacman -Qqe > combined_list.txt

seperate:
	sh ./separate_packages.sh

dump: | pacdump seperate

pacrestore:
	sudo pacman -S --needed - < pkglist.txt

yayrestore:
	yay -S --needed - < aurlist.txt

restore: | pacrestore yayrestore
