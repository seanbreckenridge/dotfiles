return {
    "Exafunction/codeium.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"},
    config = function()
        require("codeium").setup()
        local Source = require("codeium.source")

        local function is_codeium_enabled()
            local enabled = vim.b["codeium_enabled"]
            if enabled == nil then
                enabled = vim.g["codeium_enabled"]
                if enabled == nil then
                    enabled = true -- enable by default
                end
            end
            return enabled
        end

        ---@return boolean
        local function toggle_codeium_enabled()
            ---@param status boolean
            ---@param locality string
            ---@return boolean
            local function log_result(status, locality)
                local msg = "Codeium: " .. (status and "enabled" or "disabled")
                if locality == "global" then
                    msg = msg .. " globally"
                else
                    msg = msg .. " in this buffer"
                end

                vim.notify(msg)
                return status
            end

            local buffer_enabled = vim.b["codeium_enabled"]
            if buffer_enabled ~= nil then
                vim.b["codeium_enabled"] = not buffer_enabled
                return log_result(vim.b["codeium_enabled"], "buffer")
            end
            local global_enabled = vim.g["codeium_enabled"]
            if global_enabled ~= nil then
                vim.g["codeium_enabled"] = not global_enabled
                return log_result(vim.g["codeium_enabled"], "global")
            end

            -- otherwise, turn off (is on by default)
            vim.g["codeium_enabled"] = false
            return log_result(vim.g["codeium_enabled"], "global")
        end

        vim.keymap.set({"i", "n"}, "<M-z>", toggle_codeium_enabled,
                       {noremap = true})

        --- overwrite the library built-in is_available function
        --- so that I can disable when I want to
        ---@diagnostic disable-next-line: duplicate-set-field
        function Source:is_available()
            local enabled = is_codeium_enabled()
            ---@diagnostic disable-next-line: undefined-field
            return enabled and self.server.is_healthy()
        end
    end
}
