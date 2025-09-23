return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  enabled = true, -- Re-enabled
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 200, -- Increase from default 75ms to reduce frequency
      keymap = {
        accept = "<Tab>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-e>",
      },
    },
    panel = { enabled = false }, -- Disable panel to save completions
    filetypes = {
      markdown = true,
      yaml = true,
      help = true,
    },
  },
}
