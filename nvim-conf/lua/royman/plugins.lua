return {
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	},
	{
		  "williamboman/mason.nvim",
		  build = ":MasonUpdate",
		  config = true
		},
		{
		  "williamboman/mason-lspconfig.nvim",
		  dependencies = { "williamboman/mason.nvim" },
		  config = true
		},
		{
		  "neovim/nvim-lspconfig",
		  config = function()
		    -- Beispiel: lua_ls automatisch mit mason installieren und aktivieren
		    require("mason-lspconfig").setup {
		      ensure_installed = { "lua_ls", "pyright" }
		    }

		    local lspconfig = require("lspconfig")

		    -- Beispiel: Lua
		    lspconfig.lua_ls.setup {}

		    -- Beispiel: Python
		    lspconfig.pyright.setup {}
		


		  end
		}

}
