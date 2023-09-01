local M = {}

function M.edit_config()
    local builtin = require('telescope.builtin')
    builtin.find_files({
        shorten_path = true,
        prompt_title = 'Edit Config',
        cwd = '~/',
        find_command = {"list-config-no-hist"},
        hidden = false,
        -- use my default settings from telescope setup
        preview = require('telescope.config').values.preview
    })
end

-- get the output of the list-config-no-hist command in a table
function M.list_config()
    local handle = io.popen("list-config-no-hist")
    if handle == nil then return {} end
    local result = handle:read("*a")
    handle:close()
    local config = {}
    for line in result:gmatch("[^\r\n]+") do table.insert(config, line) end
    return config
end

function M.grep_config()
    local builtin = require('telescope.builtin')
    builtin.live_grep({
        shorten_path = true,
        prompt_title = 'Grep Config',
        cwd = '~/',
        search_dirs = M.list_config(),
        hidden = false,
        -- use my default settings from telescope setup
        preview = require('telescope.config').values.preview
    })
end

function M.grep_help()
    local builtin = require('telescope.builtin')
    builtin.live_grep({
        prompt_title = 'help',
        search = '',
        search_dirs = vim.api.nvim_get_runtime_file('doc/*.txt', true),
        only_sort_text = true
    })
end

function M.repo_bases()
    -- cache/roots.txt gets populated by a bgproc job
    -- https://sean.fish/d/cached_repo_bases.job?dark
    local cache_dir = os.getenv('XDG_CACHE_HOME')
    local cache_file = cache_dir .. '/repo_bases.txt'
    local f = io.open(cache_file, 'r')
    if f == nil then return {} end
    local roots = {}
    for line in f:lines() do table.insert(roots, line) end
    return roots
end

function M.repo_bases_cached()
    if vim.g.repo_bases == nil then vim.g.repo_bases = M.repo_bases() end
    return vim.g.repo_bases
end

return M
