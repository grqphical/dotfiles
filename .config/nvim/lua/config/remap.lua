local builtin = require('telescope.builtin')

vim.g.mapleader = " "
-- Open NetRW
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Copy selection to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Remap CTRL+C to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Apply code action
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action({ apply = true }) end)

-- Format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
end)

-- Golang Specific: Insert if err != nil
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Find files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Find Git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Grep find
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep> ") })
end, {})
