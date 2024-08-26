return {
    {
        "Mofiqul/adwaita.nvim",
        lazy = false,
        priority = 1000,

        -- configure and set on startup
        config = function()
            vim.g.adwaita_darker = false
            vim.g.adwaita_transparent = false
            vim.cmd('colorscheme adwaita')
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {

                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    { 'neovim/nvim-lspconfig' },
    {
        'doctorfree/cheatsheet.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v4.x' },
    {
        "olexsmir/gopher.nvim",
        ft = { "go" },
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end
    },
    {
        "nvimtools/none-ls.nvim",
        ft = { "python", "go" },
    },
    {
        "tpope/vim-fugitive"
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }

}
