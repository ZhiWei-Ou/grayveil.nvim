---@file lua/grayveil/palette.lua
---@brief Color palette for grayveil.nvim.
---@author Oswin
---@email ouzw.mail@gmail.com
---@license Apache-2.0

local M = {}

local theme_names = {
  "grayveil",
  "emberveil",
}

M.themes = {
  grayveil = {
    name = "grayveil",
    background = "light",
    colors = {
      bg = "#d8d9df",
      bg_alt = "#d0d1d7",
      bg_float = "#b9bcc5",
      bg_sidebar = "#cbccd1",
      bg_panel = "#cbccd1",
      bg_panel_line = "#e0e1e6",
      bg_hover = "#d9dbe1",
      bg_status = "#b4b8c1",
      fg = "#17213a",
      fg_soft = "#434b60",
      fg_muted = "#707684",
      fg_faint = "#9096a4",
      border = "#dcdee4",
      border_muted = "#b8bbc4",
      selection = "#c7cbd3",
      visual = "#c5cad3",
      cursor = "#2f527d",
      cursor_fg = "#f4f7fb",
      line = "#ccd0d8",
      red = "#8d4d5d",
      orange = "#8b6249",
      yellow = "#75683e",
      green = "#5d7b6c",
      cyan = "#587b85",
      blue = "#4f6f96",
      purple = "#796996",
      pink = "#96576a",
      accent = "#9a4f61",
      diff_add_bg = "#c6cec8",
      diff_change_bg = "#c4c9d2",
      diff_delete_bg = "#cec1c6",
      diff_text_bg = "#bac1cc",
      search_bg = "#bdc3cd",
      inc_search_bg = "#a6b2c2",
      substitute_bg = "#b09a8a",
      dropbar_current_context = "#c2c7d0",
      dropbar_hover = "#c4c9d1",
      none = "NONE",
    },
  },
  emberveil = {
    name = "emberveil",
    background = "dark",
    colors = {
      bg = "#050505",
      bg_alt = "#0d0c0b",
      bg_float = "#15110f",
      bg_sidebar = "#0a0908",
      bg_panel = "#070707",
      bg_panel_line = "#1c130f",
      bg_hover = "#19120f",
      bg_status = "#0a0807",
      fg = "#d8d0c8",
      fg_soft = "#b6aaa2",
      fg_muted = "#8f8580",
      fg_faint = "#6d6460",
      border = "#d9865f",
      border_muted = "#7a4a34",
      selection = "#2a211d",
      visual = "#34241d",
      cursor = "#d9865f",
      cursor_fg = "#050505",
      line = "#14100e",
      red = "#d8736a",
      orange = "#d9865f",
      yellow = "#c8aa5e",
      green = "#7fbf7a",
      cyan = "#6db6c2",
      blue = "#7fa6d9",
      purple = "#b77adf",
      pink = "#d789b7",
      accent = "#d9865f",
      builtin = "#b6aaa2",
      constant = "#d9865f",
      function_builtin = "#7fa6d9",
      property = "#b6aaa2",
      diff_add_bg = "#102215",
      diff_change_bg = "#111d2c",
      diff_delete_bg = "#2a1212",
      diff_text_bg = "#233047",
      search_fg = "#050505",
      search_bg = "#c8aa5e",
      inc_search_bg = "#d9865f",
      substitute_fg = "#f3e6d8",
      substitute_bg = "#513226",
      dropbar_current_context = "#1a120e",
      dropbar_hover = "#251914",
      none = "NONE",
    },
  },
}

M.colors = M.themes.grayveil.colors

function M.get(name)
  name = name or "grayveil"
  local theme = M.themes[name]
  if theme == nil then
    error(("grayveil.nvim: unknown theme '%s'"):format(tostring(name)), 2)
  end

  return theme
end

function M.names()
  local names = {}
  for index, name in ipairs(theme_names) do
    names[index] = name
  end
  return names
end

return M
