# dots

Personal dotfiles for a Fedora + Sway machine (Beelink SER9 MAX).

## Install

```sh
git clone git@github.com:dkuanyshbaev/dots.git ~/src/dots
cd ~/src/dots
./install.sh
```

`install.sh` symlinks every config from this repo into its place under `~`.
Editing a file here = editing the live config.

## What's inside

- `.claude/` — Claude Code: `CLAUDE.md`, `settings.json`, `commands/`
- `sway/config` — Sway compositor config → `~/.config/sway/config`
- `sway/foot.ini` — foot terminal config → `~/.config/foot/foot.ini`
- `ssh/` — ssh-agent as a systemd user service (see below)
- `.vimrc`, `.tmux.conf` — vim / tmux (symlinks commented out in `install.sh`)
- `vis/` — vis editor
- `configuration.nix` — old NixOS config (legacy, unused on Fedora)

## ssh-agent

A user-level ssh-agent so the key passphrase is entered once per login instead
of on every git push.

- `ssh/ssh-agent.service` → `~/.config/systemd/user/ssh-agent.service`
  Runs `ssh-agent` on a fixed socket at `$XDG_RUNTIME_DIR/ssh-agent.socket`.
- `ssh/ssh-agent.conf` → `~/.config/environment.d/ssh-agent.conf`
  Exports `SSH_AUTH_SOCK` to the whole graphical session.
- `ssh/config` → `~/.ssh/config`
  `AddKeysToAgent yes` — the key is loaded into the agent automatically on the
  first git/ssh use, so the passphrase is asked once per login.

`install.sh` enables the service. After install **log out and back in** so
`SSH_AUTH_SOCK` is picked up everywhere. The first git push (or any ssh) then
asks the passphrase once and caches it for the session — no manual `ssh-add`.

```sh
ssh-add -l     # check what's loaded in the agent
```
