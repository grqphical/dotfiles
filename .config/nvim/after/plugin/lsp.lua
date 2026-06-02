vim.diagnostic.config({
    virtual_lines = true
})

local blink = require("blink.cmp")

blink.setup {
    keymap = {
        preset = 'default',
        ['<C-f>'] = { 'accept', 'fallback' },
    },

    appearance = {
        nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = false } },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
}

local capabilities = blink.get_lsp_capabilities()

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "vue",
    },
    capabilities = capabilities
})

vim.lsp.config("tinymist", {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable"
    },
    capabilities = capabilities,
    cmd = { "tinymist" },
})

vim.lsp.config("emmet_language_server", {
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "templ" },
    capabilities = capabilities,
    init_options = {
        includeLanguages = { "html" },
        excludeLanguages = {},
        extensionsPath = {},
        preferences = {},
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        showSuggestionsAsSnippets = false,
        syntaxProfiles = {},
        variables = {},
    },
})
vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            }
        }
    }
}
)
vim.lsp.config("gopls", { capabilities = capabilities })
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.config("templ", { capabilities = capabilities })

vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--enable-config' },
    init_options = {}
})

vim.lsp.config("zls", {
    capabilities = capabilities,
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    workspace_required = false,
})

vim.lsp.enable({ "lua_ls", "pyright", "gopls", "emmet_language_server", "cssls", "ts_ls", "templ", "tinymist", "clangd",
    "zls" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- format on save
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})
