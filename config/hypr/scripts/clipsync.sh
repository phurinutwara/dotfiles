#!/usr/bin/env bash
# One-way clipboard syncronization from Wayland to X11.
# Requires: wl-clipboard, xclip, clipnotify.
#
# Usage:
#   clipsync.sh watch - run in background.
#   clipsync.sh kill - kill all background processes.
#   echo -n any | clipsync.sh insert - insert clipboard content fron stdin.
#
# Workaround for issue:
# "Clipboard synchronization between wayland and xwayland clients broken"
# https://github.com/hyprwm/Hyprland/issues/6132

# Updates clipboard content of both Wayland and X11 if current clipboard content differs.
# Usage: echo -e "1\n2" | clipsync insert

watch() {
    # Wayland -> X11
    while clipnotify; do
        CLIPTYPE=$(wl-paste --list-types)
        echo $CLIPTYPE
        if [[ $CLIPTYPE =~ 'text' ]]; then
            wl-paste | xclip -r -selection clipboard
        fi
    done &
}

kill() {
    pkill -e wl-paste
    pkill -e clipnotify
    pkill -e xclip
    pkill -e clipsync
}

"$@"
