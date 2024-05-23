local wk = require('which-key')

local mh = require('user.mapping_helpers')
local map_key = mh.map_key
local nnoremap = mh.nnoremap
local vnoremap = mh.vnoremap

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
nnoremap("G", "Gzz", "centered goto line")
nnoremap("gg", "ggzz", "centered goto line")
nnoremap("<C-i>", "<C-i>zz", "centered next jump")
nnoremap("<C-o>", "<C-o>zz", "centered prev jump")
nnoremap("%", "%zz", "centered match")
nnoremap("*", "*zz", "centered match")
nnoremap("#", "#zz", "centered match")

-- U (opposite of u) for redo
nnoremap('U', '<C-r>', 'redo')

-- when I press !B (holding shift for both)
nnoremap('!B', ':.!bash<CR>', 'run shell command')
vnoremap('!B', ':.!bash<CR>', 'run shell command')

vnoremap('J', ':move \'>+1<CR>gv=gv', 'move selected text down')
vnoremap('K', ':move \'<-2<CR>gv=gv', 'move selected text up')

nnoremap('J', "mzJ`z", 'append to line')

local function leftn(n) return string.rep('<Left>', n) end

-- start a :%s/ search with the selected text, prompting for the replacement
vnoremap('<C-n>', 'y:%s/<C-r>"//gc' .. leftn(3), 'search and replace')
-- in normal mode, use the next word as the search term
nnoremap('<C-n>', 'yiw:%s/<C-r>"//gc' .. leftn(3), 'search and replace')
-- just start a search/replace and move me to where I can start typing
-- note: overwrites default <C-f> (forward one page)
nnoremap('<C-f>', ':%s///gcI' .. leftn(5), 'empty search and replace')
vnoremap('<C-f>', ':s///gcI' .. leftn(5),
         'empty search and replace on selection')

nnoremap('<Esc>', '<cmd>nohlsearch<CR>', 'clear search highlight')

local function reload_config()
    vim.cmd('source ~/.config/nvim/lua/user/settings.lua')
    vim.cmd('source ~/.config/nvim/lua/user/key_mappings.lua')
    print('Reloaded config')
end

-- misc
wk.register({
    s = {':set spell!<CR>', 'toggle spell'},
    X = {':w<CR>:!chmod +x %<CR>:edit<CR>', 'chmod +x'},
    ["<CR>"] = {":split<CR>:term<CR>", 'open terminal'},
    ["S"] = {reload_config, 'reload config'}
}, {prefix = '<leader>'})

-- window/buffers
wk.register({b = {'<C-^>', 'swap buffers'}}, {prefix = '<leader>'})
-- use WhichKey so I can see the mappings
nnoremap('<leader>w', function() require('which-key').show_command('<C-w>') end,
         'window')
nnoremap('<leader><C-n>', ':enew<CR>', 'new file')
nnoremap('<leader>d', function() require('notify').dismiss() end,
         'dismiss notifications')

nnoremap('<C-q>', ':lua ToggleQFList(0)<CR>', 'toggle quickfix list')
wk.register({j = {':cnext<CR>', 'qf next'}, k = {':cprev<CR>', 'qf prev'}},
            {prefix = '<leader>'})

nnoremap('<C-l>', ':lua ToggleQFList(0)<CR>', 'toggle loc list')
wk.register({
    l = {
        name = 'loc list',
        j = {':lnext', 'next'},
        k = {':lprev', 'prev'},
        l = {function() ToggleQFList(0) end, 'toggle loc list'}
    }
}, {prefix = '<leader>'})

function ToggleQFList(is_quickfix)
    -- quickfix
    if is_quickfix == 1 then
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
    -- ]c goes to the next conflict
    -- just the current file
    i = {':diffput<CR>]c', 'use current file'},
    -- if Im merging two files in a split where one is a syncthing conflict
    -- grab from the other file
    s = {':diffget sync-conflict<CR>]c', 'diffget sync-conflict'},
    -- //2 and //3 are set by fugitive for when doing git merges
    j = {':diffget //3<CR>', 'diffget //3'},
    f = {':diffget //2<CR>', 'diffget //2'}
}, {prefix = "<leader>i"})

