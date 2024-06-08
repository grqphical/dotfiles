require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "go", "python", "html", "toml", "diff", "gitcommit", "bash" },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
