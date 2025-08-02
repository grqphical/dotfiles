vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

})

-- colorscheme
vim.cmd("colorscheme rose-pine")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", {})
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

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
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

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

-- LSP Setup
-- lazydev.nvim
require("lazydev").setup {
    library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
}

-- lspconfig
local lspconfig = require("lspconfig")

vim.diagnostic.config({
    virtual_lines = true
})

lspconfig.ts_ls.setup { init_options = {
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
    }, }
lspconfig.emmet_language_server.setup { filetypes = { "html", "templ" } }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd("set completeopt+=noselect")

vim.lsp.enable({ "lua_ls", "pyright", "gopls", "templ", "html", "cssls", "jsonls", "ts_ls", "emmet_language_server" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
