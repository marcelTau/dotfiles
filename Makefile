SHELL := /bin/sh

DOTFILES_DIR := $(abspath $(CURDIR))
TARGET_HOME ?= $(if $(SUDO_USER),$(shell getent passwd $(SUDO_USER) | cut -d: -f6),$(HOME))
# Override when needed, e.g. make zsh ZSHRC_SRC=zsh/.zshrc
ZSHRC_SRC ?= zsh/zshrc
ST_REPO_URL ?= https://github.com/marcelTau/st
ST_DIR ?= $(TARGET_HOME)/src/st
ST_USER ?= $(if $(SUDO_USER),$(SUDO_USER),$(shell id -un))
NVIM_VERSION ?= 0.11.6
NVIM_APPIMAGE_URL ?= https://github.com/neovim/neovim/releases/download/v$(NVIM_VERSION)/nvim-linux-x86_64.appimage

.PHONY: help install \
	git vim zsh tmux i3 i3status kitty dunst nvim \
	keyd st st-sync st-build nvim-bin require-root nvim-init nvim-lua

help:
	@echo "Shortcuts:"
	@echo "  make install   Full setup (user + system + st)"
	@echo ""
	@echo "Variables:"
	@echo "  TARGET_HOME=$(TARGET_HOME)"
	@echo "  ZSHRC_SRC=$(ZSHRC_SRC)"
	@echo "  ST_REPO_URL=$(ST_REPO_URL)"
	@echo "  ST_DIR=$(ST_DIR)"
	@echo "  ST_USER=$(ST_USER)"
	@echo "  NVIM_VERSION=$(NVIM_VERSION)"
	@echo "  NVIM_APPIMAGE_URL=$(NVIM_APPIMAGE_URL)"

install: git vim zsh tmux i3 i3status kitty dunst nvim keyd st nvim-bin

git:
	@./link_dotfile.sh "$(DOTFILES_DIR)/git/.gitconfig" "$(TARGET_HOME)/.gitconfig"

vim:
	@./link_dotfile.sh "$(DOTFILES_DIR)/vim/.vimrc" "$(TARGET_HOME)/.vimrc"

zsh:
	@./link_dotfile.sh "$(DOTFILES_DIR)/$(ZSHRC_SRC)" "$(TARGET_HOME)/.zshrc"

tmux:
	@./link_dotfile.sh "$(DOTFILES_DIR)/tmux/tmux.conf" "$(TARGET_HOME)/.tmux.conf"

i3:
	@./link_dotfile.sh "$(DOTFILES_DIR)/i3/config" "$(TARGET_HOME)/.config/i3/config"

i3status:
	@./link_dotfile.sh "$(DOTFILES_DIR)/i3status/config" "$(TARGET_HOME)/.config/i3status/config"

kitty:
	@./link_dotfile.sh "$(DOTFILES_DIR)/kitty/kitty.conf" "$(TARGET_HOME)/.config/kitty/kitty.conf"

dunst:
	@./link_dotfile.sh "$(DOTFILES_DIR)/dunst/dunstrc" "$(TARGET_HOME)/.config/dunst/dunstrc"

nvim: nvim-init nvim-lua
nvim-init:
	@./link_dotfile.sh "$(DOTFILES_DIR)/nvim/init.lua" "$(TARGET_HOME)/.config/nvim/init.lua"

nvim-lua:
	@./link_dotfile.sh "$(DOTFILES_DIR)/nvim/lua" "$(TARGET_HOME)/.config/nvim/lua"

keyd: require-root
	@set -eu; \
	mkdir -p /etc/keyd; \
	ln -sf "$(DOTFILES_DIR)/keyd/default.conf" /etc/keyd/default.conf; \
	ln -sf "$(DOTFILES_DIR)/keyd/app.conf" /etc/keyd/app.conf; \
	echo "Installed keyd configs to /etc/keyd"

st: require-root st-sync st-build

require-root:
	@set -eu; \
	test "$$(id -u)" -eq 0 || { \
		echo "Run this target with sudo"; \
		exit 1; \
	}

st-sync:
	@set -eu; \
	st_dir="$(ST_DIR)"; \
	parent_dir="$$(dirname "$$st_dir")"; \
	su - "$(ST_USER)" -c "mkdir -p \"$$parent_dir\""; \
	if [ ! -d "$$st_dir/.git" ]; then \
		su - "$(ST_USER)" -c "git clone \"$(ST_REPO_URL)\" \"$$st_dir\""; \
	else \
		su - "$(ST_USER)" -c "git -C \"$$st_dir\" pull --ff-only"; \
	fi

st-build:
	@set -eu; \
	$(MAKE) -C "$(ST_DIR)" clean install

nvim-bin: require-root
	@set -eu; \
	tmp_file="$$(mktemp /tmp/nvim.XXXXXX.appimage)"; \
	wget -O "$$tmp_file" "$(NVIM_APPIMAGE_URL)"; \
	install -m 0755 "$$tmp_file" /usr/bin/nvim; \
	rm -f "$$tmp_file"; \
	echo "Installed Neovim $(NVIM_VERSION) to /usr/bin/nvim"
