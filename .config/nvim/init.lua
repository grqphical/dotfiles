vim.opt.nu             = true
vim.opt.relativenumber = true

vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.winborder      = "rounded"

vim.opt.smartindent    = true

vim.opt.wrap           = false

vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile       = true

vim.opt.hlsearch       = false
vim.opt.incsearch      = true

vim.opt.termguicolors  = true

vim.opt.scrolloff      = 8
vim.opt.signcolumn     = "yes"
vim.opt.isfname:append("@-@")
vim.o.splitright = true

vim.opt.updatetime = 50

-- To make clipboard on WSL work
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

vim.g.mapleader = " "
-- Open NetRW
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Copy selection to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Remap CTRL+C to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set('n', '<leader>sp', ':setlocal spell spelllang=en_ca<CR>')
vim.keymap.set('n', '<leader>sx', ':setlocal nospell<CR>')

vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/saghen/blink.cmp",             version = vim.version.range("1.*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
})

vim.cmd("colorscheme rose-pine")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", {})
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "BlinkCMPDocBorder", {})


vim.fn["mkdp#util#install"]()
vim.g.mkdp_filetypes = { "markdown" }

vim.keymap.set("n", "<leader>pm", vim.cmd.MarkdownPreview)

-- fugitive (Git)
vim.keymap.set("n", "<leader>gs", function()
    vim.cmd("vertical G")
end)

require("telescope").setup {
    pickers = {
        find_files = {
            theme = "ivy"
        }
    }
}

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>fd', telescope.find_files)
vim.keymap.set('n', '<leader>fh', telescope.help_tags)
vim.keymap.set('n', '<leader>km', telescope.keymaps)
vim.keymap.set('n', '<leader>gb', telescope.git_branches)
vim.keymap.set('n', '<leader>en', function()
    telescope.find_files {
        cwd = vim.fn.stdpath('config')
    }
end)

-- treesitter
vim.treesitter.language.add('python', { path = "/home/nathan/treesitter/tree-sitter-python.wasm" })
vim.treesitter.language.add('go', { path = "/home/nathan/treesitter/tree-sitter-go.wasm" })
vim.treesitter.language.add('cpp', { path = "/home/nathan/treesitter/tree-sitter-cpp.wasm" })
vim.treesitter.language.add('json', { path = "/home/nathan/treesitter/tree-sitter-json.wasm" })
vim.treesitter.language.add('javascript', { path = "/home/nathan/treesitter/tree-sitter-javascript.wasm" })
vim.treesitter.language.add('html', { path = "/home/nathan/treesitter/tree-sitter-html.wasm" })
vim.treesitter.language.add('typescript', { path = "/home/nathan/treesitter/tree-sitter-typescript.wasm" })

-- undotree
vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)

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
