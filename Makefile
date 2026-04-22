.PHONY: all
all: neovim fish starship git tmux util-scripts


##############################
# Editor
##############################

.PHONY: neovim neovim.original vim

neovim:
	ln -sf $(CURDIR)/nvim/current $(HOME)/.config/nvim

neovim.original:
	ln -sf $(CURDIR)/nvim/original $(HOME)/.config/nvim
	$(HOME)/.config/nvim/setup.sh

vim:
	ln -sf $(CURDIR)/vim/vimrc $(HOME)/.vimrc
	$(CURDIR)/vim/setup.sh


##############################
# Shell
##############################

.PHONY: fish zsh starship

fish:
	# fish install note: https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262
	ln -sf $(CURDIR)/fish $(HOME)/.config/fish
	fish -c "fisher update"
	fish_update_completions

zsh:
	# Install zsh auto-suggestions by git submodule
	git submodule update --init

	ln -sf $(CURDIR)/zsh/zshrc $(HOME)/.zshrc
	ln -sf $(CURDIR)/zsh/zsh_config $(HOME)/.config/zsh

starship:
	ln -sf $(CURDIR)/starship/starship.toml $(HOME)/.config/starship.toml


##############################
# Useful tools
##############################

.PHONY: git tmux util-scripts k9s

git:
	ln -sf $(CURDIR)/git $(HOME)/.config/git

tmux:
	## ~/.tmux.conf       Default tmux configuration file.
	## /etc/tmux.conf     System-wide configuration file.
	ln -sf $(CURDIR)/tmux/tmux.conf $(HOME)/.tmux.conf
	tmux source-file $(HOME)/.tmux.conf

util-scripts:
	ln -sf $(CURDIR)/bin $(HOME)/.bin

k9s:
	ln -sf $(CURDIR)/k9s $(HOME)/.config/k9s


##############################
# Terminal emulator
##############################

.PHONY: alacritty

alacritty:
	ln -sf $(CURDIR)/alacritty $(HOME)/.config/alacritty


##############################
# Initialize macOS
##############################

.PHONY: init.macOS

init.macOS:
	$(CURDIR)/macos/init.sh


##############################
# Setup Nix
##############################

.PHONY: nix nix.home-manager

nix:
	ln -sf $(CURDIR)/nix ~/.config/nix

nix.home-manager:
	# Need to run `git add` after updating configs
	ln -sf $(CURDIR)/nixpkgs $(HOME)/.config/home-manager
	home-manager switch
