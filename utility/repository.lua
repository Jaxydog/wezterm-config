local module = {}

module.url = 'https://github.com/Jaxydog/wezterm-config.git'

---Runs a Git command in the configuration directory.
---
---@param arguments ?table The command's arguments.
---
---@return boolean success Whether the command succeeded.
---@return string stdout The content sent to standard output.
---@return string stderr The content sent to standard error.
function module.git(arguments)
    local wezterm = require('wezterm')

    ---@type table
    local process_arguments = { 'git.exe', '-C', wezterm.config_dir }

    for _, argument in ipairs(arguments or {}) do
        table.insert(process_arguments, argument)
    end

    return wezterm.run_child_process(process_arguments)
end

---Returns 'true' if the configuration directory is a local repository.
---
---@return boolean local Whether the directory is local.
function module.is_local()
    local success, stdout = module.git({ 'remote' })

    return not success or stdout:len() == 0
end

---Returns 'true' if the configuration directory has been modified.
---
---@return boolean dirty Whether the directory was modified.
function module.is_dirty()
    local success, stdout = module.git({ 'status', '--porcelain' })

    return not success or stdout:len() > 0
end

return module
