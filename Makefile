DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-install:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-install:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

code-install:
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

setup:
	cp $(DOTFILES_DIR)/config/git/ignore ~/.git
	cp $(DOTFILES_DIR)/config/git/config ~/.gitconfig
	cp -r $(DOTFILES_DIR)/config/ssh ~/.ssh

setup-ssh:
	bw list items --search ssh | jq '.[] | select(.name == "ssh").notes' > ~/.ssh/id_rsa
	bw list items --search ssh | jq '.[] | select(.name == "ssh").fields | .[0].value' -r > ~/.ssh/id_rsa.pub

setup-ssh-old:
	bw list items --search ssh | jq '.[] | select(.name == "ssh.old").notes' > ~/.ssh/id_rsa
	bw list items --search ssh | jq '.[] | select(.name == "ssh.old").fields | .[0].value' -r > ~/.ssh/id_rsa.pub

keyboard-speed:
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
