<h1 align="center">grayveil.nvim</h1>

<p align="center">Soft gray and ember-dark Neovim colorschemes tuned for calm, readable coding.</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache--2.0-blue.svg" alt="License"></a>
</p>

<p align="center">
  <a href="#installation">Installation</a> ·
  <a href="#configuration">Configuration</a> ·
  <a href="https://github.com/ZhiWei-Ou/grayveil.nvim/issues">Issues</a>
</p>

| `grayveil` | `emberveil` |
| --- | --- |
| ![grayveil: light gray editor with muted syntax colors](assets/preview.png) | ![emberveil: black editor with warm orange accents](assets/emberveil-preview.png) |

## Features

- **Two variants in one plugin**
  - `grayveil` — a light gray palette with muted, low-saturation syntax colors.
  - `emberveil` — a dark, terminal-inspired palette with black surfaces, warm orange accents, and softened syntax colors.
- **Distinct supporting panels** — file trees, quickfix, Telescope, Trouble, and floating windows such as Lazy and Mason get their own surfaces, so the editing area stays clear.
- **Plugin coverage** — Treesitter, LSP semantic tokens, diagnostics, Telescope, nvim-tree, Trouble, nvim-cmp, Mason, Lazy, Noice, which-key, dropbar, GitSigns, and lualine.
- **Optional transparent background** and **terminal colors** for `:terminal`.

## Quick Start

With [lazy.nvim](https://github.com/folke/lazy.nvim), add this spec:

```lua
{
  "ZhiWei-Ou/grayveil.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("grayveil").setup()
    vim.cmd.colorscheme("grayveil") -- or "emberveil"
  end,
}
```

Restart Neovim; `:colorscheme` should print `grayveil`.

## Installation

The colorschemes work without calling `setup()`. Call it only to change the
[options](#configuration), and do so **before** running `:colorscheme`.

### lazy.nvim

See [Quick Start](#quick-start).

### vim.pack (Neovim 0.12+)

```lua
vim.pack.add({ "https://github.com/ZhiWei-Ou/grayveil.nvim" })

require("grayveil").setup()
vim.cmd.colorscheme("grayveil")
```

### mini.deps

```lua
MiniDeps.add("ZhiWei-Ou/grayveil.nvim")

require("grayveil").setup()
vim.cmd.colorscheme("grayveil")
```

### packer.nvim

```lua
use({
  "ZhiWei-Ou/grayveil.nvim",
  config = function()
    require("grayveil").setup()
    vim.cmd.colorscheme("grayveil")
  end,
})
```

### vim-plug

```vim
call plug#begin()
Plug 'ZhiWei-Ou/grayveil.nvim'
call plug#end()

colorscheme grayveil
```

### Native packages

```sh
git clone https://github.com/ZhiWei-Ou/grayveil.nvim \
  ~/.local/share/nvim/site/pack/plugins/start/grayveil.nvim
```

Then add `vim.cmd.colorscheme("grayveil")` to your `init.lua`.

## Usage

Switch between the variants at any time:

```vim
:colorscheme grayveil
:colorscheme emberveil
```

Or from Lua:

```lua
vim.cmd.colorscheme("emberveil")
```

Loading either colorscheme enables `termguicolors` and sets `guicursor` so the
cursor uses the theme's `Cursor` highlight.

## Configuration

Defaults:

```lua
require("grayveil").setup({
  transparent = false,
  terminal_colors = true,
})
```

| Option | Default | Description |
| --- | --- | --- |
| `transparent` | `false` | Clear the background of the editor, floats, sidebars, panels, and statusline so the terminal background shows through. |
| `terminal_colors` | `true` | Set `g:terminal_color_0` to `g:terminal_color_15` from the active palette. |

Options apply the next time a colorscheme is loaded. To change them at runtime,
call `setup()` again and re-run `:colorscheme`.

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/ZhiWei-Ou/grayveil.nvim/issues).

Run the headless Neovim smoke tests before sending changes:

```sh
make test
```

## License

[Apache-2.0](LICENSE)
