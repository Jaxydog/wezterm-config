local wezterm = require('wezterm')
local utility = require('utility')

local module = {}

---Applies configuration settings to the given base.
---
---@param base_config table The base configuration.
function module.apply(base_config)
    utility.merge_into(base_config, {
        font = wezterm.font_with_fallback({ 'Fira Code', 'Fira Code NFM', 'Segoe UI Emoji' }),
        font_size = 11.0,

        window_frame = {
            font = wezterm.font({ family = 'Fira Mono', weight = 'Bold' }),
            font_size = 9.0,
        },
    })
end

return module
