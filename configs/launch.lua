local utility = require('utility')

local module = {}

---Creates a new launch option for the specified executable.
---
---@param label string The option's label.
---@param args string[] The launch options.
---@param cwd ?string The directory to enter on launch.
---
---@return table launch The launch option.
function module.create(label, args, cwd)
    return { label = label, cwd = cwd or '~', args = args }
end

---Creates a new launch option for the specified WSL distribution.
---
---@param label string The option's label.
---@param distro string The distribution.
---@param cwd ?string The directory to enter on launch.
---
---@return table launch The launch option.
function module.create_wsl(label, distro, cwd)
    cwd = cwd or '~'

    return { label = label, cwd = cwd, args = { 'wsl.exe', '-d', distro, '--cd', cwd } }
end

---Applies configuration settings to the given base.
---
---@param base_config table The base configuration.
function module.apply(base_config)
    local launch_menu = {}

    if utility.on_windows() then
        table.insert(launch_menu, module.create('New Tab (Command Prompt)', { 'cmd.exe' }))
        table.insert(launch_menu, module.create('New Tab (Powershell)', { 'powershell.exe', '-NoIcon' }))
    end

    utility.merge_into(base_config, {
        default_prog = module.create_wsl('New Tab (Ubuntu)', 'Ubuntu-24.04').args,
        launch_menu = launch_menu,
    })
end

return module
