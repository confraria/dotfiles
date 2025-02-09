DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))


brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew-install:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-install:
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

code-install:
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

setup-zsh:
	cp $(DOTFILES_DIR)/config/zsh/zshenv ~/.zshenv
	cp $(DOTFILES_DIR)/config/zsh/zshrc ~/.zshrc
	cp $(DOTFILES_DIR)/config/zsh/zprofile ~/.zprofile

setup-git:
	cp $(DOTFILES_DIR)/config/git/ignore ~/.git
	cp $(DOTFILES_DIR)/config/git/config ~/.gitconfig

setup-ssh:
	bw list items --search ssh | jq '.[] | select(.name == "ssh").notes' -r > ~/.ssh/id_rsa
	bw list items --search ssh | jq '.[] | select(.name == "ssh").fields | .[0].value' -r > ~/.ssh/id_rsa.pub

setup-ssh-old:
	bw list items --search ssh | jq '.[] | select(.name == "ssh.old").notes' -r > ~/.ssh/id_rsa
	bw list items --search ssh | jq '.[] | select(.name == "ssh.old").fields | .[0].value' -r > ~/.ssh/id_rsa.pub

setup-iterm:
	cp $(DOTFILES_DIR)/config/iterm/* ~/Library/Preferences/

keyboard-speed:
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g KeyRepeat -int 1
