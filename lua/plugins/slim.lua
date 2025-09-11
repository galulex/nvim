return {
  "slim-template/vim-slim", -- Syntax highlighting for VIM
  enabled = true,
  ft = "slim",
  config = function()
    -- Filetype detection
    vim.filetype.add({
      extension = {
        slim = 'slim',
      }
    })
    
    -- Slim-specific settings
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = "*.slim",
      callback = function()
        vim.bo.filetype = "slim"
        vim.bo.commentstring = "/ %s"
        vim.bo.expandtab = true
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
      end
    })
  end
}
