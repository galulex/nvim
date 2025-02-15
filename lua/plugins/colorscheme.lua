return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme onedark_dark")

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { ctermfg = 8 })

    vim.cmd [[
    hi TabLineSelSeparator guibg=NONE guifg=#ABB2BF
    hi TabLineSeparator guibg=NONE guifg=#ABB2BF
    hi TabLineSel guibg=NONE guifg=Normal gui=bold
    hi TabLineFillTab guibg=#ABB2BF guifg=black
    hi TabLineBrand guifg=#f4468f gui=bold
    hi DiagnosticWarnTablineSel guibg=NONE
    hi DiagnosticErrorTablineSel guibg=NONE
    hi DiagnosticInfoTablineSel guibg=NONE
    hi DiagnosticHintTablineSel guibg=NONE

    hi DiagnosticWarnTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticErrorTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticInfoTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticHintTablineFillTab guibg=#ABB2BF guifg=black

    hi SatelliteSearch guifg=white
    hi SatelliteSearchCurrent guifg=yellow

    hi NoiceCmdlinePopup guibg=black blend=30

    " hi Pmenu guibg=#161b22
    hi PmenuSel guibg=#30363d gui=bold
    hi PmenuSbar guibg=#161b22
    hi PmenuThumb guibg=#30363d
    hi CursorLineNr guifg=#98c279
    hi lualine_c_normal guibg=NONE

    hi LuaLineTimeMinutes guifg=#aff05b
    hi LuaLineTimeSplit guifg=#b6e84e
    hi LuaLineTimeHours guifg=#bfde43
    hi LuaLineTimeIcon guifg=#c8d43a
    hi LuaLineLinesTotal guifg=#d2c934
    hi LuaLineLinesTotalIcon guifg=#dcbe30
    hi LuaLineLinesY guifg=#e6b32e
    hi LuaLineLinesYIcon guifg=#efa72f
    hi LuaLineLinesX guifg=#f89b31
    hi LuaLineLinesXIcon guifg=#ff9036
    hi LuaLineLinesXPreIcon guifg=#ff843d
    ]]

    local colors = {
      "#98c279", "#a0c279", "#a8c279", "#b0c27a", "#b8c17a", 
      "#c0c07a", "#c8bf7a", "#cfbe7a", "#d6bd7b", "#ddbc7b", 
      "#e3bb7b", "#e5ba7a", "#e5b97a", "#e5b77a", "#e5b679", 
      "#e5b479", "#e5b278", "#e5b077", "#e5ae76", "#e5c07b"
    }

    local gradient = {
      '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
      '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
      '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
      '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
    }

    -- vim.api.nvim_set_hl(0, 'CursorLineNr', { cterm = 'NONE', ctermbg = 236, ctermfg = 7 })

    -- vim.api.nvim_create_autocmd("InsertEnter", {
    --   pattern = "*",
    --   callback = function()
    --     vim.api.nvim_set_hl(0, 'CursorLine', { term = 'NONE', cterm = 'NONE', ctermbg = 0, ctermfg = 'NONE' })
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("InsertLeave", {
    --   pattern = "*",
    --   callback = function()
    --     vim.api.nvim_set_hl(0, 'CursorLine', { term = 'NONE', cterm = 'bold', ctermbg = 236, ctermfg = 'NONE' })
    --   end,
    -- })
  end,
}
