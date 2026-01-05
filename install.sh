#!/bin/bash
# To make executable: chmod +x ./install.sh

DOTS=~/src/dots

# Claude Code
mkdir -p ~/.claude
ln -sf "$DOTS/.claude/CLAUDE.md" ~/.claude/CLAUDE.md

# Vim
#ln -sf "$DOTS/.vimrc" ~/.vimrc

# Tmux
#ln -sf "$DOTS/.tmux.conf" ~/.tmux.conf

echo "Dotfiles installed"
