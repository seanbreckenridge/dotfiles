local wk = require('which-key')

local nnoremap = function(lhs, rhs, opts)
    vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
    vim.api.nvim_set_keymap('i', lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
    -- should use 'x' instead of 'v' for visual mode
    -- so that the commands don't apply to select mode
    vim.api.nvim_set_keymap('x', lhs, rhs, opts)
end

-- disable arrow keys in all modes, loop over in lua
for _, mode in ipairs({'', 'i', 'n', 'x'}) do
    vim.keymap.set(mode, '<Down>', '<Nop>')
    vim.keymap.set(mode, '<Left>', '<Nop>')
    vim.keymap.set(mode, '<Right>', '<Nop>')
    vim.keymap.set(mode, '<Up>', '<Nop>')
end

-- disable capital Q (:ex mode)
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', {noremap = true})

-- incremental search, showing results as you type
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('v', '/', '/\\v', {noremap = true})

-- copy visual selection to clipboard
vim.api.nvim_set_keymap('v', '<leader>c', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>y', 'V"+y', {noremap = true})
-- swap wrapped lines behavior;
-- j/k moves a wrapped line, gj/gk moves the full line
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap = true})

-- keep cursor in the middle when using <C-u/d>
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true})

-- keep search term in the middle when searching
vim.api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true})

-- when I press !B (holding shift for both), send the current line to bash, used to run shell commands
vim.api.nvim_set_keymap('n', '!B', ':.!bash<CR>', {noremap = true})
vim.api.nvim_set_keymap('x', '!B', ':.!bash<CR>', {noremap = true})

-- move items while text is highlighted
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv=gv', {noremap = true})
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv=gv', {noremap = true})

-- click to start a :%s/ search with the selected text, prompting for the replacement
vim.api.nvim_set_keymap('x', '<C-n>', 'y:%s/<C-r>"//gc<Left><Left><Left>',
                        {noremap = true})
-- in normal mode, use the next word as the search term
vim.api.nvim_set_keymap('n', '<C-n>', 'yiw:%s/<C-r>"//gc<Left><Left><Left>',
                        {noremap = true})

-- misc
wk.register({
    -- reminder, can use 'P' in netrw to open in right tab
    e = {':wincmd v<bar> :Explore <bar> :vertical resize 30<CR>', 'netrw'},
    s = {':set spell!<CR>', 'toggle spell'},
    X = {':!chmod +x %<CR>', 'chmod +x'},
    ["S"] = {
        ':so ~/.config/nvim/init.lua<CR>:lua require("seanbreckenridge.colors").setup_theme()<CR>',
        'reload config'
    }
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
vim.api.nvim_set_keymap('n', '<C-q>', ':lua ToggleQFList(1)<CR>',
                        {noremap = true})

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
vim.api.nvim_set_keymap('n', '<C-l>', ':lua ToggleQFList(0)<CR>',
                        {noremap = true})

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
