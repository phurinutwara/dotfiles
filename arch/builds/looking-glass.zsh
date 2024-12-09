#!/usr/bin/env zsh

APP_NAME='LookingGlass'

# Building
# See https://looking-glass.io/docs/B6/build/

cd ~/packages
git clone --recursive https://github.com/gnif/LookingGlass.git
cd $APP_NAME

# Installation on other distributions
# see https://looking-glass.io/wiki/Installation_on_other_distributions#Arch_Linux_.2F_Manjaro

# installing Dependencies for Client Build
sudo pacman -Syu
sudo pacman -S cmake gcc libgl libegl fontconfig spice-protocol make nettle pkgconf binutils \
    libxi libxinerama libxss libxcursor libxpresent libxkbcommon wayland-protocols \
    ttf-dejavu libsamplerate --needed --noconfirm
# installing Additional Dependencies for Kernel Module Build
sudo pacman -S dkms linux-headers --needed --noconfirm

# building
# see https://looking-glass.io/docs/B6/build/#client-building
if [[ ! -d "client/build" ]]; then
    mkdir -p client/build
    cd client/build
    cmake ../
    make
fi

# Make shorthand for `looking-glass`
echo '#!/usr/bin/env bash' >~/dotfiles/zsh/scripts/custom/looking-glass.sh
echo '' >>~/dotfiles/zsh/scripts/custom/looking-glass.sh

echo -e 'alias looking-glass='\''~/packages/LookingGlass/client/build/looking-glass-client wayland:warpSupport=no &!'\' >>~/dotfiles/zsh/scripts/custom/looking-glass.sh
