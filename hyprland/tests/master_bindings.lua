-- Run from the repository root: lua hyprland/tests/master_bindings.lua
-- Exercise the actual config callbacks without changing desktop focus.
local bindings, windows, active, last_layout = {}, {}, nil, nil
local function no_op() end
local function action(kind)
    return function(args) return { kind = kind, args = args } end
end
local noop_dispatchers = setmetatable({}, { __index = function() return no_op end })
hl = setmetatable({
    bind = function(key, callback) bindings[key] = callback end,
    dsp = setmetatable({
        layout = action("layout"),
        focus = action("focus"),
        window = setmetatable({ swap = action("swap") }, { __index = function() return no_op end }),
        workspace = noop_dispatchers,
    }, { __index = function() return no_op end }),
    get_active_window = function() return active end,
    get_workspace_windows = function(workspace)
        local result = {}
        for _, window in ipairs(windows) do
            if window.mapped and window.workspace == workspace then
                result[#result + 1] = window
            end
        end
        return result
    end,
    dispatch = function(dispatch)
        if dispatch.kind == "layout" then
            last_layout = dispatch.args
            return
        end
        local selector = dispatch.args.window or dispatch.args.target
        for _, window in ipairs(windows) do
            if selector == "address:" .. window.address then
                if dispatch.kind == "focus" then
                    active = window
                else
                    active.at, window.at = window.at, active.at
                end
                return
            end
        end
        error("Unknown target: " .. selector)
    end,
}, { __index = function() return no_op end })

dofile("hyprland/.config/hypr/hyprland.lua")

local function window(id, x, y, workspace)
    return {
        address = id, at = { x = x, y = y }, workspace = workspace or 1,
        mapped = true, hidden = false, floating = false, layout = { is_master = true },
    }
end
local function press(key) bindings[key]() end

-- Two masters: repeated focus and swap must keep working in both directions.
local a, b = window("0xa", 0, 0), window("0xb", 0, 100)
windows, active = { b, a }, a
for _ = 1, 3 do
    press("ALT + j"); assert(active == b)
    press("ALT + j"); assert(active == a)
end
for _ = 1, 3 do
    press("ALT + SHIFT + j"); assert(active == a and a.at.y == 100)
    press("ALT + SHIFT + j"); assert(active == a and a.at.y == 0)
end

-- Three masters in a row, ignoring query order, other workspaces and popups.
local c = window("0xc", 200, 0)
a.at, b.at = { x = 0, y = 0 }, { x = 100, y = 0 }
local other, hidden, floating = window("0xd", 0, 0, 2), window("0xe", 0, 0), window("0xf", 0, 0)
hidden.hidden, floating.floating = true, true
hidden.layout, floating.layout = nil, nil
windows, active = { c, other, b, hidden, a, floating }, a
press("ALT + j"); assert(active == b)
press("ALT + j"); assert(active == c)
press("ALT + j"); assert(active == a)
active = c
press("ALT + SHIFT + j"); assert(active == c and c.at.x == 0 and a.at.x == 200)

-- Mixed master/stack layouts retain native commands from either kind of window.
b.layout.is_master = false
for _, focused in ipairs({ a, b }) do
    active, last_layout = focused, nil
    press("ALT + j"); assert(last_layout == "cyclenext")
    press("ALT + SHIFT + j"); assert(last_layout == "swapwithmaster auto")
end
-- Empty, floating and single-window cases delegate safely.
for _, state in ipairs({ {}, { floating }, { a } }) do
    windows, active, last_layout = state, state[1], nil
    press("ALT + j"); assert(last_layout == "cyclenext")
    press("ALT + SHIFT + j"); assert(last_layout == "swapwithmaster auto")
end
print("Master bindings: focus wrapping, repeated swapping and native fallbacks passed")
