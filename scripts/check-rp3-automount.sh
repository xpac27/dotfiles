#!/bin/sh
# Syntax/dependency check only: no mounts, network access, or system changes.
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
unit_source="$repo_dir/systemd-system/etc/systemd/system"
check_dir=$(mktemp -d /tmp/rp3-unit-check.XXXXXX)
trap 'rm -rf -- "$check_dir"' EXIT HUP INT TERM

# homed's home-vinz.mount exists only at runtime. Supply a stand-in solely
# for the offline verifier; this file is never installed or activated.
cat > "$check_dir/home-vinz.mount" <<'EOF'
[Mount]
What=/dev/mapper/home-vinz
Where=/home/vinz
Type=btrfs
EOF

sh -n "$repo_dir/systemd-system/usr/local/libexec/rp3-ssh-as-vinz"
SYSTEMD_UNIT_PATH="$unit_source:$check_dir:" systemd-analyze verify \
    "$unit_source/home-vinz-mnt-ssh-Documents.automount" \
    "$unit_source/home-vinz-mnt-ssh-Documents.mount" \
    "$unit_source/home-vinz-mnt-ssh-Videos.automount" \
    "$unit_source/home-vinz-mnt-ssh-Videos.mount"
