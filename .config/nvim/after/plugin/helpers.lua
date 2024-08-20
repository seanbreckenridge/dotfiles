-- dumps the contents of one or more variables to the console
-- selene: allow(unscoped_variables,unused_variable)
P = function(...)
    local args = {}
    for _, arg in ipairs({ ... }) do
        table.insert(args, vim.inspect(arg))
    end
    print(unpack(args))
    return ...
end
