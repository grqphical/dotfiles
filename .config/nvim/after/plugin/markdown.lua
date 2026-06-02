vim.fn["mkdp#util#install"]()
vim.g.mkdp_filetypes = { "markdown" }

vim.keymap.set("n", "<leader>pm", vim.cmd.MarkdownPreview)
