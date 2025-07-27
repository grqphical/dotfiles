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
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>dc', vim.lsp.buf.signature_help)

vim.keymap.set('n', '<leader>sc', ':so %<CR>')


-- Golang Specific: Insert if err != nil
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
