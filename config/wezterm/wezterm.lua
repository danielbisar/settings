local wezterm = require 'wezterm'

-- https://wezfurlong.org/wezterm/config/lua/general.html
local config = {
    audible_bell = "Disabled",
    color_scheme = "Solarized Darcula",
    enable_scroll_bar = true,
    font = wezterm.font("SauceCodePro Nerd Font Mono"),
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.font = wezterm.font("SauceCodePro NF")
end

return config
