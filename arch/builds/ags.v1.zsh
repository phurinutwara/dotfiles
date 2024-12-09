#!/usr/bin/env zsh

APP_NAME='ags.v1'

cd ~/packages
mkdir -p $APP_NAME
cd $APP_NAME
curl -o ./PKGBUILD https://raw.githubusercontent.com/kotontrion/PKGBUILDS/refs/heads/main/agsv1/PKGBUILD
makepkg -si --needed --noconfirm