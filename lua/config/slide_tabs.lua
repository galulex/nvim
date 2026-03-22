local swipe_timer     = nil
local swipe_anim      = nil
local swipe_active    = false
local swipe_count     = 0
local swipe_overlay   = nil  -- { wins, direction, focused, tab_views, tab_widths, tab_wraps }
local swipe_width     = 0.0
local swipe_target    = 0.0
local SWIPE_THRESHOLD = 8
local SWIPE_STEP      = 8

local function get_adjacent_tab(direction)
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs < 2 then return nil end
  local cur = vim.api.nvim_get_current_tabpage()
  local idx = 1
  for i, t in ipairs(tabs) do
    if t == cur then idx = i; break end
  end
  local next_idx = direction == "right"
    and (idx % #tabs) + 1
    or  ((idx - 2) % #tabs) + 1
  return tabs[next_idx]
end

local function stop_anim()
  if swipe_anim then swipe_anim:stop(); swipe_anim = nil end
end

local function update_overlay()
  if not swipe_overlay then return end
  local cols     = vim.o.columns
  local fraction = swipe_width / cols
  -- shrink existing windows proportionally so overlay spans full editor
  if swipe_overlay.tab_widths then
    for win, orig_w in pairs(swipe_overlay.tab_widths) do
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_set_width, win, math.max(1, math.floor(orig_w * (1 - fraction))))
      end
    end
  end
  -- resize each overlay window proportionally to its original width
  if swipe_overlay.wins then
    for _, info in ipairs(swipe_overlay.wins) do
      if vim.api.nvim_win_is_valid(info.win) then
        pcall(vim.api.nvim_win_set_width, info.win,
          math.max(1, math.floor(info.orig_width * swipe_width / cols)))
      end
    end
  end
  -- lock scroll positions to prevent wrap reflow
  if swipe_overlay.tab_views then
    for win, view in pairs(swipe_overlay.tab_views) do
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_call, win, function() vim.fn.winrestview(view) end)
      end
    end
  end
end

local function restore_tab_wins(overlay)
  if not overlay then return end
  if overlay.tab_wraps then
    for win, wrap in pairs(overlay.tab_wraps) do
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_call(win, function() vim.wo.wrap = wrap end)
      end
    end
  end
  if overlay.tab_widths then
    for win, orig_w in pairs(overlay.tab_widths) do
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_set_width, win, orig_w)
      end
    end
  end
end

local function close_overlay()
  if swipe_overlay then
    -- Close overlay windows first so Neovim redistributes before we restore
    if swipe_overlay.wins then
      for _, info in ipairs(swipe_overlay.wins) do
        pcall(vim.api.nvim_win_close, info.win, true)
      end
    end
    restore_tab_wins(swipe_overlay)
    swipe_overlay = nil
    swipe_width  = 0.0
    swipe_target = 0.0
  end
end

local function complete_swipe()
  local direction = swipe_overlay and swipe_overlay.direction
  local saved_overlay = swipe_overlay
  stop_anim()
  swipe_active = true
  swipe_overlay = nil
  swipe_width  = 0.0
  swipe_target = 0.0
  vim.cmd(direction == "right" and "tabnext" or "tabprevious")
  -- Close overlay windows (on old tab) then restore their widths/wrap
  if saved_overlay and saved_overlay.wins then
    for _, info in ipairs(saved_overlay.wins) do
      pcall(vim.api.nvim_win_close, info.win, true)
    end
  end
  restore_tab_wins(saved_overlay)
end

local function start_anim()
  if swipe_anim then return end
  swipe_anim = vim.uv.new_timer()
  swipe_anim:start(0, 16, vim.schedule_wrap(function()
    if not swipe_overlay then stop_anim(); return end
    local diff = swipe_target - swipe_width
    swipe_width = math.abs(diff) < 0.5 and swipe_target or (swipe_width + diff * 0.35)
    local cols = vim.o.columns
    if swipe_target >= cols and swipe_width >= cols - 0.5 then
      stop_anim(); complete_swipe()
    elseif swipe_target <= 0 and swipe_width <= 0.5 then
      stop_anim(); close_overlay()
    else
      update_overlay()
    end
  end))
end

local function cancel_swipe()
  swipe_target = 0.0
  start_anim()
end

