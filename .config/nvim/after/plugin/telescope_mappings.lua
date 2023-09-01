-- telescope (fuzzy finder)
local wk = require('which-key')
local builtin = require('telescope.builtin')

wk.register({
    f = {
        name = "telescope",
        f = {builtin.find_files, 'find files'},
        g = {builtin.live_grep, 'grep'},
        r = {builtin.lsp_references, 'references'},
        b = {builtin.buffers, 'buffers'},
        H = {builtin.help_tags, 'help'},
        q = {builtin.quickfix, 'quickfix'},
        l = {builtin.loclist, 'loclist'},
        p = {builtin.git_files, 'git files'},
        o = {builtin.oldfiles, 'old files'},
        c = {builtin.commands, 'commands'},
        s = {builtin.spell_suggest, 'spell suggest'},
        m = {builtin.marks, 'marks'},
        M = {builtin.man_pages, 'man pages'},
        h = {builtin.command_history, 'command history'},
        k = {builtin.keymaps, 'keymaps'},
        d = {builtin.diagnostics, 'diagnostics'},
        L = {builtin.reloader, 'reload lua'}
    }
}, {prefix = '<leader>'})
