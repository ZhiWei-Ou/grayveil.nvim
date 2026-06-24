local source = debug.getinfo(1, "S").source
local spec_dir = vim.fn.getcwd()

if source:sub(1, 1) == "@" then
  spec_dir = vim.fn.fnamemodify(source:sub(2), ":p:h")
end

local root = vim.fn.fnamemodify(spec_dir, ":h")

vim.opt.runtimepath:prepend(root)

local function assert_equal(actual, expected, message)
  if actual ~= expected then
    error(("%s: expected %s, got %s"):format(message, vim.inspect(expected), vim.inspect(actual)), 2)
  end
end

local function to_hex(value)
  if value == nil then
    return nil
  end

  return ("#%06x"):format(value)
end

local function assert_contains(values, expected, message)
  for _, value in ipairs(values) do
    if value == expected then
      return
    end
  end
  error(("%s: expected list to contain %s"):format(message, vim.inspect(expected)), 2)
end

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function clear_terminal_colors()
  for index = 0, 15 do
    vim.g["terminal_color_" .. index] = nil
  end
end

local function clear_modules()
  for _, name in ipairs({
    "grayveil",
    "grayveil.groups",
    "grayveil.palette",
  }) do
    package.loaded[name] = nil
  end
end

local function configure(opts)
  clear_terminal_colors()
  clear_modules()
  require("grayveil").setup(vim.tbl_deep_extend("force", {
    transparent = false,
    terminal_colors = true,
  }, opts or {}))
end

local function load_existing_grayveil_theme()
  configure()
  vim.cmd.colorscheme("grayveil")

  local colors = require("grayveil.palette").get("grayveil").colors

  assert_equal(vim.g.colors_name, "grayveil", "colors_name")
  assert_equal(vim.o.background, "light", "background")
  assert_equal(to_hex(highlight("Normal").fg), colors.fg, "Normal foreground")
  assert_equal(to_hex(highlight("Normal").bg), colors.bg, "Normal background")
  assert_equal(vim.g.terminal_color_1, colors.red, "terminal red")
end

local function load_emberveil_theme()
  configure()
  vim.cmd.colorscheme("emberveil")

  local colors = require("grayveil.palette").get("emberveil").colors

  assert_equal(vim.g.colors_name, "emberveil", "colors_name")
  assert_equal(vim.o.background, "dark", "background")
  assert_equal(to_hex(highlight("Normal").fg), colors.fg, "Normal foreground")
  assert_equal(to_hex(highlight("Normal").bg), colors.bg, "Normal background")
  assert_equal(to_hex(highlight("Directory").fg), colors.blue, "Directory foreground")
  assert_equal(vim.g.terminal_color_3, colors.yellow, "terminal yellow")
end

local function keep_transparent_background()
  configure({
    transparent = true,
    terminal_colors = false,
  })
  vim.cmd.colorscheme("emberveil")

  assert_equal(highlight("Normal").bg, nil, "transparent Normal background")
  assert_equal(highlight("NormalFloat").bg, nil, "transparent float background")
  assert_equal(vim.g.terminal_color_1, nil, "terminal colors disabled")
end

local function list_available_themes()
  configure()

  local color_completions = vim.fn.getcompletion("", "color")

  assert_equal(table.concat(require("grayveil").available_themes(), ","), "grayveil,emberveil", "available themes")
  assert_contains(color_completions, "grayveil", "colorscheme completion")
  assert_contains(color_completions, "emberveil", "colorscheme completion")
end

local tests = {
  { "load_existing_grayveil_theme", load_existing_grayveil_theme },
  { "load_emberveil_theme", load_emberveil_theme },
  { "keep_transparent_background", keep_transparent_background },
  { "list_available_themes", list_available_themes },
}

for _, test in ipairs(tests) do
  local ok, err = pcall(test[2])
  if not ok then
    error(("%s failed\n%s"):format(test[1], err), 0)
  end
  print("ok - " .. test[1])
end
