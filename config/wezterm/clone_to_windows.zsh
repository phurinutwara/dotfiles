#!/usr/bin/env zsh

HOST_USER=phurinutwara
SCRIPT_DIR=$(dirname "$0")
while inotifywait -r $SCRIPT_DIR/**; do
	cp -vr $SCRIPT_DIR/wezterm.lua /mnt/c/Users/$HOST_USER/.wezterm.lua
	echo ""
	cp -vr $SCRIPT_DIR /mnt/c/Users/$HOST_USER/.wezterm/
done
