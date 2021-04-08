
READLINK=$(which greadlink 2>/dev/null || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/dotfiles" ]; then
  DOTFILES_DIR="$HOME/dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

plugins = (z git zsh-autosuggestions)

source $DOTFILES_DIR/.functions
source $DOTFILES_DIR/.aliases
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILES_DIR
# OLD
#
# Path to your oh-my-zsh installation.
export ZSH="/Users/bentlusty/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# User configuration

alias c="clear"
