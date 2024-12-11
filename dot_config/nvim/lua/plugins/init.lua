local isVscode = vim.g.vscode == 1

return {
	"tpope/vim-repeat",

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = { "nvim-treesitter" },
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter" },
	},
	{
		"nat-418/boole.nvim",
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
			})
		end,
	},

	{ 'echasnovski/mini.ai', version = '*'  },
	{ 'echasnovski/mini.move', version = '*' },

	--  -----------------------------------------------
	--  Plugins for Neovim in the terminal
	--  -----------------------------------------------
	{ "tpope/vim-commentary", cond = not isVscode },
	{ "luckasRanarison/tree-sitter-hypr", cond = not isVscode },
	{ "NvChad/nvim-colorizer.lua", config = true, cond = not isVscode },
	{ "nvim-tree/nvim-web-devicons", cond = not isVscode },

	{ 'echasnovski/mini.visits', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.statusline', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.pairs', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.cursorword', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.comment', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.fuzzy', version = '*', cond = not isVscode },
	{ 'echasnovski/mini-git', version = '*', cond = not isVscode },
	{ 'echasnovski/mini.animate', version = '*', cond = not isVscode },
	{
    'fei6409/log-highlight.nvim',
		cond = not isVscode,
    config = function()
        require('log-highlight').setup {}
    end,
},


	{
		"nvim-tree/nvim-tree.lua",
		cond = not isVscode,
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			vim.keymap.set("n", "<c-e>", ":NvimTreeFindFileToggle<CR>")

			require("nvim-tree").setup({
				view = {
					adaptive_size = true,
				},
			})

			-- vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=#00000000 guifg=#9da5b3")
		end,
	},
}
