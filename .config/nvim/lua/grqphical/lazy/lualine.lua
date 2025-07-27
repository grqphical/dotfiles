return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local custom_theme = require('lualine.themes.auto')

        custom_theme.normal.c.bg = 'NONE'
        custom_theme.normal.b.bg = 'NONE'
        custom_theme.insert.c.bg = 'NONE'
        custom_theme.command.c.bg = 'NONE'
        custom_theme.visual.c.bg = 'NONE'

        require("lualine").setup {
            options = { theme = custom_theme },
        }
    end,
}
