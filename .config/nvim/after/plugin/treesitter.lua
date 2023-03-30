-- https://github.com/nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "cpp", "css", "html", "lua", "perl", "python", "rust", "go",
        "javascript", "json", "regex", "toml", "yaml", "vim", "typescript",
        "tsx", "c", "java", "php", "ruby", "dart", "elixir"
    },
    highlight = {
        enable = true -- false will disable the whole extension
    }
}
