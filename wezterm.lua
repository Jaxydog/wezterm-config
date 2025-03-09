local wezterm = require('wezterm')
local utility = require('utility')

if wezterm.GLOBAL.attempted_repository_update == nil then
    wezterm.GLOBAL.attempted_repository_update = true

    if utility.repository.is_local() then
        utility.toast('skipping update', 'no remote repository found', 5000)
    elseif utility.repository.is_dirty() then
        utility.toast('skipping update', 'local repository branch modified', 5000)
    else
        utility.repository.git({ 'pull' })
        utility.toast('updated configuration', 'your configuration has been automatically updated', 5000)

        wezterm.reload_configuration()
    end
end

return require('configs')
