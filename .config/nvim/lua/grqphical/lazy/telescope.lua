return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
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
        end,
    },
}
