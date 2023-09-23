local wk = require('which-key')

-- shorter helper w/ types to warn me for mapping keys
-- tried to use which-key but doesn't always work (e.g. for
-- incremental search and search/replace with selected text)

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
---@param mode string|table the mode to map to, defaults to 'n'
local map_key = function(key, cmd, desc, mode)
    vim.keymap
        .set(mode, key, cmd, {noremap = true, nowait = false, desc = desc})
end

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
local nnoremap = function(key, cmd, desc) map_key(key, cmd, desc, 'n') end

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
local vnoremap = function(key, cmd, desc) map_key(key, cmd, desc, 'v') end

map_key('<Down>', '<Nop>', 'disable arrow keys', {'i', 'n', 'x'})
map_key('<Left>', '<Nop>', 'disable arrow keys', {'i', 'n', 'x'})
map_key('<Right>', '<Nop>', 'disable arrow keys', {'i', 'n', 'x'})
map_key('<Up>', '<Nop>', 'disable arrow keys', {'i', 'n', 'x'})
-- gq is used for formatting, e.g. gqip to format a paragraph, gqq to format a line
map_key('Q', 'gq', 'reformat lines', {'n', 'v'})

nnoremap('/', '/\\v', 'incremental search')
nnoremap('/', '/\\v', 'incremental search')
nnoremap('<leader>y', 'V"+y', 'copy to clipboard')
vnoremap('<leader>y', '"+y', 'copy to clipboard')

-- swap wrapped lines behavior:
nnoremap('j', 'gj', 'move wrapped line down')
nnoremap('k', 'gk', 'move wrapped line up')
nnoremap('gj', 'j', 'move line down')
nnoremap('gk', 'k', 'move line up')

-- zz keeps the cursor in the middle of the screen
nnoremap('<C-u>', '<C-u>zz', 'centered page up')
nnoremap('<C-d>', '<C-d>zz', 'centered page down')
nnoremap('n', 'nzz', 'centered next')
nnoremap('N', 'Nzz', 'centered prev')

-- when I press !B (holding shift for both)
nnoremap('!B', ':.!bash<CR>', 'run shell command')
vnoremap('!B', ':.!bash<CR>', 'run shell command')

vnoremap('J', ':move \'>+1<CR>gv=gv', 'move selected text down')
vnoremap('K', ':move \'<-2<CR>gv=gv', 'move selected text up')

nnoremap('J', "mzJ`z", 'append to line')

local leftn = function(n) return string.rep('<Left>', n) end

-- start a :%s/ search with the selected text, prompting for the replacement
vnoremap('F', 'y:%s/<C-r>"//gc' .. leftn(3), 'search and replace')
-- in normal mode, use the next word as the search term
nnoremap('F', 'yiw:%s/<C-r>"//gc' .. leftn(3), 'search and replace')
-- just start a search/replace and move me to where I can start typing
-- note: overwrites default <C-f> (forward one page)
nnoremap('<C-f>', ':%s///gcI' .. leftn(5), 'empty search and replace')

local reload_config = function()
    vim.cmd(':source ~/.config/nvim/lua/seanbreckenridge/init.lua')
    vim.cmd(':source ~/.config/nvim/lua/seanbreckenridge/mappings.lua')
    require('seanbreckenridge.colorscheme').setup_theme()
end

-- misc
wk.register({
    -- reminder, can use 'P' in netrw to open in right tab
    e = {':wincmd v<bar> :Explore <bar> :vertical resize 30<CR>', 'netrw'},
    s = {':set spell!<CR>', 'toggle spell'},
    X = {':!chmod +x %<CR>', 'chmod +x'},
    ["S"] = {reload_config, 'reload config'}
}, {prefix = '<space>'})

-- window/buffers
wk.register({b = {'<C-^><CR>', 'swap buffers'}, w = {'<C-W>', 'window'}},
            {prefix = '<leader>'})
nnoremap('<leader><C-n>', ':enew<CR>', 'new file')

-- separating these into separate register calls let me use the name
wk.register({
    W = {
        name = "window/buffers",
        ["="] = {':vertical resize +5<CR>', 'vertical increase window size'},
        ["-"] = {':vertical resize -5<CR>', 'vertical decrease window size'},
        ["s"] = {'<C-W>s', 'horizontal split'},
        ["v"] = {'<C-W>v', 'vertical split'}
    }
}, {prefix = '<leader>'})

nnoremap('<C-q>', ':lua ToggleQFList(1)<CR>', 'toggle quickfix list')
wk.register({
    j = {':cnext<CR>', 'qf next'},
    k = {':cprev<CR>', 'qf prev'},
}, {prefix = '<leader>'})

nnoremap('<C-l>', ':lua ToggleQFList(0)<CR>', 'toggle loc list')
wk.register({
    l = {
        name = 'loc list',
        j = {':lnext', 'next'},
        k = {':lprev', 'prev'},
        l = {function() ToggleQFList(0) end, 'toggle loc list'}
    }
}, {prefix = '<leader>'})

function ToggleQFList(quickfix)
    -- quickfix
    if quickfix == 1 then
        require("trouble").toggle("quickfix")
    else -- loclist
        require("trouble").toggle("loclist")
    end
end

-- for picking which files to merge from while resolving merge conflicts
-- middle is what the final merged file is
-- gj to pick hunk from the right (under right index)
-- gf to pick hunk form the left (under left index)
wk.register({
    name = "git merge",
    j = {':diffget //3<CR>', 'diffget //3'},
    f = {':diffget //2<CR>', 'diffget //2'}
}, {prefix = "<leader>i"})

-- copilot
vim.cmd([[
" copilot
" remove tab mapping -- map to alt+c
" to swap between choices, use alt+] and alt+[
imap <silent><script><expr> <M-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {'*': v:true ,
  \ 'help': v:false,
  \ 'markdown': v:false,
  \ }
  ]])
