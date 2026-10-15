return {
  {
    "vimwiki/vimwiki",

    -- Load immediately
    lazy = false,

    init = function()
      vim.g.vimwiki_list = {
        {
          syntax = "markdown",
          ext = ".md",
          path = "~/Notes/vimwiki/",
        },
      }
      vim.g.vimwiki_global_ext = 0

      -- Write an html copy to another folder
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = vim.fn.expand("~/Notes/vimwiki") .. "*.md",
        callback = function()
          vim.cmd([[! pandoc -s --from=markdown+hard_line_breaks
                    \ '%' -o ~/Notes/html/'%:t:r'.html ]])
        end,
      })
    end,

    keys = {
      {
        "<leader>ws",
        "<cmd>VimwikiIndex<cr>:VimwikiSearch ",
        desc = "VimwikiSearch",
      },
      {
        "<leader>wt",
        "<cmd>VimwikiIndex<cr>:VimwikiSearchTags ",
        desc = "VimwikiSearchTags",
      },
      {
        "<leader>wn",
        "<cmd>VimwikiIndex<cr>:VimwikiGoto ",
        desc = "VimwikiGoto",
      },
    },
  },
}
