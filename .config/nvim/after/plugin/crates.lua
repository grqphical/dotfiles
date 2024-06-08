vim.keymap.set("n", "<leader>rcu", function ()
    require('crates').upgrade_all_crates()
end)
