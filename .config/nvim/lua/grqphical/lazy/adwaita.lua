return {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    
    -- configure and set on startup
    config = function()
        vim.g.adwaita_disable_cursorline = true 
        vim.g.adwaita_transparent = true        
        vim.cmd('colorscheme adwaita')

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
