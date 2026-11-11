#!/usr/bin/env python3
"""Validate NordVPN downloads; install only with an explicit --install.

No credentials are read, written or printed. --destdir stages files for review
and tests without touching the host. See docs/nordvpn.md.
"""

import argparse
import json
import os
from pathlib import Path
import pwd
import re
import shlex
import subprocess
import sys
import tempfile

COUNTRIES = ("se", "fr", "uk", "us", "pl")
MARKER = "Managed by dotfiles/scripts/install-nordvpn.py"
# Only self-contained provider profiles are accepted. In particular, no scripts,
# plugins, nested configs, external keys, management sockets or output files.
ALLOWED = set("""
client pull dev proto remote resolv-retry nobind persist-key persist-tun
remote-cert-tls auth-user-pass verb fast-io cipher data-ciphers
data-ciphers-fallback auth tls-client key-direction reneg-sec ping
ping-restart ping-timer-rem tun-mtu tun-mtu-extra mssfix explicit-exit-notify
remote-random remote-random-hostname sndbuf rcvbuf connect-retry
connect-retry-max connect-timeout tls-version-min tls-version-max tls-cipher
tls-ciphersuites verify-x509-name auth-nocache comp-lzo allow-compression
""".split())
OVERRIDDEN = {"dev", "proto", "auth-user-pass", "auth-nocache"}
COMMON = """
# Local unattended authentication, routing and DNS policy.
auth-user-pass /etc/openvpn/client/nordvpn.auth
auth-nocache
auth-retry none
dev tun-nordvpn
dev-type tun
proto udp4
dns-updown force
# Keep our IPv4 + IPv6 policy even if the server pushes its own redirect.
pull-filter ignore "redirect-gateway"
pull-filter ignore "ifconfig-ipv6"
pull-filter ignore "route-ipv6"
redirect-gateway def1 ipv6
ifconfig-ipv6 fd15:53b6:dead::2/64 fd15:53b6:dead::1
block-ipv6
"""


def profile(path):
    """Preserve provider crypto settings, reject executable/external directives."""
    text = path.read_text()
    lines = []
    block = None
    blocks = set()
    options = {}
    for number, line in enumerate(text.splitlines(), 1):
        value = line.strip()
        if block:
            if value == f"</{block}>":
                block = None
            lines.append(line)
            continue
        if value.startswith("<"):
            if value not in ("<ca>", "<tls-auth>", "<tls-crypt>", "<tls-crypt-v2>"):
                raise ValueError(f"{path}:{number}: unsupported inline block")
            block = value[1:-1]
            if block in blocks:
                raise ValueError(f"{path}:{number}: duplicate inline block")
            blocks.add(block)
            lines.append(line)
            continue
        if not value or value.startswith(("#", ";")):
            lines.append(line)
            continue
        tokens = shlex.split(value, comments=True)
        if not tokens:
            continue
        option = tokens[0].removeprefix("--")
        if option not in ALLOWED:
            raise ValueError(f"{path}:{number}: unsupported directive {option!r}; review before installing")
        options.setdefault(option, []).append(tokens[1:])
        if option not in OVERRIDDEN:
            lines.append(line)
    if block:
        raise ValueError(f"{path}: unterminated inline block")
    if "client" not in options or "remote" not in options or "ca" not in blocks:
        raise ValueError(f"{path}: expected a client profile with remote and inline CA")
    if options.get("remote-cert-tls") != [["server"]]:
        raise ValueError(f"{path}: expected remote-cert-tls server")
    if options.get("proto") not in ([["udp"]], [["udp4"]]):
        raise ValueError(f"{path}: download an OpenVPN UDP profile")
    if options.get("dev") != [["tun"]]:
        raise ValueError(f"{path}: expected dev tun")
    for remote in options["remote"]:
        if not 1 <= len(remote) <= 3 or (len(remote) == 3 and remote[2] not in ("udp", "udp4")):
            raise ValueError(f"{path}: expected UDP remote")
    return f"# {MARKER}\n" + "\n".join(lines) + "\n" + COMMON


