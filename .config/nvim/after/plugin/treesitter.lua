require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { 'go', 'python', 'c', 'cpp', 'vimdoc', 'lua', 'html', 'css', 'javascript', 'bash', 'gitcommit', 'gitignore', 'json', 'toml', 'yaml', 'rust' }
