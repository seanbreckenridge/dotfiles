return {
    "nvim-pack/nvim-spectre",
    keys = {
        {
            "S",
            function()
                require("spectre").open()
            end,
            desc = "spectre",
        },
    },
    cmd = "Spectre",
    opts = {},
}
