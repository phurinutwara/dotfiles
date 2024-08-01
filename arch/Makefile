.PHONY: dump pacdump seperate cargodump flatpakdump snapdump
.PHONY: restore pacrestore yayrestore

# DUMP ========================================================================>
pacdump:
	pacman -Qqe > ./pkgs/combined-list.txt

seperate:
	sh ./scripts/separate_packages.sh

cargodump:
	cargo install --list > ./pkgs/cargo/cargolist.txt

flatpakdump:
	flatpak list --columns=application,version | tail -n +1 > ./pkgs/flatpak/flatpaklist.txt

snapdump:
	snap list --all | awk '{print $1}' | tail -n +2 > ./pkgs/snap/snaplist.txt

dump: | pacdump cargodump flatpakdump snapdump seperate
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
# - flatpakrestore
# - snapdump
