local wk = require('which-key')

---@param key string the key to map
---@param cmd string|function the command to run
---@param opts table|nil the options to pass to vim.keymap.set
local nnoremap = function(key, cmd, opts)
    opts = opts or {noremap = true}
    vim.keymap.set('n', key, cmd, opts)
end

---@param key string the key to map
---@param cmd string|function the command to run
---@param opts table|nil the options to pass to vim.keymap.set
local vnoremap = function(key, cmd, opts)
    -- should use 'x' instead of 'v' for visual mode
    -- so that the commands don't apply to select mode
    opts = opts or {noremap = true}
    vim.keymap.set('x', key, cmd, opts)
end

-- disable arrow keys
vim.keymap.set({'i', 'n', 'x'}, '<Down>', '<Nop>')
vim.keymap.set({'i', 'n', 'x'}, '<Left>', '<Nop>')
vim.keymap.set({'i', 'n', 'x'}, '<Right>', '<Nop>')
vim.keymap.set({'i', 'n', 'x'}, '<Up>', '<Nop>')

-- disable capital Q (:ex mode)
nnoremap('Q', '<Nop>')

-- incremental search, showing results as you type
nnoremap('/', '/\\v')
nnoremap('/', '/\\v')

-- copy to clipboard. if in normal mode, copy the whole line
nnoremap('<leader>y', 'V"+y')
vnoremap('<leader>y', '"+y')

-- swap wrapped lines behavior;
-- j/k moves a wrapped line, gj/gk moves the full line
nnoremap('j', 'gj')
nnoremap('k', 'gk')
nnoremap('gj', 'j')
nnoremap('gk', 'k')

-- keep cursor in the middle when using <C-u/d>
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-d>', '<C-d>zz')

-- keep search term in the middle when searching
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')

-- when I press !B (holding shift for both), send the current line to bash, used to run shell commands
nnoremap('!B', ':.!bash<CR>')
vnoremap('!B', ':.!bash<CR>')

-- move items while text is highlighted
vnoremap('J', ':move \'>+1<CR>gv=gv')
vnoremap('K', ':move \'<-2<CR>gv=gv')

-- click to start a :%s/ search with the selected text, prompting for the replacement
vnoremap('<C-n>', 'y:%s/<C-r>"//gc<Left><Left><Left>')
-- in normal mode, use the next word as the search term
nnoremap('<C-n>', 'yiw:%s/<C-r>"//gc<Left><Left><Left>')

local reload_config = function()
    vim.cmd(':source ~/.config/nvim/lua/seanbreckenridge/init.lua')
    vim.cmd(':source ~/.config/nvim/lua/seanbreckenridge/mappings.lua')
    require('seanbreckenridge.catppuccin').setup_theme()
end

-- misc
wk.register({
    -- reminder, can use 'P' in netrw to open in right tab
    e = {':wincmd v<bar> :Explore <bar> :vertical resize 30<CR>', 'netrw'},
    s = {':set spell!<CR>', 'toggle spell'},
    X = {':!chmod +x %<CR>', 'chmod +x'},
    ["S"] = {reload_config, 'reload config'}
}, {prefix = '<space>'})

-- nicer bindings for moving between windows
-- window/buffers

wk.register({b = {'<C-^><CR>', 'swap buffers'}, w = {'<C-W>', 'window'}},
            {prefix = '<leader>'})

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

-- function to toggle quickfix lists
nnoremap('<C-q>', ':lua ToggleQFList(1)<CR>')

-- quickfix list mappings
wk.register({
    j = {
        name = 'quickfix',
        j = {':cnext<CR>', 'next'},
        k = {':cprev<CR>', 'prev'},
        q = {function() ToggleQFList(1) end, 'toggle'}
    }
}, {prefix = '<leader>'})

-- function to toggle loc list
nnoremap('<C-l>', ':lua ToggleQFList(0)<CR>')

-- loc list mappings
wk.register({
    l = {
        name = 'loc list',
        j = {'lj', 'next'},
        k = {'lk', 'prev'},
        l = {function() ToggleQFList(0) end, 'toggle'}
    }
}, {prefix = '<leader>'})

function ToggleQFList(global)
    -- quickfix
    if global == 1 then
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
  \ }
  ]])
