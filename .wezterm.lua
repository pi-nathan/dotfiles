local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = 'Dracula'

-- Mouse bindings
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = act.PasteFrom('PrimarySelection')
    }
}

-- Font
config.font = wezterm.font_with_fallback { 'MesloLGS Nerd Font Mono' }
config.font_size = 16.0
config.font_rules = {
    {
        italic = true,
        intensity = 'Bold',
        font = wezterm.font {
            family = 'Operator Mono SSm',
            italic = true,
            weight = 'Medium'
        }
    },
    {
        italic = true,
        intensity = 'Normal',
        font = wezterm.font {
            family = 'Operator Mono SSm',
            italic = true,
            weight = 'Book'
        }
    },
    {
        italic = true,
        intensity = 'Half',
        font = wezterm.font {
            family = 'Operator Mono SSm',
            italic = true,
            weight = 'Light'
        }
    }
}

-- Tab bar
config.window_frame = {
    font = wezterm.font { family = 'Operator Mono SSm', weight = 'Book', italic = true },
    font_size = 14.0
}

-- Window
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- Misc
config.default_cursor_style = 'SteadyBar'
config.cursor_thickness = 1
config.default_cwd = wezterm.home_dir .. '/devel'
config.pane_focus_follows_mouse = true
config.term = 'wezterm'

return config
