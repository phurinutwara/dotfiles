#!/usr/bin/env zsh

# to reset configuration
# `defaults delete -g ApplePressAndHoldEnabled` or `defaults delete NSGlobalDomain ApplePressAndHoldEnabled`
# to reset all configurations use
# `defaults delete -g` or `defaults delete NSGlobalDomain`

echo -n '[1/2] disabling ApplePressAndHoldEnabled...'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
echo 'OK'

echo -n '[2/2] adjusting InitialKeyRepeat and KeyRepeat...'
# See https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x/83923#83923
defaults write NSGlobalDomain InitialKeyRepeat -int 9
defaults write NSGlobalDomain KeyRepeat -int 1
echo 'OK'

echo "\nCompleted macos configuration with 'defaults' command.\n"
