#!/usr/bin/env bash

# Auto start Hyprland on tty1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	mkdir -p ~/.cache/logs
	echo 'Starting Hyprland...'
	exec Hyprland >~/.cache/logs/hyprland.log 2>&1
fi
