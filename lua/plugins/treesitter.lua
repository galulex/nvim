return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      sync_install = true,
      ignore_install = {""},
      auto_install = true,
      modules = {},
      highlight = { enable = true, additional_vim_regex_highlighting = false, },
      indent = { enable = true },
      autotag = { enable = true, },
      endwise = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
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
  end,
}
