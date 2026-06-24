---@file lua/grayveil/init.lua
---@brief Grayveil colorscheme setup and runtime integration.
---@author Oswin
---@email ouzw.mail@gmail.com
---@license Apache-2.0

local M = {}

local defaults = {
  transparent = false,
  terminal_colors = true,
}

M.options = vim.deepcopy(defaults)

local panel_filetypes = {
  ["NvimTree"] = true,
  ["Trouble"] = true,
  ["qf"] = true,
  ["cmake"] = true,
  ["cmake-tools"] = true,
  ["CMakeTools"] = true,
  ["TelescopePrompt"] = true,
  ["TelescopeResults"] = true,
  ["TelescopePreview"] = true,
}

local float_filetypes = {
  ["lazy"] = true,
  ["mason"] = true,
  ["DressingInput"] = true,
  ["DressingSelect"] = true,
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

local function apply_window_highlights()
  local filetype = vim.bo.filetype
  local buftype = vim.bo.buftype
  local name = vim.api.nvim_buf_get_name(0)

  if panel_filetypes[filetype] or buftype == "quickfix" or name:find("CMakeTools", 1, true) then
    vim.wo.winhighlight = table.concat({
      "Normal:GrayveilPanelNormal",
      "NormalNC:GrayveilPanelNormal",
      "EndOfBuffer:GrayveilPanelEndOfBuffer",
      "SignColumn:GrayveilPanelSignColumn",
      "LineNr:GrayveilPanelLineNr",
      "CursorLine:GrayveilPanelCursorLine",
      "CursorLineNr:GrayveilPanelCursorLineNr",
    }, ",")
    return
  end

  if float_filetypes[filetype] then
    vim.wo.winhighlight = table.concat({
      "Normal:GrayveilFloatNormal",
      "NormalFloat:GrayveilFloatNormal",
      "FloatBorder:GrayveilFloatBorder",
      "EndOfBuffer:GrayveilFloatNormal",
    }, ",")
    return
  end

  if vim.wo.winhighlight:find("Grayveil", 1, true) then
    vim.wo.winhighlight = ""
  end
end

function M.available_themes()
  return require("grayveil.palette").names()
end

function M.load(theme)
  local selected_theme = require("grayveil.palette").get(theme)

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end

  vim.o.termguicolors = true
  vim.o.background = selected_theme.background
  vim.o.guicursor = table.concat({
    "n-v-c:block-Cursor",
    "i-ci-ve:ver25-Cursor",
    "r-cr:hor20-Cursor",
    "o:hor50-Cursor",
  }, ",")
  vim.g.colors_name = selected_theme.name

  local palette = selected_theme.colors
  local groups = require("grayveil.groups").get(palette, M.options)

  for group, value in pairs(groups) do
    vim.api.nvim_set_hl(0, group, value)
  end

  if M.options.terminal_colors then
    vim.g.terminal_color_0 = palette.bg_status
    vim.g.terminal_color_1 = palette.red
    vim.g.terminal_color_2 = palette.green
    vim.g.terminal_color_3 = palette.yellow
    vim.g.terminal_color_4 = palette.blue
    vim.g.terminal_color_5 = palette.purple
    vim.g.terminal_color_6 = palette.cyan
    vim.g.terminal_color_7 = palette.fg_soft
    vim.g.terminal_color_8 = palette.fg_faint
    vim.g.terminal_color_9 = palette.red
    vim.g.terminal_color_10 = palette.green
    vim.g.terminal_color_11 = palette.yellow
    vim.g.terminal_color_12 = palette.blue
    vim.g.terminal_color_13 = palette.purple
    vim.g.terminal_color_14 = palette.cyan
    vim.g.terminal_color_15 = palette.fg
  end

  local group = vim.api.nvim_create_augroup("grayveil_window_highlights", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
    group = group,
    callback = apply_window_highlights,
  })
  vim.schedule(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_call(win, apply_window_highlights)
      end
    end
  end)
end

return M
