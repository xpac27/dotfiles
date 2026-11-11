# NordVPN with OpenVPN on Arch

Use the Arch `openvpn` package (2.7 or newer), systemd-resolved, and the existing
`openvpn-client@.service` template. No AUR or NordVPN app is required. The fish
function and completions are stowed; the installer **copies** root-owned system
files. Do not stow these generated system files or credentials from a writable
home directory into `/etc`.

## Daily use

```fish
vpn       # Connect to Sweden, the default
vpn se    # Sweden
vpn fr    # France
vpn uk    # United Kingdom
vpn us    # United States
vpn pl    # Poland
vpn off
vpn status
```

Each country uses one downloaded server profile, not automatic fastest-server
selection. systemd stops the previous country before starting the new one,
including when using `systemctl start openvpn-client@nordvpn-fr.service` directly.
Starting the already-active country is a no-op. `vpn status` reports systemd
state; it does not independently verify your public IP or country.

The Polkit rule permits only `vinz` (or the user passed to the installer) in an
active local session to start/stop these five services without a password. It
does not grant service editing, arbitrary units, or remote SSH access. NordVPN
authentication uses a separate root-only credentials file. Nothing is enabled
at boot by this setup.

This is an ordinary on-demand VPN, **not a firewall kill switch**: disconnects,
failed connections and country switches can leave normal Internet access.
While connected, public IPv6 is routed into OpenVPN and rejected to avoid
bypassing NordVPN's IPv4 tunnel. Local LAN routes remain accessible. DNS uses
OpenVPN 2.7's packaged `dns-updown` helper, which applies the server's DNS to
systemd-resolved with the `~.` routing domain and reverts it on disconnect.
Applications with their own DNS configuration may bypass the system resolver;
other VPNs or explicit split-DNS routes require separate verification.

## 1. Download profiles (as your normal user)

In Nord Account: NordVPN → Advanced Settings → Set up NordVPN manually.
Download fresh **OpenVPN UDP** profiles for Sweden, France, United Kingdom,
United States and Poland; choose verified servers where shown. Leave them in
`~/Downloads/` under their original names, for example
`se582.nordvpn.com.udp_2.6.ovpn`. There must be exactly one matching UDP
download per country. Alternatively use a separate directory and rename them:

```text
~/Downloads/nordvpn/se.ovpn
~/Downloads/nordvpn/fr.ovpn
~/Downloads/nordvpn/uk.ovpn
~/Downloads/nordvpn/us.ovpn
~/Downloads/nordvpn/pl.ovpn
```

Keep profiles and credentials outside the repository. The installer preserves
the downloaded certificate/cipher settings. It checks for self-contained UDP
client profiles and refuses unexpected directives, scripts and external files;
it cannot infer a server's country from an IP address or prove availability.

From the dotfiles checkout, validate without changing anything:

```fish
python scripts/install-nordvpn.py --profiles ~/Downloads --user vinz
stow -n -v -t ~ fish
```

Then apply the fish links if the dry run reports no conflicts:

```fish
stow -v -t ~ fish
```

To inspect generated system files before installing, optionally add
`--destdir /tmp/nordvpn-review` to the Python command. That directory must not
already exist. Never put service credentials in the review directory.

## 2. Install system files (commands for you to run)

The assistant does not run admin commands. Open an administrative fish shell:

```fish
su -s /usr/bin/fish
```

On this machine OpenVPN and systemd-resolved are already present. On a fresh
Arch installation, install `openvpn`, `polkit`, `python`, `fish` and `stow` from
the official repositories, and configure systemd-resolved first. The installer
requires `/etc/resolv.conf` to point to `/run/systemd/resolve/stub-resolv.conf`.
It deliberately does not replace a different machine's DNS configuration.

Run in that **root fish shell**, adjusting the checkout path/user if needed:

```fish
python /home/vinz/Github/dotfiles/scripts/install-nordvpn.py --profiles /home/vinz/Downloads --user vinz --install
```

The installer writes five root-only profiles and five instance-specific
systemd drop-ins, plus `/etc/polkit-1/rules.d/49-nordvpn.rules`. It refuses to
overwrite unrelated files or follow symlinks. It never starts services,
enables autoconnect, edits credentials or alters the shared OpenVPN template.

## 3. Store service credentials once (same root shell)

In Nord Account's manual setup page, open **Service credentials** and complete
the email verification. These are not your Nord Account email/password.

```fish
umask 077
vim -Nu NONE -n -i NONE -c 'set nobackup nowritebackup noswapfile noundofile' /etc/openvpn/client/nordvpn.auth
```

Enter exactly two lines: service username, then service password. Save and exit.
This Vim invocation avoids persistent undo, backup, swap and viminfo copies.
Do not paste credentials into shell commands, chat or Git.

```fish
chown root:root /etc/openvpn/client/nordvpn.auth
chmod 600 /etc/openvpn/client/nordvpn.auth
systemctl daemon-reload
exit
```

Polkit watches its rules directory, so it normally needs no restart. Stored
service credentials are reused after reconnects, switches and reboots; update
the file if they change or are revoked. A valid subscription is still required.

## 4. Connect and verify (normal user)

```fish
vpn
vpn status
resolvectl status tun-nordvpn
ip -4 route get 1.1.1.1
ip -6 route get 2606:4700:4700::1111
```

Expect `tun-nordvpn` for the public routes, VPN DNS servers and `~.` on that
link. Verify the public IP/country using NordVPN's connection check, and check
DNS and IPv6 in a browser at https://ipleak.net/. IPv6 Internet connectivity
should be unavailable while connected. A green service state alone is not
proof of correct DNS, routes or location.

Try each country, then disconnect:

```fish
vpn fr
vpn uk
vpn us
vpn pl
vpn off
```

Check the public country after each switch. After `vpn off`, confirm normal
Internet/DNS operation and that `tun-nordvpn` is gone. Check suspend/resume
once as well; no old ProtonVPN sleep hook is reused.

If a connection fails, inspect its log (journal permissions may require root):

```fish
journalctl -b -u openvpn-client@nordvpn-se.service -n 60 --no-pager
```

There is a 60-second startup timeout. Failed authentication does not prompt for
a new password or repeatedly retry rejected credentials. DNS integration
depends on the packaged helper succeeding; verify it on this host before
relying on the setup.

## Reinstall or change servers

Keep only one current download per country (or use the short filenames in a
separate directory). Run `vpn off`,
repeat validation and the root installer command, then `systemctl daemon-reload`
as root. The existing `nordvpn.auth` is preserved. The country services should
remain disabled at boot unless you deliberately choose an autoconnect policy.

To change the default country, edit `set -l action se` in
`fish/.config/fish/functions/vpn.fish` and update its help/completion text.

## Checks for repository changes

These use temporary files and mocked commands; they never start a VPN:

```fish
python -B -m unittest discover -s scripts/tests -p 'test_nordvpn.py' -v
fish --no-config -n fish/.config/fish/functions/vpn.fish
fish --no-config -n fish/.config/fish/completions/vpn.fish
```

References:

- [NordVPN manual OpenVPN setup](https://support.nordvpn.com/hc/en-us/articles/20164827795345-How-to-set-up-a-manual-connection-on-Linux-using-OpenVPN)
- [NordVPN service credentials](https://support.nordvpn.com/hc/en-us/articles/19685514639633-How-to-find-your-service-credentials-for-manual-NordVPN-setup)
- [OpenVPN 2.7 manual: DNS integration, auth-user-pass and block-ipv6](https://openvpn.net/community-docs/community-articles/openvpn-2-7-manual/)
- `man systemd.unit`: Conflicts and ordering dependencies
