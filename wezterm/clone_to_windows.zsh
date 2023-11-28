#!/usr/bin/env zsh

SCRIPT_DIR=$(dirname "$0")
while inotifywait -r $SCRIPT_DIR/wezterm.lua; do
	cp $SCRIPT_DIR/wezterm.lua /mnt/c/Users/phuri/.wezterm.lua
done
