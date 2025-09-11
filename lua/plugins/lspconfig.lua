return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    vim.lsp.enable("cssls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("html")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("ruby_lsp")
    -- vim.lsp.enable("solargraph") -- Disabled to avoid conflicts with ruby_lsp
    vim.lsp.enable("eslint")
    -- vim.lsp.enable('biome')

    local lspconfig = require('lspconfig')

    lspconfig.cssls.setup({
      filetypes = { "css", "scss", "less", "slim" }, -- Add Slim support
      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore",
          },
        },
        scss = {
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })
    
    lspconfig.html.setup({
      filetypes = { "html", "slim" }, -- Add HTML completion for Slim
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      callback = function()
        vim.lsp.start {
          name = "rubocop",
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
        }
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rb",
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
}
