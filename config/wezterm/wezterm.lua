local wezterm = require 'wezterm'

-- https://wezfurlong.org/wezterm/config/lua/general.html
local config = {
    audible_bell = "Disabled",
    color_scheme = "Solarized Darcula",

    enable_scroll_bar = true,
    exit_behavior = "Close",

    font = wezterm.font("SauceCodePro Nerd Font Mono", {weight="Regular"}),
    font_size = 15,

    initial_rows = 40,
    initial_cols = 160
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.font = wezterm.font("SauceCodePro NF")
end

return config
