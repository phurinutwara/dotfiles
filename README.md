# dotfiles

## TODO
- Terminal Preferences
- Changed Shell to ZSH
- Dock Preferences
- Mission Control Preference (don't rearrange spaces)
- Finder Show Path Bar
- Trackpad (Three Finger Drag and Tap to Click)
- Git (config and SSH)

## To detect OS, try this script

```zsh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi
```
See more: https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
