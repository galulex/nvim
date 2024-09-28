return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
    require("telescope").setup()

    local telescopebuiltin = require("telescope.builtin")
    local function grep_cword()
      return telescopebuiltin.live_grep({ default_text = vim.fn.expand("<cword>") })
    end
    vim.api.nvim_create_user_command("GrepCword", grep_cword, {})
  end,
}
