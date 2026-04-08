
return { 
  'prichrd/netrw.nvim',
  config = function()
    require('netrw').setup({
      icons = {
        symlink = '',
        directory = '',
        file = '',
        svg = 'ﰪ',
      },
      use_devicons = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "netrw",
      callback = function()
        vim.keymap.set("n", "<BS>", "-", { remap = true, buffer = true })
      end,
    })
  end,
}
