# Set Variables
# Syntax highlighting for man pages using bat
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HOMEBREW_CASK_OPTS="--no-quarantine"
export NULLCMD=bat
## WSL
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 --mouse --wheel-lines=5'


# Change ZSH Options

# Create Aliases
alias ls='exa -laFh --git'
alias exa='exa -laFh --git'
alias man=batman
alias bbd='brew bundle dump --force --describe'
alias trail='<<<${(F)path}'
alias szsh='source ~/.zshrc'
##WSL
alias wsl=wsl.exe
alias ipconfig='ipconfig.exe'
alias reset-network='ipconfig /release && ipconfig /flushdns && ipconfig /renew'
alias szsh='source ~/.zshrc'

# Customize Prompt(s)
PROMPT='
%1~ %L %# '

RPROMPT='%*'

# Add Locations to $PATH Variable

# Write Handy Functions
function mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Use ZSH Plugins

# ...Other Surprises
. /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
