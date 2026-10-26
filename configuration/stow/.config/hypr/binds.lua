local mainMod = "SUPER"
local terminal = "kitty"

-- Custom binds
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("rofi -show calc"))
hl.bind(
    mainMod .. " + A",
    hl.dsp.exec_cmd(
        "nu -c 'curl --noproxy 127.0.0.1 -H \"Content-Type: application/json\" -H $\"@($env.HOME)/.sp-api-header\" --data ({\"title\": (rofi -dmenu -theme-str \"listview { enabled: false;}\")}|to json) http://127.0.0.1:3876/tasks'"
    )
)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/ocr.nu"))

-- Special workspace
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.toggle_special("special"))
hl.bind(mainMod .. " + SHIFT + comma", function ()
    local active = hl.get_active_window()
    local ws = hl.get_active_workspace() -- special workspace is excluded from this function

    if active == nil or active.workspace == nil or ws == nil then
        return
    end

    if active.workspace.name == "special:special" then
        local special_ws = hl.get_active_special_workspace()
        if special_ws == nil then return end
        local close = special_ws.windows == 1
        hl.dispatch(hl.dsp.window.move({ workspace = ws.id, follow = close }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "special:special", follow = false }))
    end
end)
-- Media keys (locked = works on lockscreen)
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- Volume (repeating)
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), {
    repeating = true,
    locked = true
})
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), {
    repeating = true,
    locked = true
})
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Brightness
hl.bind(mainMod .. " + bracketright", hl.dsp.exec_cmd("light -A 5"))
hl.bind(mainMod .. " + bracketleft", hl.dsp.exec_cmd("light -U 5"))
-- Window swapping (tiled) — note: these share keys with moveactive below;
-- Hyprland will use swapwindow for tiled windows and moveactive only applies
-- when the window is floating. They are kept separate here as in the original.
local function layout_bind(bind_table)
    return function ()
        local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

        if not workspace then
            return
        end

        local layout = workspace.tiled_layout

        if bind_table[layout] then
            hl.dispatch(bind_table[layout])
        end
    end
end
hl.bind(
    mainMod .. " + SHIFT + H",
    layout_bind({
        dwindle = function ()
            local active = hl.get_active_window()
            if active == nil then return end;

            if active.floating then
                return
            end
            hl.dispatch(hl.dsp.window.swap({ direction = "left" }))
        end,
        scrolling = hl.dsp.layout("swapcol l")
    })
)
hl.bind(
    mainMod .. " + SHIFT + L",
    layout_bind({
        dwindle = function ()
            local active = hl.get_active_window()
            if active == nil then return end;

            if active.floating then
                return
            end
            hl.dispatch(hl.dsp.window.swap({ direction = "right" }))
        end,
        scrolling = hl.dsp.layout("swapcol r")
    })
)
hl.bind(mainMod .. " + SHIFT + K", function ()
    local active = hl.get_active_window()
    if active == nil then return end;

    if active.floating then
        return
    end
    hl.dispatch(hl.dsp.window.swap({ direction = "up" }))
end)
hl.bind(mainMod .. " + SHIFT + J", function ()
    local active = hl.get_active_window()
    if active == nil then return end;

    if active.floating then
        return
    end
    hl.dispatch(hl.dsp.window.swap({ direction = "down" }))
end)

-- Move floating windows (repeating)
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ x = 30, y = 0, relative = true }), {
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ x = -30, y = 0, relative = true }), {
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ x = 0, y = -30, relative = true }), {
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ x = 0, y = 30, relative = true }), {
    repeating = true
})
-- Mouse simulation
hl.bind(mainMod .. " + M", function ()
    hl.dispatch(hl.dsp.submap("mousemode"))
end)

