local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "EdenEast/nightfox.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    'mbbill/undotree',
    'tpope/vim-fugitive',
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'nvim-tree/nvim-web-devicons' },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        'sudormrfbin/cheatsheet.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
    },

    -- RUST PLUGINS
    {
        'saecki/crates.nvim',
        tag = 'stable',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = { "rust", "toml" },
        config = function()
            require('crates').setup()
        end,
    },
    -- GO PLUGINS
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
    }
})
