local M = {}

function M.edit_config()
    local builtin = require('telescope.builtin')
    builtin.find_files({
        shorten_path = true,
        prompt_title = 'Edit Config',
        cwd = '~/',
        find_command = {"list-config"},
        hidden = false,
        -- use my default settings from telescope setup
        preview = require('telescope.config').values.preview
    })
end

return M
