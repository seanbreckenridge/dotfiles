local M = {}

-- A lot of the commands here are wrapped with
-- https://github.com/seanbreckenridge/fzfcache
-- That is an external command which caches the results
-- of the previous run, so it can prompt you with the choices faster

--- Get a list of all of my config files tracked by yadm
--- @return string[]
function M.list_config()
    local handle = io.popen("list-config-no-hist", "r")
    if handle == nil then return {} end
    local result = handle:read("*a")
    handle:close()
    local config = {} ---@type string[]
    for line in result:gmatch("[^\r\n]+") do table.insert(config, line) end
    return config
end

--- Edit one of my config files
function M.edit_config()
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values

    pickers.new({}, {
        prompt_title = 'Edit Config',
        finder = finders.new_oneshot_job({"fzfcache", "list-config-no-hist"}, {}),
        sorter = conf.generic_sorter({}),
        preview = require('telescope.config').values.preview
    }):find()
end

--- Grep all of my config files
--- @return nil
function M.grep_config()
    require('telescope.builtin').live_grep({
        shorten_path = true,
        prompt_title = 'Grep Config',
        cwd = '~/',
        search_dirs = M.list_config(),
        hidden = false,
        -- use my default settings from telescope setup
        preview = require('telescope.config').values.preview
    })
end

--- Grep all helptext files 
--- @return nil
function M.grep_help()
    require('telescope.builtin').live_grep({
        prompt_title = 'help',
        search = '',
        search_dirs = vim.api.nvim_get_runtime_file('doc/*.txt', true),
        only_sort_text = true
    })
end

--- Pick one of my git repos, cd to it, and open telescope to pick a file
---
--- @param opts table|nil: options to pass to telescope
--- @return nil
function M.switch_to_repo(opts)
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local builtins = require('telescope.builtin')
    local action_state = require('telescope.actions.state')
    opts = opts or {}

    pickers.new(opts, {
        prompt_title = 'Pick Repo',
        cwd = '~/',
        -- list my git repos runs a parallel search across all my git repos
        finder = finders.new_oneshot_job({"fzfcache", "list-my-git-repos"}, {}),
        sorter = require("telescope.config").values.generic_sorter(opts),
        ---@diagnostic disable-next-line: unused-local
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- cd to this directory, and open telescope to pick a file
                vim.cmd('lcd ' .. selection.value)
                builtins.find_files()
            end)
            return true
        end
    }):find()
end

return M
