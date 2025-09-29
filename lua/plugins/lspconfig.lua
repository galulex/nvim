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
    vim.lsp.enable("typos_lsp")
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

    lspconfig.tailwindcss.setup({
      filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "slim", "eruby" },
      init_options = {
        userLanguages = {
          slim = "html",
          eruby = "html",
        },
      },
      settings = {
        tailwindCSS = {
          includeLanguages = {
            slim = "html",
            eruby = "html",
          },
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          experimental = {
            classRegex = {
              -- Standard HTML class attributes
              "class\\s*=\\s*[\"']([^\"']*)[\"']",
              -- Slim shorthand syntax
              "\\.([-\\w]+)",
              -- Slim with element: div.class-name
              "\\w+\\.([-\\w]+)",
              -- Multiple classes in Slim: .class1.class2
              "\\.([-\\w]+(?:\\.[-\\w]+)*)",
            },
          },
        },
      },
    })

    lspconfig.typos_lsp.setup({
      filetypes = {
        "ruby", "javascript", "typescript", "lua", "markdown", "text",
        "html", "css", "scss", "slim", "eruby", "yaml", "yml", "json",
        "toml", "gitcommit", "dockerfile", "sh", "bash", "zsh"
      },
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local diagnostics = vim.diagnostic.get(0, {lnum = vim.fn.line('.') - 1})
        if #diagnostics == 0 then
          return
        end

        -- Get the highest severity diagnostic
        local highest_severity = diagnostics[1].severity
        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity < highest_severity then
            highest_severity = diagnostic.severity
          end
        end

        -- Map severity to border highlight
        local border_highlight = "FloatBorder"
        if highest_severity == vim.diagnostic.severity.ERROR then
          border_highlight = "DiagnosticFloatingError"
        elseif highest_severity == vim.diagnostic.severity.WARN then
          border_highlight = "DiagnosticFloatingWarn"
        elseif highest_severity == vim.diagnostic.severity.INFO then
          border_highlight = "DiagnosticFloatingInfo"
        elseif highest_severity == vim.diagnostic.severity.HINT then
          border_highlight = "DiagnosticFloatingHint"
        end

        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = {
            {"╭", border_highlight},
            {"─", border_highlight},
            {"╮", border_highlight},
            {"│", border_highlight},
            {"╯", border_highlight},
            {"─", border_highlight},
            {"╰", border_highlight},
            {"│", border_highlight},
          },
          header = "",
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })


    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rb",
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
}
