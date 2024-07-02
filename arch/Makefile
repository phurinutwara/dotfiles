.PHONY: pacdump seperate dump pacrestore yayrestore restore cargodump

# DUMP ========================================================================>
pacdump:
	pacman -Qqe > ./pkgs/pacman/combined-list.txt

seperate:
	sh ./scripts/separate_packages.sh

cargodump:
	cargo install --list > ./pkgs/cargo/cargolist.txt

dump: | pacdump cargodump seperate
# <======================================================================  DUMP

# RESTORE =====================================================================>
pacrestore:
	sudo pacman -S --needed - < ./pkgs/pacman/pkglist.txt

yayrestore:
	yay -S --needed - < ./pkgs/yay/aurlist.txt

restore: | pacrestore yayrestore
# <===================================================================== RESTORE

# TODO:
# - cargorestore
# - flatpakdump, flatpakrestore
