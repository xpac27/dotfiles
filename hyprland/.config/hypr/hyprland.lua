-- Hyprland Lua configuration.
-- Keep hyprland.conf as a rollback copy until this config has been exercised
-- in a live session.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "auto", scale = 1 })
hl.monitor({ output = "DP-1", mode = "highres", position = "auto-center-left", scale = 1 })
hl.monitor({
    output = "desc:Acer Technologies ACER P1303PW JCT010145901",
    mode = "1280x800",
    position = "auto-center-left",
    scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "alacritty"
local spotify = "spotify"
local firefox = "firefox"
local signal = "signal-desktop"
local zoom = "zoom"
local parsec = "parsecd"
local screenshot = 'grim -g "$(slurp)" "$(xdg-user-dir DESKTOP)"/"$(date +%F_%T.png)"'

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("wlsunset -l 59.3 -l 18.0") -- Stockholm, Sweden
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

hl.config({
    ecosystem = {
        enforce_permissions = false,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(ffcc33ee)", "rgba(ff9900ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "master",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 10,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = false, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = false, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "default", style = "slidefadevert" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
        mfact = 0.60,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:ralt",
        kb_rules = "",
        repeat_rate = 25,
        repeat_delay = 170,
        follow_mouse = 1,
        follow_mouse_threshold = 3,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            drag_lock = false,
        },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())

hl.bind("Print", hl.dsp.exec_cmd(screenshot))
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd(screenshot))
hl.bind("ALT + SHIFT + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + SHIFT + E", hl.dsp.exec_cmd(signal))
hl.bind("ALT + SHIFT + M", hl.dsp.exec_cmd(spotify))
hl.bind("ALT + SHIFT + F", hl.dsp.exec_cmd(firefox))
hl.bind("ALT + SHIFT + Z", hl.dsp.exec_cmd(zoom))
hl.bind("ALT + SHIFT + P", hl.dsp.exec_cmd(parsec))

hl.bind("ALT + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind("ALT + j", hl.dsp.layout("cyclenext"))
hl.bind("ALT + h", hl.dsp.window.resize({ x = -80, y = 0, relative = true }))
hl.bind("ALT + l", hl.dsp.window.resize({ x = 80, y = 0, relative = true }))
hl.bind("ALT + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind("ALT + SHIFT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind("ALT + SHIFT + j", hl.dsp.layout("swapwithmaster auto"))

hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })

for workspace = 1, 9 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "eDP-1",
        default = workspace == 1,
        persistent = workspace == 1,
    })
end

for workspace = 11, 19 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "DP-1",
        default = workspace == 11,
        persistent = workspace == 11,
    })
end

hl.bind("ALT + Comma", hl.dsp.focus({ monitor = "+1" }))
hl.bind("ALT + SHIFT + Comma", hl.dsp.window.move({ monitor = "+1" }))

local function workspace_on_active_monitor(workspace)
    local monitor = hl.get_active_monitor()

    if monitor and monitor.name == "DP-1" then
        return workspace + 10
    end

    return workspace
end

for index = 1, 9 do
    local workspace = index

    hl.bind("ALT + " .. workspace, function()
        hl.dispatch(hl.dsp.focus({ workspace = workspace_on_active_monitor(workspace) }))
    end)
    hl.bind("ALT + SHIFT + " .. workspace, function()
        hl.dispatch(hl.dsp.window.move({
            workspace = workspace_on_active_monitor(workspace),
            follow = false,
        }))
    end)
end

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n0 set 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n0 set 10%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, repeating = true })

hl.bind("ALT + SHIFT + down", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("ALT + SHIFT + up", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "float-zoom-popups",
    match = {
        class = "^(zoom)$",
        initial_title = "negative:^(Zoom Workplace|Meeting)$",
    },
    float = true,
})

--------------------------
---- DROP DOWN TERMINAL ----
--------------------------

hl.workspace_rule({
    workspace = "special:dropdown",
    border_size = 3,
    gaps_out = 80,
    on_created_empty = "alacritty --class dropdown-term",
})

hl.bind("ALT + Backspace", hl.dsp.workspace.toggle_special("dropdown"))

hl.window_rule({
    name = "dropdown-terminal",
    match = { class = "^(dropdown-term)$" },
    float = true,
    size = "(monitor_w*0.70) (monitor_h*0.40)",
    move = "(monitor_w*0.15) (monitor_h*0.55)",
})
