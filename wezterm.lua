local wezterm = require('wezterm')
local utility = require('utility')

if wezterm.GLOBAL.attempted_repository_update == nil then
    wezterm.GLOBAL.attempted_repository_update = true

    if utility.repository.is_local() then
        utility.toast('skipping update', 'no remote repository found', 5000)
    elseif utility.repository.is_dirty() then
        utility.toast('skipping update', 'local repository branch modified', 5000)
    else
        local success = utility.repository.git({ 'pull', '--ff-only' })

        if success then
            utility.toast('updated', 'your configuration has been updated - changes will apply on reload', 5000)
        else
            utility.toast('update failed', 'an error occurred during the configuration update')
        end
    end
end

return require('configs')
