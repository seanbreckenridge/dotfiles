-- 'https://github.com/laytan/cloak.nvim?tab=readme-ov-file#configuration'
return {
    'laytan/cloak.nvim',
    config = function()
        require('cloak').setup({
            patterns = {
                {
                    -- Match any file starting with '.env'.
                    -- This can be a table to match multiple file patterns.
                    file_pattern = '.env*',
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                    cloak_pattern = '=.+'
                }
            }
        })

        local wk = require('which-key')
        wk.register({["C"] = {'<cmd>CloakToggle<cr>', 'toggle cloak'}},
                    {prefix = '<leader>'})

    end
}
