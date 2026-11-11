"""Offline checks: no VPN, admin command, credentials, or network access."""

import configparser
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location("installer", REPO / "scripts/install-nordvpn.py")
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)
PROFILE = """client
pull
dev tun
proto udp
remote 192.0.2.1 53
remote-cert-tls server
verify-x509-name CN=se1.nordvpn.com
auth-user-pass
tls-version-min 1.2
<ca>
TEST CERTIFICATE PLACEHOLDER
</ca>
<tls-crypt>
TEST KEY PLACEHOLDER
</tls-crypt>
"""


class NordVPNTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.profiles = self.root / "profiles"
        self.profiles.mkdir()
        for country in installer.COUNTRIES:
            (self.profiles / f"{country}1.nordvpn.com.udp_2.6.ovpn").write_text(PROFILE)

    def generated(self):
        return installer.files(self.profiles, "vinz")

    def test_profiles_preserve_crypto_and_use_one_shared_auth_file(self):
        generated = self.generated()
        for country in installer.COUNTRIES:
            text, mode = generated[f"etc/openvpn/client/nordvpn-{country}.conf"]
            self.assertIn("<tls-crypt>\nTEST KEY PLACEHOLDER\n</tls-crypt>", text)
            self.assertIn("tls-version-min 1.2\n", text)
            self.assertEqual(text.count("auth-user-pass "), 1)
            self.assertNotIn("\nauth-user-pass\n", text)
            self.assertIn("auth-user-pass /etc/openvpn/client/nordvpn.auth", text)
            self.assertIn("redirect-gateway def1 ipv6", text)
            self.assertIn("block-ipv6", text)
            self.assertIn("dns-updown force", text)
            self.assertEqual(mode, 0o600)
        self.assertFalse(any(name.endswith(".auth") for name in generated))

    def test_missing_or_ambiguous_country_refuses_whole_batch(self):
        source = self.profiles / "se1.nordvpn.com.udp_2.6.ovpn"
        source.unlink()
        with self.assertRaises(ValueError):
            self.generated()
        source.write_text(PROFILE)
        (self.profiles / "se2.nordvpn.com.udp.ovpn").write_text(PROFILE)
        with self.assertRaises(ValueError):
            self.generated()
        (self.profiles / "se.ovpn").write_text(PROFILE)
        self.generated()  # Explicit short filename resolves ambiguity.

    def test_unexpected_root_actions_and_invalid_profiles_are_rejected(self):
        source = self.profiles / "se1.nordvpn.com.udp_2.6.ovpn"
        variants = [
            PROFILE + "up /tmp/script\n",
            PROFILE + "plugin /tmp/plugin.so\n",
            PROFILE + "config /tmp/other.conf\n",
            PROFILE + "log /tmp/output\n",
            PROFILE + "<auth-user-pass>\nusername\npassword\n</auth-user-pass>\n",
            PROFILE.replace("proto udp", "proto tcp-client"),
            PROFILE.replace("remote-cert-tls server", "remote-cert-tls client"),
            PROFILE.replace("</tls-crypt>", ""),
        ]
        for content in variants:
            with self.subTest(content=content[-60:]):
                source.write_text(content)
                with self.assertRaises(ValueError):
                    self.generated()

    def test_conflicts_have_acyclic_stop_before_start_ordering(self):
        generated = self.generated()
        units = [f"openvpn-client@nordvpn-{c}.service" for c in installer.COUNTRIES]
        for index, unit in enumerate(units):
            config = configparser.ConfigParser()
            config.read_string(generated[f"etc/systemd/system/{unit}.d/50-nordvpn.conf"][0])
            self.assertEqual(set(config["Unit"]["Conflicts"].split()), set(units) - {unit})
            dependencies = set(config["Unit"]["After"].split()) - {"systemd-resolved.service"}
            self.assertEqual(dependencies, set(units[index + 1:]))
            self.assertEqual(config["Service"]["TimeoutStartSec"], "60s")

    def test_staging_is_repeatable_and_preserves_credentials(self):
        destination = self.root / "stage"
        destination.mkdir()
        generated = self.generated()
        installer.write_files(destination, generated)
        credentials = destination / "etc/openvpn/client/nordvpn.auth"
        credentials.write_text("synthetic-test-secret\n")
        installer.write_files(destination, generated)
        self.assertEqual(credentials.read_text(), "synthetic-test-secret\n")
        for name, (text, mode) in generated.items():
            self.assertEqual((destination / name).read_text(), text)
            self.assertEqual((destination / name).stat().st_mode & 0o777, mode)

    def test_unmanaged_file_and_symlink_refuse_without_partial_install(self):
        destination = self.root / "stage"
        target = destination / "etc/polkit-1/rules.d/49-nordvpn.rules"
        target.parent.mkdir(parents=True)
        target.touch()
        with self.assertRaises(ValueError):
            installer.write_files(destination, self.generated())
        self.assertFalse((destination / "etc/openvpn").exists())
        target.unlink()
        target.symlink_to(self.root / "unrelated")
        with self.assertRaises(ValueError):
            installer.write_files(destination, self.generated())
        self.assertFalse((self.root / "unrelated").exists())

    def test_polkit_grants_only_local_active_user_start_stop_for_five_units(self):
        rule = self.generated()["etc/polkit-1/rules.d/49-nordvpn.rules"][0]
        script = """
const assert = require('assert');
let callback;
global.polkit = {addRule: f => callback = f, Result: {YES: 'yes'}};
""" + rule + """
function check(changes = {}, identity = {}) {
    const data = {id: 'org.freedesktop.systemd1.manage-units',
        unit: 'openvpn-client@nordvpn-se.service', verb: 'start', ...changes};
    return callback({id: data.id, lookup: key => data[key]},
        {user: 'vinz', local: true, active: true, ...identity});
}
for (const country of ['se', 'fr', 'uk', 'us', 'pl']) {
    for (const verb of ['start', 'stop']) {
        assert.equal(check({unit: `openvpn-client@nordvpn-${country}.service`, verb}), 'yes');
    }
}
for (const verb of ['restart', 'reload', 'enable', 'set-property']) assert.equal(check({verb}), undefined);
for (const unit of ['sshd.service', 'openvpn-client@other.service', 'openvpn-client@nordvpn-se.service.evil'])
    assert.equal(check({unit}), undefined);
assert.equal(check({id: 'org.freedesktop.systemd1.manage-unit-files'}), undefined);
assert.equal(check({}, {user: 'someone'}), undefined);
assert.equal(check({}, {active: false}), undefined);
assert.equal(check({}, {local: false}), undefined);
"""
        subprocess.run(["node", "-e", script], check=True, capture_output=True, text=True)

    def test_fish_commands_and_failure_propagation_without_real_systemctl(self):
        mock = self.root / "systemctl"
        mock.write_text("#!/usr/bin/env python3\nimport json, os, sys\nprint(json.dumps(sys.argv[1:]))\nsys.exit(int(os.environ.get('MOCK_EXIT', '0')))\n")
        mock.chmod(0o755)
        environment = dict(os.environ, PATH=str(self.root) + ":" + os.environ["PATH"])
        function = REPO / "fish/.config/fish/functions/vpn.fish"

        def run(arguments, failure="0"):
            return subprocess.run(["fish", "--no-config", "-c", f"source {function}; vpn {arguments}"],
                                  env=dict(environment, MOCK_EXIT=failure), text=True, capture_output=True)

        for arguments, country in [("", "se"), ("fr", "fr"), ("pl", "pl")]:
            result = run(arguments)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(json.loads(result.stdout), ["start", f"openvpn-client@nordvpn-{country}.service"])
        self.assertEqual(run("uk", "7").returncode, 7)
        self.assertEqual(run("off", "8").returncode, 8)
        off = json.loads(run("off").stdout)
        self.assertEqual(off, ["stop"] + [f"openvpn-client@nordvpn-{c}.service" for c in installer.COUNTRIES])
        self.assertEqual(json.loads(run("status").stdout)[:4], ["--no-pager", "--plain", "list-units", "--all"])
        for invalid in ["xx", "se fr", "--install"]:
            self.assertEqual(run(invalid).returncode, 2)
            self.assertEqual(run(invalid).stdout, "")


if __name__ == "__main__":
    unittest.main()
