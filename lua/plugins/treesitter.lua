return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    require('nvim-ts-autotag').setup({
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      }
    })

    treesitter.setup({
      sync_install = true,
      ignore_install = {""},
      auto_install = true,
      modules = {},
      highlight = { enable = true, additional_vim_regex_highlighting = false, },
      indent = { enable = true },
      endwise = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "slim",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "ruby",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      rainbow = {
        enable = true,
        disable = { "html" },
        extended_mode = false,
        max_file_lines = 1000,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