-- Neru
hl.bind(mainMod .. "+ O", hl.dsp.exec_cmd("neru recursive_grid"))
hl.bind(mainMod .. "+ I", hl.dsp.exec_cmd("neru scroll"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("neru hints"))

hl.define_submap("mousemode", function ()
    -- cursor
    hl.bind("J", hl.dsp.exec_cmd("echo 'mousemove 0 10' | dotoolc"), { repeating = true })
    hl.bind("K", hl.dsp.exec_cmd("echo 'mousemove 0 -10' | dotoolc"), { repeating = true })
    hl.bind("H", hl.dsp.exec_cmd("echo 'mousemove -10 0' | dotoolc"), { repeating = true })
    hl.bind("L", hl.dsp.exec_cmd("echo 'mousemove 10 0' | dotoolc"), { repeating = true })

    -- scroll
    hl.bind("ALT + J", hl.dsp.exec_cmd("echo 'wheel -10' | dotoolc"), { repeating = true })
    hl.bind("ALT + K", hl.dsp.exec_cmd("echo 'wheel 10' | dotoolc"), { repeating = true })
    hl.bind("ALT + H", hl.dsp.exec_cmd("echo 'hwheel -10' | dotoolc"), { repeating = true })
    hl.bind("ALT + L", hl.dsp.exec_cmd("echo 'hwheel 10' | dotoolc"), { repeating = true })
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Resize submap
hl.bind(mainMod .. " + R", function ()
    hl.dispatch(hl.dsp.submap("resize"))
end)

hl.define_submap("resize", function ()
    -- hl.bind("L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
    -- hl.bind("H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
    -- scrolling layout
    hl.bind("L", layout_bind({
        dwindle = hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
        scrolling = function ()
            hl.dsp.layout("colresize +0.1")
            local active = hl.get_active_window()
            if active ~= nil and active.floating then
                hl.dispatch(hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
            else
                hl.dispatch(hl.dsp.layout("colresize +0.1"))
            end
        end
    }), {
        repeating = true
    })
    hl.bind("H", layout_bind({
        dwindle = hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
        scrolling = function ()
            hl.dsp.layout("colresize -0.1")
            local active = hl.get_active_window()
            if active ~= nil and active.floating then
                hl.dispatch(hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
            else
                hl.dispatch(hl.dsp.layout("colresize -0.1"))
            end
        end
    }), {
        repeating = true
    })

    -- Switch to slow-resize submap
    hl.bind(mainMod .. " + S", function ()
        hl.dispatch(hl.dsp.submap("resize-slow"))
    end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

hl.define_submap("resize-slow", function ()
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    -- Switch back to normal resize
    hl.bind(mainMod .. " + R", function ()
        hl.dispatch(hl.dsp.submap("resize"))
    end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Group tab navigation
hl.bind(mainMod .. " + comma", layout_bind({ scrolling = hl.dsp.layout("consume_or_expel prev") }))
hl.bind(mainMod .. " + period", layout_bind({ scrolling = hl.dsp.layout("consume_or_expel next") }))

-- Move window into / out of groups
hl.bind(mainMod .. " + X", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mainMod .. " + SHIFT + ALT + H", hl.dsp.window.move({ into_group = "l" }))
hl.bind(mainMod .. " + SHIFT + ALT + L", hl.dsp.window.move({ into_group = "r" }))
hl.bind(mainMod .. " + SHIFT + ALT + K", hl.dsp.window.move({ into_group = "u" }))
hl.bind(mainMod .. " + SHIFT + ALT + J", hl.dsp.window.move({ into_group = "d" }))

hl.bind(mainMod .. " + ALT + H", hl.dsp.group.prev())
hl.bind(mainMod .. " + ALT + L", hl.dsp.group.next())

-- Core binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- layout msg
hl.bind(mainMod .. " + E", layout_bind({ dwindle = hl.dsp.layout("togglesplit") })) -- dwindle only
-- hl.bind
hl.bind(
    mainMod .. " + W",
    layout_bind({
        dwindle = hl.dsp.layout("swapsplit"),
        scrolling = function ()
            local active = hl.get_active_window()
            local screen = hl.get_active_monitor()

            if active == nil or screen == nil then
                return
            end

            if active.size['x'] / screen.width >= 0.75 then
                hl.dispatch(hl.dsp.layout("colresize 0.5"))
            else
                hl.dispatch(hl.dsp.layout("colresize 1"))
            end
        end
    })
) -- dwindle only TODO

-- Focus with hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 -> key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
-- TODO mouse code
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia / brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
    locked = true,
    repeating = true
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    locked = true,
    repeating = true
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
    locked = true,
    repeating = true
})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
    locked = true,
    repeating = true
})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {
    locked = true,
    repeating = true
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {
    locked = true,
    repeating = true
})

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local function find_window_by_address(addr)
    if addr == nil then return nil end
    for _, win in ipairs(hl.get_windows()) do
        if win.address == addr then
            return win
        end
    end
    return nil -- window no longer exists
end

hl.on("window.active", function (w)
    if w == nil then
        return
    end

    if w.floating then
        hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_floating'"))
    else
        hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_tiling'"))
    end
end)
-- hl.on("window.close", function(w)
-- if w == nil then
-- return
-- end

-- if w.floating then
-- hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_floating'"))
-- else
-- hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_tiling'"))
-- end

-- end)
hl.on("window.update_state", function (w)
    if w == nil then return end

    if w.floating then
        hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_floating'"))
    else
        hl.dispatch(hl.dsp.exec_cmd("nu -c '\"" .. w.address .. "\" | save -f /tmp/hypr/current_tiling'"))
    end
end)
hl.bind(mainMod .. " + SPACE", function ()
    local active = hl.get_active_window()
    if active == nil then return end

    if active.floating then
        local file = io.open("/tmp/hypr/current_tiling", "r")
        if file == nil then return end;
        local content = file:read("*a")
        file:close()
        hl.dispatch(hl.dsp.focus({ window = "address:" .. content }))
        -- hl.notification.create({ text = "Window focused: " .. content, timeout = 2000, icon = "ok" })
        local target = find_window_by_address(content)
        if target ~= nil and not target.floating then
            hl.dispatch(hl.dsp.focus({ window = "address:" .. target.address }))
        else
            local window = hl.get_active_window()
            if not window then return end
            hl.dispatch(hl.dsp.window.cycle_next({
                    floating = not window.floating,
                    tiled = window.floating
                }))
        end
    else
        local file = io.open("/tmp/hypr/current_floating", "r")
        if file == nil then return end;
        local content = file:read("*a")
        file:close()
        hl.dispatch(hl.dsp.focus({ window = "address:" .. content }))
        -- hl.notification.create({ text = "Window focused: " .. content, timeout = 2000, icon = "ok" })
        local target = find_window_by_address(content)
        if target ~= nil and target.floating then
            hl.dispatch(hl.dsp.focus({ window = "address:" .. target.address }))
        else
            local window = hl.get_active_window()
            if not window then return end
            hl.dispatch(hl.dsp.window.cycle_next({
                    floating = not window.floating,
                    tiled = window.floating
                }))
        end
    end
end)

hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ float = "toggle" }))

hl.bind(mainMod .. " + S", function ()
    local layouts = { "scrolling", "dwindle" }
    local workspace = hl.get_active_workspace()
    local next_layout = "dwindle"
    local special = hl.get_active_special_workspace()

    if not workspace then
        return
    end

    if special == nil then
        for i = 1, #layouts do
            if layouts[i] == workspace.tiled_layout then
                local next_layout_idx = (i % #layouts) + 1
                next_layout = layouts[next_layout_idx] or "dwindle"
                -- hl.notification.create({ text = "next layout: " .. next_layout, timeout = 2000, icon = "ok" })
                break
            end
        end
    else
        for i = 1, #layouts do
            if layouts[i] == special.tiled_layout then
                local next_layout_idx = (i % #layouts) + 1
                next_layout = layouts[next_layout_idx] or "dwindle"
                -- hl.notification.create({ text = "next layout: " .. next_layout, timeout = 2000, icon = "ok" })
                break
            end
        end
    end

    if special == nil then
        hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
    else
        hl.workspace_rule({ workspace = special.name, layout = next_layout })
    end
end)
