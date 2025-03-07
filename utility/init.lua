local module = {
    color = require('utility.color'),
    repository = require('utility.repository'),
}

---Returns 'true' if the terminal is running on Windows.
---
---@return boolean on_windows Whether the host OS is Windows.
function module.on_windows()
    return require('wezterm').target_triple:find('windows') ~= nil
end

---Returns 'true' if the terminal is running on Linux.
---
---@return boolean on_windows Whether the host OS is Linux.
function module.on_linux()
    return require('wezterm').target_triple:find('linux') ~= nil
end

---Returns 'true' if the terminal is running on MacOS.
---
---@return boolean on_windows Whether the host OS is MacOS.
function module.on_macos()
    return require('wezterm').target_triple:find('apple') ~= nil
end

---Returns 'true' if the given executable is accessible from $PATH.
---
---@param executable string The executable.
---
---@return boolean exists Whether the executable is within $PATH.
function module.has_executable(executable)
    local command = module.on_windows() and 'where.exe' or 'which'
    local success, stdout = require('wezterm').run_child_process({ command, executable })

    return success and stdout:len() > 0
end

---Returns 'true' if Windows Sub-system for Linux is installed and contains the given distribution.
---
---@param distro ?string A specific distribution to check for.
---
---@return boolean installed Whether WSL is installed with the given distribution.
function module.has_wsl(distro)
    local exists = module.on_windows() and module.has_executable('wsl.exe')

    if not exists or not distro then return exists end

    local success, stdout = require('wezterm').run_child_process({ 'wsl.exe', '--list' })

    return success and stdout:find(distro) ~= nil
end

---Merges the given table into the specified base table.
---
---@param base table The base table.
---@param from table The table to be merged.
function module.merge_into(base, from)
    base = base or {}

    for key, value in pairs(from) do
        if type(value) == 'table' then
            if not base[key] then base[key] = {} end

            module.merge_into(base[key], value)
        else
            base[key] = value
        end
    end
end

---Returns a function that caches its return values.
---
---@generic T, F: fun(): `T`
---
---@param cache_table table The cache table.
---@param cache_key string The cache key.
---@param callable F The function to call when a value is missing.
---
---@return F callable The cached function.
function module.cached_function(cache_table, cache_key, callable)
    assert(cache_key:len() > 0, 'The cache key must not be empty')
    assert(cache_key:find(';') == nil, 'The cache key may not contain a semicolon')

    local function get_key(base, ...)
        local key = '' .. base
        local arguments = table.pack(...)

        for index = 1, arguments['n'], 1 do
            key = key .. ';' .. tostring(arguments[index])
        end

        return key
    end

    return function(...)
        local key = get_key(cache_key, ...)

        if cache_table[key] == nil then
            cache_table[key] = callable(...)

            assert(cache_table[key] ~= nil, 'Callable should not return nil')
        end

        return cache_table[key]
    end
end

return module
