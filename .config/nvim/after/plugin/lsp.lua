local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local lsp_util = require "lspconfig/util"

local function formatIfSupported()
    local supported_filetypes = { 'python', 'go', 'lua' }
    local current_filetype = vim.bo.filetype

    for _, supported_type in ipairs(supported_filetypes) do
        if current_filetype == supported_type then
            vim.cmd('LspZeroFormat')
            return
        end
    end
end



lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = formatIfSupported

    })
end)

require('mason').setup({
    ensure_installed = { 'mypy', 'ruff', 'gofmt', 'goimports-reviser', 'golines' },
})

require('mason-lspconfig').setup({
    ensure_installed = { 'pyright', 'gopls', 'lua_ls', 'html', 'emmet_ls', 'cssls', 'ruff' },
    handlers = {
        lsp.default_setup,
        gopls = function()
            lspconfig.gopls.setup({
                filetypes = { "go", "gowork", "gomod", "gotmpl" },
                cmd = { "gopls" },
                root_dir = lsp_util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        }
                    }
                }
            })
        end,
        pyright = function()
            lspconfig.pyright.setup({
                filetypes = { "python" },
            })
        end
    }
})
