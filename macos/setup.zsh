#!/usr/bin/env zsh

echo -e "\n<<< Starting macos configuration setup >>>"

if [[ $OSTYPE != "darwin"* ]]; then
  echo -e "\nThis is not macos, all my pre-configure packages will not be set"
  exit 1
fi

for item in macos/*.zsh; do
  if [[ $item == 'macos/setup.zsh' ]]; then continue; fi
  echo -e "\n=> starting $item"
  zsh $item
done
