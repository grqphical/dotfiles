return {
	"nvimtools/none-ls.nvim",
	ft = { "python", "go", "lua" },
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			on_attach = function(client, bufnr)
				-- format on save functionality
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false, bufnr = bufnr })
						end,
					})
				end
			end,
			sources = {
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.black,

				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports_reviser,
				null_ls.builtins.formatting.golines,

				null_ls.builtins.formatting.stylua,
			},
		})
	end,
}
