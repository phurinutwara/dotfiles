#!/usr/bin/env bash

script_dir="$(dirname $(realpath $0))"
if [[ ! -d "$(realpath $script_dir/../custom)" ]]; then
	echo 'Creating custom folder...'
	mkdir -p '../custom'
fi

env=$(realpath $script_dir/../custom/env.conf)
if [[ ! -f "$env" ]]; then
	echo 'Adding env.conf ...'
	(
		tee <<-EOF
			# vim: ft=hyprlang
			#
			# You can put extra environment variables here
			# https://wiki.hyprland.org/Configuring/Environment-variables/
		EOF
	) >"$env"
fi

execs=$(realpath $script_dir/../custom/execs.conf)
if [[ ! -f "$execs" ]]; then
	echo 'Adding execs.conf ...'
	(
		tee <<-EOF
			# vim: ft=hyprlang
			#
			# You can make apps auto-start here
			# Relevant Hyprland wiki section: https://wiki.hyprland.org/Configuring/Keywords/#executing
		EOF
	) >"$execs"
fi

general=$(realpath $script_dir/../custom/general.conf)
if [[ ! -f "$general" ]]; then
	echo 'Adding general.conf ...'
	(
		tee <<-EOF
			# vim: ft=hyprlang
			#
			# Put general config stuff here
			# Here's a list of every variable: https://wiki.hyprland.org/Configuring/Variables/
		EOF
	) >"$general"
fi

keybinds=$(realpath $script_dir/../custom/keybinds.conf)
if [[ ! -f "$keybinds" ]]; then
	echo 'Adding keybinds.conf ...'
	(
		tee <<-EOF
			# vim: ft=hyprlang
			#
			# You can put your preferred keybinds here
			# https://wiki.hyprland.org/Configuring/Binds/
		EOF
	) >"$keybinds"
fi

rules=$(realpath $script_dir/../custom/rules.conf)
if [[ ! -f "$rules" ]]; then
	echo 'Adding rules.conf ...'
	(
		tee <<-EOF
			# vim: ft=hyprlang
			#
			# You can put custom rules here
			# Window/layer rules: https://wiki.hyprland.org/Configuring/Window-Rules/
			# Workspace rules: https://wiki.hyprland.org/Configuring/Workspace-Rules/
		EOF
	) >"$rules"
fi
