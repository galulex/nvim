local ignore_filetypes_list = {
    "venv", "__pycache__", "%.xlsx", "%.jpg", "%.png", "%.webp", "%.svg", "%.log",
    "%.pdf", "%.odt", "%.ico", "vcr/", "node_modules/", "storage/", "tmp/", "fixtures/"
}

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = ignore_filetypes_list,
        preview = {
          filesize_limit = 1, -- MB
          treesitter = false,
        },
        layout_config = { prompt_position="top" },
        sorting_strategy = 'ascending',
        cursor_strategy = 'follow',
        selection_caret=  '👉🏻',
        results_title = '💬',
        multi_icon = '📌',
        prompt_title = '🔍',
        winblend = 50,
      }
    })

    local telescopebuiltin = require("telescope.builtin")
    local function grep_cword()
      return telescopebuiltin.live_grep({ default_text = vim.fn.expand("<cword>"), only_sort_text = true })
    end
    vim.api.nvim_create_user_command("GrepCword", grep_cword, {})
  end,
}
