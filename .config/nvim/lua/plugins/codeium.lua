local function toggle() require('user.patch_codeium').toggle_codeium_enabled() end

local mh = require('user.mapping_helpers')
mh.map_key("<M-z>", toggle, "toggle codeium", {"i", "n"})

return {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    cmd = {"Codeium", "CodeiumToggle"},
    dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"},
    config = function()
        require("codeium").setup()
        require("user.patch_codeium").patch_codeium()

        vim.api.nvim_create_user_command("CodeiumToggle", toggle,
                                         {desc = "Toggle Codeium"})

    end
}
