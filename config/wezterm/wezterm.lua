local wezterm = require 'wezterm'

-- https://wezfurlong.org/wezterm/config/lua/general.html
return {
    audible_bell = "Disabled",
    color_scheme = "Solarized Darcula",
    enable_scroll_bar = true,
    font = wezterm.font_with_fallback({
            "SauceCodePro Nerd Font Mono",
            "SauceCodePro Nerd Font Mono Windows Compatible"
        }),
}
