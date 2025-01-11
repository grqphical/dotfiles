return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = '*',

        opts = {
            keymap = { preset = 'default' },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            signature = { enabled = true },

        },
        opts_extend = { "sources.default" }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup {capabilities = capabilities}
            lspconfig.pyright.setup{capabilities = capabilities}
            lspconfig.gopls.setup{capabilities = capabilities}
            lspconfig.emmet_language_server.setup{capabilities = capabilities}

        end
    },
}
