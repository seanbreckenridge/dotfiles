local M = {}
M._is_patched = false

--- Codeium provides no way to toggle the client on or off. This lets the
--- user set the variable codeium_enabled to do that, and patches the
--- library function to prevent it from running when disabled.

--- Checks the buffer or global options to see if codeium_enabled is set
---@return boolean
function M.is_codeium_enabled()
    local enabled = vim.b["codeium_enabled"]
    if enabled == nil then
        enabled = vim.g["codeium_enabled"]
        if enabled == nil then
            enabled = true -- enable by default
        end
    end
    return enabled
end

--- toggles the state of codeium_enabled. first checks buffer, else
--- toggles global state. Sends a notification with vim.notify
---@return boolean
function M.toggle_codeium_enabled()
    M.patch_codeium()

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

--- Overwrite the library is_available function to prevent it from
--- running when codeium_enabled is set to false
--- @return nil
function M.patch_codeium()
    if M._is_patched == true then return end

    local Source = require("codeium.source")

    --- save reference to library available function
    local superclass_is_available = Source.is_available
    --- overwrite the library built-in is_available function
    --- so that I can disable when I want to
    ---@diagnostic disable-next-line: duplicate-set-field
    function Source:is_available()
        return M.is_codeium_enabled() and superclass_is_available(self)
    end

    M._is_patched = true
end

return M
