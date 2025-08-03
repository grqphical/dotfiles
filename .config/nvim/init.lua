-- ================================================================================
-- Settings
-- ================================================================================

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

-- ================================================================================
-- Remaps
-- ================================================================================

vim.g.mapleader = " "
-- Open NetRW
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Copy selection to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Remap CTRL+C to esc
vim.keymap.set("i", "<C-c>", "<Esc>")


-- Format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
end)

--lsp keybindings
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'dc', vim.lsp.buf.signature_help)

vim.keymap.set('n', '<leader>sc', ':so %<CR>')


-- Golang Specific: Insert if err != nil
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- ================================================================================
-- Plugins
-- ================================================================================
vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/saghen/blink.cmp",               version = vim.version.range("1.*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" }

})

-- colorscheme
vim.cmd("colorscheme rose-pine")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", {})
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "BlinkCMPDocBorder", {})

-- treesitter
local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "go",
        "html",
        "css",
        "javascript",
        "python",
        "markdown",
    },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
})

-- fugitive (Git)
vim.keymap.set("n", "<leader>gs", function()
    vim.cmd("vertical G")
end)

-- telescope
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
vim.keymap.set('n', '<leader>en', function()
    telescope.find_files {
        cwd = vim.fn.stdpath('config')
    }
end)

-- undotree
vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)

-- ================================================================================
-- LSP Setup
-- ================================================================================

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
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
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
        "vue",
    },
    capabilities = capabilities
})

vim.lsp.config("emmet_language_server", { filetypes = { "html", "templ" }, capabilities = capabilities })
vim.lsp.config("pyright", { capabilities = capabilities })
vim.lsp.config("gopls", { capabilities = capabilities })
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.config("templ", { capabilities = capabilities })
vim.lsp.config("html", { capabilities = capabilities })

vim.lsp.enable({ "lua_ls", "pyright", "gopls", "emmet_language_server", "cssls", "ts_ls", "templ", "html" })
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
