local wezterm = require('wezterm')
local utility = require('utility')

local module = {}

---Creates a new keybinding.
---
---@param key string The key to press.
---@param mods string[] A list of modifiers.
---@param action unknown The action to perform.
---
---@return table keybind The keybinding.
function module.create(key, mods, action)
    return { key = key, mods = #mods > 0 and table.concat(mods, '|') or nil, action = action }
end

module.edit_config = module.create(',', { 'CTRL' }, wezterm.action.SpawnCommandInNewTab({
    label = 'Edit: Modify configuration file',
    cwd = wezterm.config_dir,
    args = { utility.on_windows() and 'nvim.exe' or 'nvim', '.' },
}))
module.toggle_fullscreen = module.create('F11', {}, wezterm.action.ToggleFullScreen)

---Applies configuration settings to the given base.
---
---@param base_config table The base configuration.
function module.apply(base_config)
    utility.merge_into(base_config, {
        keys = { module.edit_config, module.toggle_fullscreen },
    })
end

return module
