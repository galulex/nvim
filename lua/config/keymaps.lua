vim.keymap.set({"n", "i"}, "<D-s>", "<Cmd>w<CR>")
vim.keymap.set({"n", "i"}, "<D-a>", "<esc>ggVG<end>")
vim.keymap.set("n", "<D-c>", '"+y')
vim.keymap.set("n", "<D-v>", '"+p')
vim.keymap.set("i", "<D-v>", '<Esc>"+pa')
vim.keymap.set("c", "<D-v>", '<c-r>+')
vim.keymap.set("t", "<D-v>", '<C-\\><C-N>"+pi')
vim.keymap.set("n", "<D-z>", 'u')
vim.keymap.set("i", "<D-z>", '<Esc>ua')

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set('v', '<C-Up>', '<esc>`<gv:m \'<-2<CR>gv')
vim.keymap.set('v', '<C-Down>', '<esc>`>gv:m \'>+1<CR>gv')
vim.keymap.set('n', '<C-Up>', 'mz:m-2<CR>`z')
vim.keymap.set('n', '<C-Down>', 'mz:m+<CR>`z')
vim.keymap.set('n', '<M-Up>', 'mz:m-2<CR>`z')
vim.keymap.set('n', '<M-Down>', 'mz:m+<CR>`z')

vim.keymap.set("n", "<C-S-tab>", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "<D-t>", "<Cmd>tabnew<CR>")

vim.keymap.set({ "n", "i" }, "<D-[>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<D-Up>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<C-S-tab>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<D-]>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<D-Down>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<C-tab>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<D-w>", "<Cmd>q!<CR>")
vim.keymap.set({ "n", "i" }, "<C-e>", "<Cmd>q!<CR>")

vim.keymap.set("n", "<S-w>", "<Cmd>e %h<CR>")
vim.keymap.set('n', "<S-w>", ":e %:h<CR>")

vim.keymap.set({ "n", "v" }, "<M-Right>", "e")
vim.keymap.set({ "n", "v" }, "<M-Left>", "b")
vim.keymap.set("i", "<M-Right>", "<esc>wi")
vim.keymap.set("i", "<M-Left>", "<esc>bi")

vim.keymap.set("n", "<D-/>", "gcc", { remap = true })
vim.keymap.set("v", "<D-/>", "gc", { remap = true })
vim.keymap.set("i", "<D-/>", "<Esc>gcca", { remap = true })

vim.cmd [[
map gV :Eview<CR>
map gC :Econtroller<CR>
map gM :Emodel<CR>
map gH :Ehelper<CR>
map gJ :Ejavascript<CR>
map gS :Estylesheet<CR>
]]


-- Copilot Tab with fallback
local function copilot_tab_fallback()
  local copilot = require("copilot.suggestion")
  if copilot.is_visible() then
    copilot.accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end

vim.keymap.set("i", "<Tab>", copilot_tab_fallback, { desc = "Accept Copilot or regular Tab" })

-- Enhanced Esc key to dismiss CMP and Copilot suggestions while staying in insert mode
local function enhanced_esc()
  local cmp = require("cmp")
  local copilot = require("copilot.suggestion")

  -- Check if CMP or Copilot is visible
  local cmp_visible = cmp.visible()
  local copilot_visible = copilot.is_visible()

  -- If either is visible, dismiss them and stay in insert mode
  if cmp_visible or copilot_visible then
    if cmp_visible then
      cmp.abort()
    end
    if copilot_visible then
      copilot.dismiss()
    end
    return -- Stay in insert mode
  end

  -- If neither was visible, execute normal Esc behavior (exit insert mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

vim.keymap.set("i", "<Esc>", enhanced_esc, { desc = "Enhanced Esc: dismiss CMP/Copilot and normal Esc" })

-- LSP navigation keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<C-}>", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

-- Zoom keymaps for Neovide
if vim.g.neovide then
  vim.api.nvim_set_keymap("n", "<D-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  2.0)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-0>", ":lua vim.g.neovide_scale_factor = 1.0<CR>", { silent = true })
end
