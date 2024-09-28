return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme onedark")

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { ctermfg = 8 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { ctermfg = 8 })

    vim.cmd [[
    hi BufferInactiveSign guifg=black guibg=NONE
    hi BufferInactive guibg=black
    hi BufferInactiveWARN guibg=black
    hi BufferInactiveERROR guibg=black
    hi BufferInactiveHINT guibg=black
    hi BufferInactiveINFO guibg=black
    hi BufferCurrentWARN guibg=black
    hi BufferCurrentERROR guibg=black
    hi BufferCurrentHINT guibg=black
    hi BufferCurrentINFO guibg=black


    hi Pmenu guibg=#161b22 gui=bold
    hi PmenuSel guibg=#98C379 gui=bold
    hi PmenuSbar guibg=#161b22
    hi PmenuThumb guibg=#30363d
    hi CursorLineNr guifg=#98c279
    hi DiagnosticInfo guibg=black
    hi DiagnosticHint guibg=black
    hi DiagnosticWarn guibg=black
    hi DiagnosticError guibg=black
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
