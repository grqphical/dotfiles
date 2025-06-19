return {
    {
        "L3MON4D3/LuaSnip",
        tag = "v2.4.0",
        build = "make install_jsregexp",
        config = function()
            require("luasnip").config.set_config({
                enable_autosnippers = true,
                store_selection_keys = "<Tab>"
            })

            local map = vim.keymap.set
            local opts = { silent = true, expr = true }

            -- Expand or jump in insert mode
            map("i", "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", opts)

            -- Jump forward through tabstops in visual mode
            map("s", "<Tab>", "luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'", opts)

            -- Jump backward through tabstops
            map("i", "<S-Tab>", "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'", opts)
            map("s", "<S-Tab>", "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'", opts)

            -- Cycle through choice nodes
            map("i", "<C-f>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'", opts)
            map("s", "<C-f>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'", opts)

            require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
        end
    }
}