def files(profiles, username):
    if not re.fullmatch(r"[a-z_][a-z0-9_-]*", username):
        raise ValueError("Expected a Linux user name")
    units = [f"openvpn-client@nordvpn-{c}.service" for c in COUNTRIES]
    result = {}
    for index, country in enumerate(COUNTRIES):
        source = profiles / f"{country}.ovpn"
        if not source.is_file():
            matches = sorted(p for p in profiles.glob(f"{country}*.ovpn")
                             if re.fullmatch(rf"{country}\d+\.nordvpn\.com\.udp(?:_[\d.]+)?\.ovpn", p.name))
            if len(matches) != 1:
                raise ValueError(f"{profiles}: expected {country}.ovpn or exactly one {country}*.nordvpn.com.udp*.ovpn (found {len(matches)})")
            source = matches[0]
        result[f"etc/openvpn/client/nordvpn-{country}.conf"] = (
            profile(source), 0o600)
        others = [u for u in units if u != units[index]]
        # A total ordering avoids cycles while ensuring stop-before-start for
        # every pair of conflicting countries, in either switching direction.
        after = ["systemd-resolved.service"] + units[index + 1:]
        dropin = f"""# {MARKER}
[Unit]
Requires=systemd-resolved.service
After={' '.join(after)}
Conflicts={' '.join(others)}

[Service]
TimeoutStartSec=60s
TimeoutStopSec=15s
"""
        result[f"etc/systemd/system/{units[index]}.d/50-nordvpn.conf"] = (dropin, 0o644)
    rule = f"""// {MARKER}
// Only these root-owned profiles, for this active local user's start/stop.
polkit.addRule(function(action, subject) {{
    var units = {json.dumps(units)};
    var verb = action.lookup("verb");
    if (action.id === "org.freedesktop.systemd1.manage-units" &&
        subject.user === {json.dumps(username)} && subject.local && subject.active &&
        units.indexOf(action.lookup("unit")) !== -1 &&
        (verb === "start" || verb === "stop")) {{
        return polkit.Result.YES;
    }}
}});
"""
    result["etc/polkit-1/rules.d/49-nordvpn.rules"] = (rule, 0o644)
    return result


def write_files(root, generated):
    # Inspect every destination before writing anything. Never follow an
    # existing symlink or replace an unrelated configuration.
    for name in generated:
        target = root / name
        for parent in (target, *target.parents):
            if parent.is_symlink():
                raise ValueError(f"Refusing symlink: {parent}")
        if target.exists():
            first_line = target.read_text().splitlines()[:1]
            if not first_line or MARKER not in first_line[0]:
                raise ValueError(f"Refusing to overwrite unmanaged file: {target}")
    for name, (content, mode) in generated.items():
        target = root / name
        target.parent.mkdir(parents=True, exist_ok=True)
        fd, temporary = tempfile.mkstemp(prefix=".nordvpn-", dir=target.parent)
        try:
            with os.fdopen(fd, "w") as stream:
                stream.write(content)
                os.fchmod(stream.fileno(), mode)
            os.replace(temporary, target)
        finally:
            if os.path.exists(temporary):
                os.unlink(temporary)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--profiles", required=True, type=Path)
    parser.add_argument("--user", required=True)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--install", action="store_true", help="write system files as root; never start a VPN")
    mode.add_argument("--destdir", type=Path, help="stage files in a new directory without root")
    args = parser.parse_args()
    generated = files(args.profiles, args.user)
    if args.install:
        if os.geteuid() != 0:
            raise ValueError("--install must be run by you as root; no automatic elevation")
        pwd.getpwnam(args.user)
        version = subprocess.check_output(["/usr/bin/openvpn", "--version"], text=True).splitlines()[0]
        match = re.search(r"OpenVPN (\d+)\.(\d+)", version)
        if not match or tuple(map(int, match.groups())) < (2, 7):
            raise ValueError("OpenVPN 2.7 or newer is required for the bundled DNS helper")
        if not Path("/usr/lib/openvpn/dns-updown").is_file():
            raise ValueError("Missing OpenVPN DNS helper")
        if Path("/etc/resolv.conf").resolve() != Path("/run/systemd/resolve/stub-resolv.conf"):
            raise ValueError("This setup expects systemd-resolved's stub resolv.conf; see docs/nordvpn.md")
        write_files(Path("/"), generated)
        print("Installed. Credentials were untouched; no service was started or reloaded.")
        print("Next: create nordvpn.auth if needed, then systemctl daemon-reload. See docs/nordvpn.md.")
    elif args.destdir:
        args.destdir.mkdir(mode=0o700)  # Require a new directory, never merge a staging tree.
        write_files(args.destdir.absolute(), generated)
        print(f"Staged {len(generated)} files in {args.destdir}")
    else:
        print("All five profiles passed structural checks. No files changed.")
        print("Country and server availability still need a live connection check.")
    for name in generated:
        print("/" + name)


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as error:
        sys.exit(str(error))
