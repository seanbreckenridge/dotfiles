local M = {}

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
    require('telescope.builtin').find_files({
        shorten_path = true,
        prompt_title = 'Edit Config',
        cwd = '~/',
        find_command = {"list-config-no-hist"},
        hidden = false,
        -- use my default settings from telescope setup
        preview = require('telescope.config').values.preview
    })
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

--- Get a list of all of my base directories for my repos
--- This is something like:
--- { "~/Repos", "~/Files/OldRepos", "~/.local/share/go/.../seanbreckenridge/..." }
---
-- ~/.cache/repo_bases.txt gets populated by a bgproc job
-- https://sean.fish/d/cached_repo_bases.job?redirect
--- @return string[]
function M.repo_bases()
    local cache_dir = os.getenv('XDG_CACHE_HOME')
    local cache_file = cache_dir .. '/repo_bases.txt'
    local f = io.open(cache_file, 'r')
    if f == nil then return {} end
    local roots = {} ---@type string[]
    for line in f:lines() do table.insert(roots, line) end
    return roots
end

M._repo_bases = nil

--- Cached version of the base directories for all my repositories,
--- if its already been called once
--- @return string[]
function M.repo_bases_cached()
    if M._repo_bases == nil then M._repo_bases = M.repo_bases() end
    return M._repo_bases
end

return M
