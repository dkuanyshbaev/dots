#!/bin/bash
# To make executable: chmod +x ./install.sh

DOTS=~/src/dots

# Claude Code
mkdir -p ~/.claude
ln -sf "$DOTS/.claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTS/.claude/settings.json" ~/.claude/settings.json

# Vim
#ln -sf "$DOTS/.vimrc" ~/.vimrc

# Tmux
#ln -sf "$DOTS/.tmux.conf" ~/.tmux.conf

echo "Dotfiles installed"
