return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "ts_ls",
        "tailwindcss",
        "solargraph",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "eslint_d",
      },
    })
  end,
}
