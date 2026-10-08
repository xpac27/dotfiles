# Dotfiles

## Vim on Wayland

Vim uses its clipboard-provider API with `wl-copy` and `wl-paste` when those
tools, `timeout`, and a Wayland session are available. `wl-copy` owns copied
text in a separate process, so pasting keeps working while Vim is suspended
with Ctrl+Z and after Vim exits. Both CLIPBOARD (`+`) and PRIMARY (`*`) are
supported. Clipboard commands time out after three seconds instead of hanging.

New Vim sessions load the provider automatically. For an existing session:

```vim
:runtime plugin/wayland-clipboard.vim
```

Run the live regression checks from this repository inside a Wayland session:

```sh
python vim/tests/test_wayland_clipboard.py
```

The checks launch a temporary Vim under fish, exercise Ctrl+Z and `fg`, and
temporarily replace both clipboard selections. They restore the previous text
afterward. A suspended native Vim that still owns the clipboard must be resumed
before running the checks.

## Neovim on Arch

Symlink the config:

```sh
stow -v nvim -t ~/
```

Install the required Arch packages:

```sh
sudo pacman -S neovim ripgrep wl-clipboard clang tree-sitter-cli
```

Install Codex ACP for `agentic.nvim`:

```sh
npm i -g @zed-industries/codex-acp
```

Start Neovim and install/update plugins and parsers:

```vim
:PlugInstall
:TSUpdate
:TSInstall markdown markdown_inline html yaml lua vim cpp c ruby
```

If something still looks broken, check:

```vim
:checkhealth nvim-treesitter
:checkhealth provider
```

## SSHFS mounts for rp3

The rp3 Documents and Videos mounts run in the `vinz` user systemd manager;
they therefore mount beneath `~/mnt/ssh` and never need root access. User
managers cannot create kernel autofs mounts, so these reconnecting SSHFS
services mount when the user manager starts rather than on first access.
Install the required Arch packages, then stow the units and activate them:

```sh
sudo pacman -S --needed openssh sshfs stow
stow -v systemd -t ~/
mkdir -p ~/mnt/ssh/Documents ~/mnt/ssh/Videos
systemctl --user daemon-reload
systemctl --user enable --now rp3-documents-sshfs.service rp3-videos-sshfs.service
mkdir -p ~/Remote
ln -sT ~/mnt/ssh/Documents ~/Remote/Documents
ln -sT ~/mnt/ssh/Videos ~/Remote/Videos
```

The services retry failed connections after 15 seconds. To inspect them:

```sh
systemctl --user status rp3-documents-sshfs.service rp3-videos-sshfs.service
```

After confirming the new mounts work, remove the obsolete root automounts
once. This requires an interactive `sudo` prompt:

```sh
sudo systemctl disable --now mnt-ssh-Documents.automount mnt-ssh-Videos.automount
sudo rm /etc/systemd/system/mnt-ssh-Documents.mount /etc/systemd/system/mnt-ssh-Documents.automount /etc/systemd/system/mnt-ssh-Videos.mount /etc/systemd/system/mnt-ssh-Videos.automount
sudo systemctl daemon-reload
```
