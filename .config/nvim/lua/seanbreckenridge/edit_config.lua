local M = {}

function M.edit_config()
    require('telescope.builtin').find_files({
        prompt_title = 'Edit Config',
        cwd = '~/',
        find_command = {"list-config"},
        hidden = false,
        preview = require('telescope.previewers').vim_buffer_cat.new,
        layout_strategy = 'vertical',
        layout_config = {height = 0.9, width = 0.9, preview_cutoff = 120}
    })
end

return M
