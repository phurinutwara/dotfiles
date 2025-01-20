#!/usr/bin/env zsh

echo "\n<<< Starting Node Setup >>>\n"

if exists node; then
  echo "node $(node --version) & NPM $(npm --version) already installed"
else
  echo "installing nvm & node..."
  brew install nvm
  nvm install node
fi

if ! exists pnpm; then
  echo "\ninstalling pnpm..."
  brew install pnpm
fi

# Install Global NPM Packages
echo "\ninstalling global packages..."
pnpm install --global trash-cli

echo "\nGlobal PNPM packages installed:"
pnpm list --global --depth=0
echo ""
