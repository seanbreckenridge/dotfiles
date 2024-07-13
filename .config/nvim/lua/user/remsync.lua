local M = {}

---@class RemsyncOpts
---@field number_lines boolean
---@field sync boolean

---@param opts RemsyncOpts
function M.tohtml(opts)
    if opts.sync then
        vim.notify(vim.fn.system("remsync"))
        return
    end
    local basename = vim.fn.expand("%:t")
    local outfile = vim.fn.tempname() .. "_" .. vim.fn.strftime("%s") .. "_" .. basename .. ".html"
    local html = require("tohtml").tohtml(nil, {
        number_lines = opts.number_lines or false,
        width = 100,
    })
    vim.fn.writefile(html, outfile)
    local job = require("plenary.job"):new({
        command = "remsync",
        enable_handlers = false,
        enabled_recording = false,
        args = { outfile },
        on_exit = function(_, return_val)
            if return_val > 0 then
                vim.notify("Upload failed", vim.log.levels.ERROR, { title = "resmync" })
            end
        end,
    })
    vim.notify("Uploading file...", vim.log.levels.INFO, { title = "resmync" })
    job:start()
end

---@param flags string[]
---complete the current word, else complete arguments that aren't already on the command line
function M.complete_no_duplicates(flags)
    return function(ArgLead, Cmdline, _)
        local cmdline_has = vim.iter(vim.split(Cmdline, " ")):skip(1):totable()
        local matches = {}
        vim.iter(flags)
            :filter(function(opt)
                return not vim.tbl_contains(cmdline_has, opt)
            end)
            :each(function(opt)
                if opt:find(ArgLead) == 1 then
                    table.insert(matches, opt)
                end
            end)
        return matches or flags
    end
end

vim.api.nvim_create_user_command("Remsync", function(opts)
    M.tohtml({
        sync = vim.list_contains(opts.fargs, "sync"),
        number_lines = vim.list_contains(opts.fargs, "lines"),
    })
end, {
    desc = "Convert buffer to HTML and sync to a tempfile on my website",
    nargs = "*",
    complete = M.complete_no_duplicates({ "lines", "sync" }),
})

return M
