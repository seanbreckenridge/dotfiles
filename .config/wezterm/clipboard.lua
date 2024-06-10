local wt = require("wezterm")

-- https://github.com/wez/wezterm/discussions/3469

local M = {}
M.autoQuotePastedUrls = function(window, pane)
    local pasteCmd = "clippaste"
    local success, clipb, stderr = wt.run_child_process({ pasteCmd })
    if not success then
        local msg = "clippaste failed: " .. stderr
        wt.log_info(msg)
        window:toast_notification(msg, nil, 4000)
        return
    end
    if clipb:find("^https?://") then
        clipb = "'" .. clipb .. "'"
    end
    pane:paste(clipb)
end

return M