local function create_overlay(direction)
  local src_tab = get_adjacent_tab(direction)
  if not src_tab then return end
  local cur_win = vim.api.nvim_get_current_win()
  local cols = vim.o.columns
  local tab_views = {}
  local tab_widths = {}
  local tab_wraps = {}
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    tab_views[w]  = vim.api.nvim_win_call(w, vim.fn.winsaveview)
    tab_widths[w] = vim.api.nvim_win_get_width(w)
    tab_wraps[w]  = vim.api.nvim_win_call(w, function() return vim.wo.wrap end)
    vim.api.nvim_win_call(w, function() vim.wo.wrap = false end)
  end
  -- Create the entry vsplit for the overlay area
  local split_cmd = direction == "right" and "noautocmd botright vsplit" or "noautocmd topleft vsplit"
  vim.cmd(split_cmd)
  -- Clone target tab's full split layout into the overlay area
  local overlay_wins = {}  -- list of { win, orig_width }
  local src_tabnr = vim.api.nvim_tabpage_get_number(src_tab)
  local layout = vim.fn.winlayout(src_tabnr)
  local function setup_win(win, src_win)
    vim.api.nvim_win_set_buf(win, vim.api.nvim_win_get_buf(src_win))
    local view = vim.api.nvim_win_call(src_win, vim.fn.winsaveview)
    vim.api.nvim_win_call(win, function() vim.fn.winrestview(view) end)
    vim.api.nvim_win_call(win, function() vim.wo.wrap = false end)
    for _, o in ipairs({ "number", "relativenumber", "signcolumn", "cursorline" }) do
      local val = vim.api.nvim_win_call(src_win, function() return vim.wo[o] end)
      vim.api.nvim_win_call(win, function() vim.wo[o] = val end)
    end
    table.insert(overlay_wins, { win = win, orig_width = vim.api.nvim_win_get_width(src_win) })
  end
  local function clone_layout(node)
    if node[1] == "leaf" then
      setup_win(vim.api.nvim_get_current_win(), node[2])
      return
    end
    local children = node[2]
    local cmd = node[1] == "col" and "noautocmd rightbelow split" or "noautocmd rightbelow vsplit"
    local first = vim.api.nvim_get_current_win()
    local child_wins = { first }
    for i = 2, #children do
      vim.cmd(cmd)
      child_wins[i] = vim.api.nvim_get_current_win()
    end
    for i, child in ipairs(children) do
      vim.api.nvim_set_current_win(child_wins[i])
      clone_layout(child)
    end
  end
  clone_layout(layout)
  -- Set all overlay windows to width 1 and restore focus
  for _, info in ipairs(overlay_wins) do
    pcall(vim.api.nvim_win_set_width, info.win, 1)
  end
  vim.api.nvim_set_current_win(cur_win)
  swipe_overlay = { wins = overlay_wins, direction = direction, focused = false,
                    tab_views = tab_views, tab_widths = tab_widths, tab_wraps = tab_wraps }
  swipe_width  = 1.0
  swipe_target = 1.0
end

local function swipe_tab(direction)
  if swipe_active then
    if swipe_timer then swipe_timer:stop() end
    swipe_timer = vim.uv.new_timer()
    swipe_timer:start(120, 0, vim.schedule_wrap(function()
      swipe_timer = nil
      swipe_active = false
    end))
    return
  end
  if swipe_overlay and swipe_overlay.direction ~= direction then
    stop_anim(); cancel_swipe(); swipe_count = 0
    return
  end
  swipe_count = swipe_count + 1
  if swipe_count == SWIPE_THRESHOLD then
    create_overlay(direction)
  elseif swipe_count > SWIPE_THRESHOLD and swipe_overlay then
    swipe_target = math.min(swipe_target + SWIPE_STEP, vim.o.columns)
    start_anim()
  end
  if swipe_timer then swipe_timer:stop() end
  swipe_timer = vim.uv.new_timer()
  swipe_timer:start(150, 0, vim.schedule_wrap(function()
    swipe_timer = nil
    swipe_count = 0
    if swipe_overlay then
      if swipe_width >= vim.o.columns * 0.5 then
        swipe_target = vim.o.columns
        start_anim()
      else
        cancel_swipe()
      end
    end
  end))
end

-- vertical scroll resets horizontal swipe count to prevent diagonal triggers
local function reset_swipe()
  if not swipe_overlay then swipe_count = 0 end
end

return { swipe_tab = swipe_tab, reset_swipe = reset_swipe }
