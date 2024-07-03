#!/usr/bin/env zsh

# TODO: EXECPT ARCH OS HERE
if [[ "$OSTYPE" == "darwin"* ]]; then
  export BREWFILE_PATH="~/dotfiles/homebrew/macos/Brewfile"
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export BREWFILE_PATH="~/dotfiles/homebrew/linux/Brewfile"
fi

function bbd() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew bundle dump --force --describe --file "$BREWFILE_PATH" \
      && zsh -c "echo \"\" >> $BREWFILE_PATH && echo -e \"# vim:ft=ruby\" >> $BREWFILE_PATH"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    brew bundle dump --force --describe --file "$BREWFILE_PATH" \
      && zsh -c "echo \"\" >> $BREWFILE_PATH && echo -e \"# vim:ft=ruby\" >> $BREWFILE_PATH"
  else
    echo "Unknown \$OSTYPE, aborting process"
  fi
}
