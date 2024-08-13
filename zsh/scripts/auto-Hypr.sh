#!/usr/bin/env sh

# Auto start Hyprland on tty1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	mkdir -p ~/.cache
	exec Hyprland >~/logs/hyprland.log 2>&1
fi
