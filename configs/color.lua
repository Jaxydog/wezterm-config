local utility = require('utility')

local module = {}

---Applies configuration settings to the given base.
---
---@param base_config table The base configuration.
function module.apply(base_config)
    local scheme = utility.color.preferred_scheme()
    local colors = utility.color.preferred_colors(scheme)

    utility.merge_into(base_config, {
        color_scheme = 'Catppuccin ' .. (utility.color.prefers_dark_colors(scheme) and 'Mocha' or 'Latte'),
        colors = {
            tab_bar = {
                active_tab = { bg_color = colors.base, fg_color = colors.overlay2 },

                inactive_tab = { bg_color = colors.mantle, fg_color = colors.overlay1 },
                inactive_tab_edge = colors.overlay0,
                inactive_tab_hover = { bg_color = colors.base, fg_color = colors.overlay2 },

                new_tab = { bg_color = colors.mantle, fg_color = colors.overlay1 },
                new_tab_hover = { bg_color = colors.base, fg_color = colors.overlay2 },
            },
        },

        window_background_opacity = 0.9,
        text_background_opacity = 0.9,

        window_frame = {
            active_titlebar_bg = colors.crust,
            inactive_titlebar_bg = colors.crust,
        },
    })
end

return module
