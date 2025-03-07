local wezterm = require('wezterm')

local configuration = wezterm.config_builder()

require('configs.color').apply(configuration)
require('configs.font').apply(configuration)
require('configs.keybind').apply(configuration)
require('configs.launch').apply(configuration)

require('utility').merge_into(configuration, {
    window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
    window_close_confirmation = 'NeverPrompt',
})

return configuration
