return {
  "tpope/vim-rails",
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "Rails",
      callback = function()
        vim.opt.tags = "./tmp/tags"
      end,
    })
  end,
}
