local module = {}

---@alias utility.color.Scheme 'Light' | 'Dark' | 'LightHighContrast' | 'DarkHighContrast' A color scheme.

---@class utility.color.CatppuccinColors A set of Catppuccin colors.
---
---@field rosewater string
---@field flamingo string
---@field pink string
---@field mauve string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field teal string
---@field sky string
---@field sapphire string
---@field blue string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string

---Extracted from [catppuccin/lua](https://github.com/catppuccin/lua).
module.catppuccin = {
    ---@type utility.color.CatppuccinColors
    latte = {
        rosewater = '#dc8a78',
        flamingo = '#dd7878',
        pink = '#ea76cb',
        mauve = '#8839ef',
        red = '#d20f39',
        maroon = '#e64553',
        peach = '#fe640b',
        yellow = '#df8e1d',
        green = '#40a02b',
        teal = '#179299',
        sky = '#04a5e5',
        sapphire = '#209fb5',
        blue = '#1e66f5',
        lavender = '#7287fd',
        text = '#4c4f69',
        subtext1 = '#5c5f77',
        subtext0 = '#6c6f85',
        overlay2 = '#7c7f93',
        overlay1 = '#8c8fa1',
        overlay0 = '#9ca0b0',
        surface2 = '#acb0be',
        surface1 = '#bcc0cc',
        surface0 = '#ccd0da',
        base = '#eff1f5',
        mantle = '#e6e9ef',
        crust = '#dce0e8',
    },
    ---@type utility.color.CatppuccinColors
    mocha = {
        rosewater = '#f5e0dc',
        flamingo = '#f2cdcd',
        pink = '#f5c2e7',
        mauve = '#cba6f7',
        red = '#f38ba8',
        maroon = '#eba0ac',
        peach = '#fab387',
        yellow = '#f9e2af',
        green = '#a6e3a1',
        teal = '#94e2d5',
        sky = '#89dceb',
        sapphire = '#74c7ec',
        blue = '#89b4fa',
        lavender = '#b4befe',
        text = '#cdd6f4',
        subtext1 = '#bac2de',
        subtext0 = '#a6adc8',
        overlay2 = '#9399b2',
        overlay1 = '#7f849c',
        overlay0 = '#6c7086',
        surface2 = '#585b70',
        surface1 = '#45475a',
        surface0 = '#313244',
        base = '#1e1e2e',
        mantle = '#181825',
        crust = '#11111b',
    },
}

---Returns the terminal's preferred color scheme.
---
---@return utility.color.Scheme scheme The preferred color scheme.
function module.preferred_scheme()
    local wezterm = require('wezterm')

    if wezterm.gui and wezterm.gui.get_appearance then
        return wezterm.gui.get_appearance()
    else
        return 'Dark'
    end
end

---Returns 'true' if the preferred color scheme uses high contrast colors.
---
---@param scheme ?utility.color.Scheme The preferred color scheme.
---
---@return boolean prefers Whether the terminal prefers high contrast.
function module.prefers_high_contrast(scheme)
    scheme = scheme or module.preferred_scheme()

    return scheme:find('HighContrast') ~= nil
end

---Returns 'true' if the preferred color scheme uses light colors.
---
---@param scheme ?utility.color.Scheme The preferred color scheme.
---
---@return boolean prefers Whether the terminal prefers light colors.
function module.prefers_light_colors(scheme)
    scheme = scheme or module.preferred_scheme()

    return scheme:find('Light') ~= nil
end

---Returns 'true' if the preferred color scheme uses dark colors.
---
---@param scheme ?utility.color.Scheme The preferred color scheme.
---
---@return boolean prefers Whether the terminal prefers dark colors.
function module.prefers_dark_colors(scheme)
    scheme = scheme or module.preferred_scheme()

    return scheme:find('Dark') ~= nil
end

---Returns a set of colors determined by the preferred color scheme.
---
---@param scheme ?utility.color.Scheme The preferred color scheme.
---
---@return utility.color.CatppuccinColors colors The preferred colors.
function module.preferred_colors(scheme)
    scheme = scheme or module.preferred_scheme()

    if module.prefers_dark_colors(scheme) then
        return module.catppuccin.mocha
    else
        return module.catppuccin.latte
    end
end

return module
