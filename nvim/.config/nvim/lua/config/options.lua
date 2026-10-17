-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- FIXME
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", fg = "NONE" })
--

-- FIXME doesn't actually run here
-- TODO change that bright pink color to anything else
-- vim.cmd.colorscheme("vim")

vim.opt.textwidth = 0
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Disable faint text enter to compelte
vim.g.ai_cmp = false
