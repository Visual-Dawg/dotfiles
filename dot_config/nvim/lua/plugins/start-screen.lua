local isVscode = vim.g.vscode == 1

return {
	'echasnovski/mini.nvim',
	cond = not isVscode,
	version = '*' 
}
