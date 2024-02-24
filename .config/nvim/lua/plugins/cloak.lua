-- 'https://github.com/laytan/cloak.nvim?tab=readme-ov-file#configuration'
return {
    'laytan/cloak.nvim',
    config = function()
        require('cloak').setup({
            enabled = true,
            cloak_character = '*',
            -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
            highlight_group = 'Comment',
            -- Applies the length of the replacement characters for all matched
            -- patterns, defaults to the length of the matched pattern.
            cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
            -- Whether it should try every pattern to find the best fit or stop after the first.
            try_all_patterns = true,
            patterns = {
                {
                    -- Match any file starting with '.env'.
                    -- This can be a table to match multiple file patterns.
                    file_pattern = '.env*',
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                    cloak_pattern = '=.+',
                    -- A function, table or string to generate the replacement.
                    -- The actual replacement will contain the 'cloak_character'
                    -- where it doesn't cover the original text.
                    -- If left empty the legacy behavior of keeping the first character is retained.
                    replace = nil
                }
            }
        })

        local wk = require('which-key')
        wk.register({["C"] = {'<cmd>CloakToggle<cr>', 'toggle cloak'}},
                    {prefix = '<leader>'})

    end
}
