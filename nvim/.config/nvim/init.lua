-- Load vim compatible settings
vim.cmd("source ~/.vimrc")

-- Packages
vim.pack.add({
	"https://github.com/vimwiki/vimwiki",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

-- Misc
vim.opt.termguicolors = true


-- LSP
require("mason").setup()
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")


-- omnifunc completion
vim.opt.autocomplete = true
vim.opt.complete = "o"
vim.opt.completeopt = "menuone,noselect,popup,fuzzy"
vim.opt.pumheight = 15
vim.opt.pummaxwidth = 80
