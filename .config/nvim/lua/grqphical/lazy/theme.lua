return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,

	-- configure and set on startup
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
		})

		vim.cmd("colorscheme catppuccin")

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	end,
}
