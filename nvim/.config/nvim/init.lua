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
-- sheds the giant opaque block in a colorscheme
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "NONE" })

-- LSP
require("mason").setup()
-- :MasonInstall "lang"
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")


-- omnifunc completion
vim.opt.autocomplete = true
vim.opt.complete = "o"
vim.opt.completeopt = "menuone,noselect,popup,fuzzy"
vim.opt.pumheight = 15
vim.opt.pummaxwidth = 80
