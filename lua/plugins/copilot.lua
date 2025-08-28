return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    panel = { enabled = true },
    filetypes = {
      markdown = true,
      yaml = true,
      help = true,
    },
  },
}
