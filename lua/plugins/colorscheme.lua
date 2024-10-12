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

    hi DiagnosticWarnTablineFillTab guibg=#ABB2BF
    hi DiagnosticErrorTablineFillTab guibg=#ABB2BF
    hi DiagnosticInfoTablineFillTab guibg=#ABB2BF
    hi DiagnosticHintTablineFillTab guibg=#ABB2BF

    hi SatelliteSearch guifg=white
    hi SatelliteSearchCurrent guifg=yellow

    hi NoiceCmdlinePopup guibg=black blend=30

    hi Pmenu guibg=#161b22 gui=bold
    hi PmenuSel guibg=#98C379 gui=bold
    hi PmenuSbar guibg=#161b22
    hi PmenuThumb guibg=#30363d
    hi CursorLineNr guifg=#98c279
    hi lualine_c_normal guibg=NONE
    ]]

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
