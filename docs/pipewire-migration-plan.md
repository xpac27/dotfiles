# PipeWire Migration Plan

Date audited: 2026-04-27

Host context:

- Arch Linux laptop on Wayland/Hyprland.
- Current audio stack is a hybrid: PipeWire is running, but PulseAudio is still the active sound server.
- JACK2 is installed for guitar/audio work.

## Goal

Replace the PulseAudio server and JACK server with PipeWire equivalents:

- PulseAudio server replacement: `pipewire-pulse`
- JACK server replacement: `pipewire-jack`
- ALSA integration: `pipewire-alsa`
- PipeWire session manager: `wireplumber`

This keeps compatibility with applications that speak PulseAudio or JACK protocols, but the server doing the routing is PipeWire.

## Current Findings

Running user services:

- `pipewire.service`
- `pipewire-media-session.service`
- `pulseaudio.service`

Enabled user sockets/services:

- `pipewire.socket`
- `pipewire-media-session.service`
- `pulseaudio.socket`
- `pulseaudio.service`

Current Pulse server:

```text
Server Name: pulseaudio
Default Sink: alsa_output.pci-0000_00_1f.3.analog-stereo
Default Source: alsa_input.pci-0000_00_1f.3.analog-stereo
```

Installed legacy packages:

- `pulseaudio`
- `pulseaudio-alsa`
- `pulseaudio-bluetooth`
- `pulseaudio-jack`
- `jack2`
- `lib32-jack2`
- `pipewire-media-session`

Installed modern base packages:

- `pipewire`
- `pipewire-audio`
- `lib32-pipewire`

Missing migration packages:

- `wireplumber`
- `pipewire-pulse`
- `pipewire-jack`
- `pipewire-alsa`
- `lib32-pipewire-jack`

Low-latency readiness:

- User `vinz` is in `audio` and `realtime`.
- `rtkit` is installed.
- `realtime-privileges` is installed.

Relevant JACK/audio applications installed:

- `guitarix`
- `qtractor`
- `qjackctl`
- `lsp-plugins-standalone`
- `lsp-plugins-lv2`

## Important Answer: Are We Keeping PulseAudio?

No, not the PulseAudio server.

The migration removes/replaces the `pulseaudio` package and disables `pulseaudio.service` plus `pulseaudio.socket`.

What stays is PulseAudio protocol compatibility through `pipewire-pulse`. Many applications still connect through the PulseAudio API/socket, so `pipewire-pulse` provides that interface while PipeWire handles the actual audio graph.

Expected after migration:

```text
pactl info
Server Name: PulseAudio (on PipeWire ...)
```

That output is normal. It does not mean the old PulseAudio daemon is still running.

Also expect `libpulse` to remain installed because many desktop apps link against it. That is fine; `libpulse` is a client library, not the PulseAudio server.

## Migration Steps

### 1. Update the system

```sh
sudo pacman -Syu
```

### 2. Install the PipeWire replacement stack

```sh
sudo pacman -S wireplumber pipewire-pulse pipewire-jack pipewire-alsa lib32-pipewire-jack
```

Expected package conflicts/replacements:

- `wireplumber` conflicts with/replaces `pipewire-media-session`.
- `pipewire-pulse` conflicts with/replaces `pulseaudio`.
- `pipewire-jack` conflicts with/replaces `jack2`.
- `lib32-pipewire-jack` conflicts with/replaces `lib32-jack2`.

Accept those replacements if pacman asks.

### 3. Remove leftover PulseAudio add-ons if needed

If pacman does not remove these automatically, remove them after installing the PipeWire stack:

```sh
sudo pacman -Rns pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack
```

### 4. Enable the PipeWire user services

```sh
systemctl --user daemon-reload
systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service
```

### 5. Disable old user services

These may already be gone after package replacement, but run the commands if the units still exist:

```sh
systemctl --user disable --now pulseaudio.service pulseaudio.socket
systemctl --user disable --now pipewire-media-session.service
```

### 6. Reboot or log out/in

Recommended:

```sh
systemctl reboot
```

## Verification

After reboot:

```sh
pactl info
wpctl status
pw-cli info 0
systemctl --user --no-pager status pipewire pipewire-pulse wireplumber
```

Good signs:

- `pactl info` reports PulseAudio running on PipeWire.
- `wpctl status` shows audio devices, sinks, sources, and streams.
- `wireplumber.service` is active.
- `pulseaudio.service` is absent or inactive.
- `pipewire-media-session.service` is absent or inactive.

Check no old servers are running:

```sh
ps -eo pid,comm,args | rg '(pulseaudio|jackd|jackdbus|pipewire|wireplumber)'
```

Expected:

- `pipewire`
- `pipewire-pulse`
- `wireplumber`

Not expected:

- `pulseaudio`
- `jackd`
- `jackdbus`

## Guitar/JACK Workflow

Do not start a separate JACK server with QjackCtl after migration. PipeWire will provide the JACK server compatibility.

For JACK applications:

```sh
pw-jack guitarix
```

For explicit low latency:

```sh
PIPEWIRE_LATENCY="128/48000" guitarix
```

If 128 frames causes xruns, try:

```sh
PIPEWIRE_LATENCY="256/48000" guitarix
```

Recommended graph/patchbay tools for PipeWire:

```sh
sudo pacman -S qpwgraph
```

Alternative:

```sh
sudo pacman -S helvum
```

`qjackctl` can remain installed for inspection if useful, but it should not own server start/stop behavior anymore.

## Optional Dotfiles Follow-Up

Do not add PipeWire config immediately. First migrate using package defaults.

After the migration is stable, consider adding stowed config for:

- WirePlumber device rules.
- PipeWire low-latency defaults.
- Fish aliases/functions:
  - `wpctl status`
  - `wpctl set-volume`
  - `pw-jack guitarix`
- A guitar launcher with a chosen `PIPEWIRE_LATENCY`.

## Rollback Notes

If the migration fails and you need to return to the old stack:

```sh
sudo pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack jack2 lib32-jack2 pipewire-media-session
systemctl --user daemon-reload
systemctl --user enable --now pulseaudio.socket pulseaudio.service
systemctl --user enable --now pipewire.socket pipewire-media-session.service
systemctl --user disable --now pipewire-pulse.socket wireplumber.service
```

Then reboot.
