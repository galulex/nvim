return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Configure LSP servers before enabling them
    -- Biome LSP configuration
    vim.lsp.config.biome = {
      cmd = { 'biome', 'lsp-proxy' },
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "html",
        "svelte"
      },
      root_markers = { 'biome.json', 'biome.jsonc', 'package.json', '.git' },
      single_file_support = true,
      settings = {
        biome = {
          formatter = {
            indentStyle = "space",
            indentWidth = 2
          }
        }
      }
    }

    vim.lsp.config.cssls = {
      cmd = { 'vscode-css-language-server', '--stdio' },
      filetypes = { "css", "scss", "less", "slim" },
      root_markers = { 'package.json', '.git' },
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
    }

    vim.lsp.config.html = {
      cmd = { 'vscode-html-language-server', '--stdio' },
      filetypes = { "html", "slim" },
      root_markers = { 'package.json', '.git' },
    }

    vim.lsp.config.tailwindcss = {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "slim", "eruby" },
      root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'package.json', '.git' },
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
    }

    vim.lsp.config.typos_lsp = {
      cmd = { 'typos-lsp' },
      filetypes = {
        "ruby", "javascript", "typescript", "lua", "markdown", "text",
        "html", "css", "scss", "slim", "eruby", "yaml", "yml", "json",
        "toml", "gitcommit", "dockerfile", "sh", "bash", "zsh"
      },
      root_markers = { '.git' },
    }

    -- Enable LSP servers
    vim.lsp.enable("cssls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("html")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("ruby_lsp")
    vim.lsp.enable("typos_lsp")
    -- vim.lsp.enable("solargraph") -- Disabled to avoid conflicts with ruby_lsp
    vim.lsp.enable("eslint")
    vim.lsp.enable('biome')
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

    -- Biome autoformatting and lint fixes on save using CLI
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = {
        "*.js",
        "*.jsx",
        "*.ts",
        "*.tsx",
        "*.json",
        "*.jsonc",
        "*.css",
        "*.html",
        "*.svelte"
      },
      callback = function()
        local filepath = vim.fn.expand("%:p")
        local bufnr = vim.api.nvim_get_current_buf()
        -- Run biome check with --write to apply safe fixes and format
        vim.fn.system({
          "biome",
          "check",
          "--write",
          "--unsafe",
          filepath
        })
        -- Reload the buffer to get the changes (without triggering another save)
        vim.cmd("checktime")
      end,
    })
  end
}
