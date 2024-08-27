return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "html", "css", "javascript", "python"},
          sync_install = false,
          highlight = { enable = true, additional_vim_regex_highlighting = false },
          indent = { enable = true },  
        })
    end
 }
