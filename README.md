# Dotfiles

## NordVPN

The stowed fish command provides `vpn` (Sweden), `vpn se|fr|uk|us|pl`,
`vpn off` and `vpn status`, using Arch's OpenVPN package. See
[the setup guide](docs/nordvpn.md) for profile downloads, root-owned system
installation, stored service credentials and connection checks. Profiles and
credentials stay outside Git; system changes are explicit manual steps.

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

## SSHFS automounts for rp3

Systemd mounts `~/Remote/Documents` and `~/Remote/Videos` on access and
attempts to unmount them after five idle minutes. SSH uses vinz's existing key
and known-hosts file; there are no periodic connection retries while unused.

From this repository, with the home unlocked and the old user SSHFS services
removed, install the four units and SSH helper:

```fish
sudo install -m 0644 systemd-system/etc/systemd/system/home-vinz-mnt-ssh-* /etc/systemd/system/
sudo install -Dm 0755 systemd-system/usr/local/libexec/rp3-ssh-as-vinz /usr/local/libexec/rp3-ssh-as-vinz
sudo systemctl daemon-reload
sudo systemctl enable --now home-vinz-mnt-ssh-{Documents,Videos}.automount
```

Systemd automounts require system privileges. Copy these files rather than
Stowing them into `/etc`: the encrypted home containing this repository is
unavailable before login. The triggers start with `home-vinz.mount`; only the
`.automount` units are enabled, so the shares connect on access. These units
are specific to vinz (UID/GID 60001) and preserve the existing `~/Remote`
shortcuts to `~/mnt/ssh/{Documents,Videos}`.

Use `cd ~/Remote/Documents` normally, then leave the directory when finished
so the mount can expire. A file picker displaying `~/Remote` can also trigger
mounting; our dummy test left the mounts idle when opening Home or Downloads.
Connection attempts time out after five seconds; this does not bound every
remote disk operation.

Check the triggers without accessing the shares:

```fish
systemctl status home-vinz-mnt-ssh-{Documents,Videos}.automount
```

Before updating active mounts, finish transfers and stop both their `.automount`
and `.mount` units, then repeat the installation commands above. If the triggers
are stopped, the mountpoint directories are local: do not write there expecting
files to reach rp3.
