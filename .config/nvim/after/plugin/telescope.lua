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

