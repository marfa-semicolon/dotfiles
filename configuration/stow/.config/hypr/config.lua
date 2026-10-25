hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 3,
    col = {
      active_border = "rgb(F7768E)",
      inactive_border = "rgba(595959aa)"
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle"
  },
  group = {
    col = {
      border_active = "rgb(F7768E)"
    },
    groupbar = {
      font_size = 12,
      font_weight_active = "semibold",
      font_weight_inactive = "semibold",
      col = {
        active = "rgb(9ECE6A)",
        inactive = "rgb(414868)"
      }
    }
  },
  decoration = {
    rounding = 1,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)"
    },
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696
    }
  },
  animations = {
    enabled = true
  },
  dwindle = {
    -- pseudotile removed in 0.55 (was already non-functional)
    preserve_split = true
  },
  master = {
    new_status = "master"
  },
  scrolling = {},
  misc = {
    font_family = "JetBrainsMonoNl NF",
    force_default_wallpaper = -1,
    disable_hyprland_logo = true
  },
  input = {
    kb_layout = "us,ara",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:alt_caps_toggle",
    kb_rules = "",
    repeat_rate = 30,
    repeat_delay = 200,
    accel_profile = "flat",
    follow_mouse = 0,
    sensitivity = 0.6,
    float_switch_override_focus = 0,
    touchpad = {
      natural_scroll = true
    },
    touchdevice = {
      enabled = true,
      output = "current"
    }
  },
  debug = {
    disable_logs = false
  }
})
