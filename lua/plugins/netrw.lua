
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
  end,
}
