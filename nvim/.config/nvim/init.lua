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
vim.cmd("colorscheme catppuccin")
vim.cmd("colorscheme vim")

-- Sheds the giant opaque block in a colorscheme
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "NONE" })

-- LSP
require("mason").setup()
-- :MasonInstall "lang"
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("lsp-language-server")

-- omnifunc completion
-- vim.opt.autocomplete = true
vim.opt.complete = "o"
vim.opt.completeopt = "menuone,noselect,popup,fuzzy"

-- Disable automatic completion menus
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = false,
            })
        end
    end,
})

vim.opt.pumheight = 15
vim.opt.pummaxwidth = 80
vim.keymap.set("i", "<C-Space>", function()
	vim.lsp.completion.get()
end, { desc = "LSP Completion" })
