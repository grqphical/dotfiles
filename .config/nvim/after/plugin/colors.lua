require("nightfox").setup({
    options = {
        transparent = true,
    },
    modules = {
        "telescope",
        "treesitter",
        "native_lsp",
    }

})

vim.cmd 'colorscheme carbonfox'
