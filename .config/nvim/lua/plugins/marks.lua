local wk = require('which-key')

wk.register({
    m = {
        name = 'marks',
        m = {function() require("marks").toggle_signs() end, 'toggle marks'},
        n = {function() require("marks").next() end, 'next mark'},
        p = {function() require("marks").prev() end, 'previous mark'},
        d = {function() require("marks").delete_line() end, 'delete mark'},
        c = {':delmarks!<CR>', 'clear marks'}
    }
}, {prefix = '<leader>'})

return {
    'chentoast/marks.nvim',
    keys = {'<leader>m'},
    config = function()
        local marks = require('marks')
        marks.setup({
            -- whether to map keybinds or not. default true
            default_mappings = false,
            -- how often (in ms) to redraw signs/recompute mark positions.
            -- higher values will have better performance but may cause visual lag,
            -- while lower values may cause performance penalties. default 150.
            refresh_interval = 150
        })

        -- when this is lazy loaded through <leader>m, the marks are shown
        -- this line disables it, but I typically start this with <leader>mm
        -- which toggles it again back to on
        --
        -- shouldn't be a big deal as I don't use marks that often and this
        -- typically is not loaded
        marks.toggle_signs()
    end
}
