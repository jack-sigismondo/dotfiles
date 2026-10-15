-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- FIXME
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "NONE" })
--

vim.opt.textwidth = 0
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Disable faint text enter to compelte
vim.g.ai_cmp = false
