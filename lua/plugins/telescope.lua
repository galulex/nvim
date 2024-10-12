return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
    require("telescope").setup({
      defaults = {
        preview = {
          filesize_limit = 1, -- MB
        },
        layout_config = { prompt_position="top" },
        sorting_strategy = 'ascending',
        cursor_strategy = 'follow',
        selection_caret=  ' ',
        results_title = '💬',
        multi_icon = '📌',
        prompt_title = '🔍',
        winblend = 40,
      }
    })

    local telescopebuiltin = require("telescope.builtin")
    local function grep_cword()
      return telescopebuiltin.live_grep({ default_text = vim.fn.expand("<cword>") })
    end
    vim.api.nvim_create_user_command("GrepCword", grep_cword, {})
  end,
}
