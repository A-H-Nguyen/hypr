--[[ MONITORS  ]]

hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@144",
    position = "auto",
    scale    = 1,
})

-- monitor=,preferred,auto,auto

--[[ MY PROGRAMS  ]]

local terminal = "kitty"
local fileManager = "thunar"
local menu = "pidof rofi || rofi -show drun"
local screenshot = "grim -g \"$(slurp)\" \"$HOME/Pictures/Screenshots/$(date '+%y-%m-%d_%H-%M-%S').png\""

--[[ AUTOSTART  ]]

hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar")
  hl.exec_cmd("dunst")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("systemctl  --user start hyprpolkitagent")
  hl.exec_cmd("nm-applet")
-- Since we can set this per screen, should I worry about stretching the wallpaper for larger displays on startup?
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("awww img \"$HOME/Pictures/wallpapers/animated/shinobu-dark-butterfly-kimetsu-no-yaiba-moewalls-com.gif\"")
  hl.exec_cmd(terminal)
  hl.exec_cmd("discord")
  hl.exec_cmd("spotify-launcher")
  hl.exec_cmd("steam")
end)

--[[ ENVIRONMENT VARIABLES  ]]

-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE","24")
hl.env("HYPRCURSOR_SIZE","24")

--[[ PERMISSIONS  ]]

-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
  ecosystem = {
    enforce_permissions = true,
  },
})

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

--[[ LOOK AND FEEL  ]]

-- source = ~/.config/hypr/myColors.conf

-- Refer to https://wiki.hypr.land/Configuring/Variables/
-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
  general = {
      gaps_in = 3,
      gaps_out = 6,

      border_size = 3,

      -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
      col = {
        active_border   = { colors = {"rgba(dc39e499)", "rgba(db78d3ff)"}, angle = 45 },
        inactive_border = { colors = {"rgba(0c0015ff)", "rgba(dc39e444)"}, angle = 45 },
      },

      -- Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = true,

      -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
  },

  -- https://wiki.hypr.land/Configuring/Variables/#decoration
  decoration = {
      rounding = 15,
      rounding_power = 2,

      -- Change transparency of focused and unfocused windows
      active_opacity = 1.0,
      inactive_opacity = 0.85,

      shadow = {
          enabled = true,
          range = 4,
          render_power = 3,
          color = 0x1a1a1aee,
      },

      -- https://wiki.hypr.land/Configuring/Variables/#blur
      blur = {
          enabled = false,
          size = 3,
          passes = 1,
          vibrancy = 0.1696,
      },
  },

  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- workspace = w[tv1], gapsout:0, gapsin:0
-- workspace = f[1], gapsout:0, gapsin:0
-- windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
-- windowrule = rounding 0, floating:0, onworkspace:w[tv1]
-- windowrule = bordersize 0, floating:0, onworkspace:f[1]
-- windowrule = rounding 0, floating:0, onworkspace:f[1]

hl.config({
  dwindle = {
      force_split                  = 0,
      preserve_split               = true,
      smart_split                  = true,
      smart_resizing               = true,
      permanent_direction_override = false,
      special_scale_factor         = 1,
      split_width_multiplier       = 1.0,
      use_active_for_splits        = true,
      default_split_ratio          = 1.0,
      split_bias                   = 0,
      precise_mouse_move           = false,
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
  misc = {
    force_default_wallpaper = 1,
    disable_hyprland_logo = true ,
    font_family = "Noto Sans",
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
  },
})


--[[ INPUT  ]]

-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
        natural_scroll = true,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Variables/#gestures
-- gestures {
--     workspace_swipe = true
-- }

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


--[[ KEYBINDINGS  ]]

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
-- bind = $mainMod, Q, exec, $terminal
-- bind = $mainMod, D, killactive,
-- bind = $mainMod, M, exit,
-- bind = $mainMod, E, exec, $fileManager
-- bind = $mainMod, V, togglefloating,
-- bind = $mainMod, R, exec, $menu
-- bind = $mainMod, S, exec, $screenshot
-- bind = $mainMod SHIFT, L, exec, hyprlock
-- bind = $mainMod, h, movefocus, l
-- bind = $mainMod, l, movefocus, r
-- bind = $mainMod, k, movefocus, u
-- bind = $mainMod, j, movefocus, d

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + D", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })    -- Super + LMB: Move a window by dragging more than 10px.
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- on = CLOSING the laptop lid
-- bindl = , switch:on:Lid Switch, exec, $HOME/.my-scripts/monitors/clamshell.sh close

-- off = OPENING the laptop lid
-- bindl = , switch:off:Lid Switch, exec, $HOME/.my-scripts/monitors/clamshell.sh open

--[[ WINDOWS AND WORKSPACES  ]]

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Fix firefox's popup windows whenever I try to download something by forcing
-- all firefox windows to be tiled
hl.window_rule({
  name = "windowrule-3",
  tile = true,
  match = {
    class = "^(firefox)$"
  },
})

-- Bind apps to certain workspaces such that they are automatically placed there when they start
hl.window_rule({
  name = "windowrule-4",
  workspace = "2",
  match = {
    class = "^(firefox)$"
  },
})

hl.window_rule({
  name = "windowrule-5",
  workspace = "3",
  match = {
    class = "^(thunderbird)$"
  },
})

hl.window_rule({
  name = "windowrule-6",
  workspace = "4",
  match = {
    class = "^(steam)$"
  },
})

hl.window_rule({
  name = "windowrule-7",
  workspace = "6",
  match = {
    class = "^(discord)$"
  },
})

hl.window_rule({
  name = "windowrule-8",
  workspace = "7",
  match = {
    class = "^(Slack)$"
  },
})

hl.window_rule({
  name = "windowrule-9",
  workspace = "8",
  match = {
    class = "^(Spotify)$"
  },
})
