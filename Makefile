DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))which

brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-install: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

setup:
	cp $(DOTFILES_DIR)/config/git/ignore ~/.git
	cp $(DOTFILES_DIR)/config/git/config ~/.gitconfig
	cp -r $(DOTFILES_DIR)/config/ssh ~/.ssh

setup-ssh:
	export JSON=$$(bw get item <ssh-id>)
	echo $$JSON | jq -r .notes
	echo $$JSON | jq -r .fields[0].value

keyboard-speed:
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
