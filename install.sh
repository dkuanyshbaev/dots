#!/bin/bash
# To make executable: chmod +x ./install.sh

DOTS=~/src/dots

# Claude Code
mkdir -p ~/.claude
ln -sf "$DOTS/.claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTS/.claude/settings.json" ~/.claude/settings.json
ln -sf "$DOTS/.claude/commands" ~/.claude/commands

# Sway + foot
mkdir -p ~/.config/sway ~/.config/foot
ln -sf "$DOTS/sway/config"   ~/.config/sway/config
ln -sf "$DOTS/sway/foot.ini" ~/.config/foot/foot.ini

# SSH agent (systemd user service + environment.d) + ssh client config
mkdir -p ~/.config/environment.d ~/.config/systemd/user
ln -sf "$DOTS/ssh/ssh-agent.conf"    ~/.config/environment.d/ssh-agent.conf
ln -sf "$DOTS/ssh/ssh-agent.service" ~/.config/systemd/user/ssh-agent.service
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ln -sf "$DOTS/ssh/config" ~/.ssh/config
systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.service

# Vim
#ln -sf "$DOTS/.vimrc" ~/.vimrc

# Tmux
#ln -sf "$DOTS/.tmux.conf" ~/.tmux.conf

echo "Dotfiles installed"
