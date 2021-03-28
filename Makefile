SHELL := /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)


all: $(OS)

macos: sudo core-macos packages link

core-macos: brew zsh git npm

packages: brew-packages cask-apps node-packages

stow-macos: brew
	is-executable stow || brew install stow

link: stow-macos
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-macos
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle -f --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

node-packages: npm
	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)


sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

zsh: ZSH=$(which zsh)
zsh: brew
	is-executable zsh || brew install zsh && \
	is-executable omz || sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
	upgrade_oh_my_zsh \
	sudo chsh -s $(ZSH);

git: brew
	is-executable git || brew install git

npm: brew
	is-executable node || brew install node
