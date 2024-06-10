#!/usr/bin/env zsh

SCRIPT_DIR=$(dirname "$0")
SCRIPT_NAME=$(basename "$0")

HOST_USERPATH=$(wslupath -H)

MODULE_FILES=(
	$( find . |
		grep -P -i '^./(?!wezterm.lua)' |
		grep -P -i $(echo '^./(?!'$SCRIPT_NAME')') |
		grep -P -i '^./.*(\.).*$' |
		sed 's/^..//'
	)
)
# echo 'selected file:'
# echo ${(F)MODULE_FILES}

function copy(){
	# copy main script
	cp -vr "$SCRIPT_DIR/wezterm.lua" "$HOST_USERPATH/.wezterm.lua"

	# copy modules
	for value in "${MODULE_FILES[@]}"
	do
		mkdir -p $(dirname "$HOST_USERPATH/.wezterm/$value")
		cp -v "$SCRIPT_DIR/$value" "$HOST_USERPATH/.wezterm/$value"
	done
}

function watcher(){
		quit_hint
	while inotifywait $SCRIPT_DIR/**; do
		copy
		quit_hint
	done
}

function quit_hint(){
		echo "Press <C-c> to quit"
}

function start(){
	copy
	watcher
}
start
