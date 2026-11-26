# nvim dependencies

Stowing this package links `~/.config/nvim`. `init.lua` loads `lua/config/` (options, keymaps, autocmds) and then lazy.nvim, which installs every plugin spec in `lua/plugins/` on first launch, pinned to the commits in `lazy-lock.json`. Colors come from tokyonight with a transparent background, not from pywal16. Install the following first.

## Required

| Dependency | Why | Install docs |
|---|---|---|
| Neovim >= 0.12 | nvim-treesitter's `main` branch (`plugins/treesitter.lua`) needs 0.12; the config also uses `vim.lsp.config()` / `vim.lsp.enable()` and `vim.hl.on_yank()`. Tested on 0.12.6 | https://github.com/neovim/neovim/blob/master/INSTALL.md |
| git | `config/lazy.lua` clones lazy.nvim, which clones every plugin; vim-fugitive and gitsigns run it too | https://git-scm.com/downloads |
| make + a C compiler (gcc or clang) | Build steps for telescope-fzf-native (`make`) and LuaSnip (`make install_jsregexp`), and nvim-treesitter compiles each parser | https://www.gnu.org/software/make/ |
| tree-sitter CLI >= 0.26.1 | nvim-treesitter's `main` branch generates parsers with it. Install it from your package manager, not npm | https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md |
| curl, tar, unzip, gzip | nvim-treesitter downloads parser sources with `curl` and `tar`; Mason downloads and unpacks the language servers; blink.cmp downloads its prebuilt fuzzy matcher | https://github.com/mason-org/mason.nvim#requirements |
| Node.js + npm | Mason installs `pyright` (`plugins/lsp.lua`) as an npm package. The other servers (`lua_ls`, `rust_analyzer`, `wgsl_analyzer`) are prebuilt binaries | https://nodejs.org/en/download |
| wl-clipboard | `clipboard = unnamedplus` in `config/options.lua` syncs yanks with the system clipboard through `wl-copy` / `wl-paste` on Wayland | https://github.com/bugaevc/wl-clipboard |
| A Nerd Font in the terminal | mini.icons draws Nerd Font glyphs in lualine, telescope and oil. The `ghostty` package sets JetBrainsMono Nerd Font | [../ghostty/DEPENDENCIES.md](../ghostty/DEPENDENCIES.md) |

Install commands (copied from the linked docs for convenience; if they disagree, the linked docs win):

```sh
# Arch / CachyOS
sudo pacman -S --needed neovim git base-devel tree-sitter-cli curl tar unzip gzip nodejs npm wl-clipboard
```

## Optional

| Dependency | Why | Install docs |
|---|---|---|
| ripgrep, fd | Telescope's `live_grep` / `grep_string` need `rg`; `find_files` uses `rg` or `fd` and falls back to `find` | https://github.com/BurntSushi/ripgrep#installation |
| StyLua | `stylua.toml` sets the Lua style (2 spaces, 120 columns). Nothing runs it yet: conform.nvim (`plugins/formatting.lua`) has no formatters configured. Mason can install it (`:MasonInstall stylua`) | https://github.com/JohnnyMorganz/StyLua |

```sh
# Arch / CachyOS
sudo pacman -S --needed ripgrep fd stylua
```

## Verify

```sh
nvim --version | head -1   # needs v0.12 or later
tree-sitter --version      # needs 0.26.1 or later
for c in git make cc curl tar unzip gzip node npm wl-copy rg fd; do command -v "$c" >/dev/null && echo "$c ok" || echo "$c MISSING"; done
nvim --headless "+Lazy! restore" +qa   # installs plugins at the lazy-lock.json commits without opening the UI
```

Then open `nvim` and run `:checkhealth` for anything a plugin still misses.

## After stowing

- The first launch installs lazy.nvim, every plugin, the treesitter parsers in `plugins/treesitter.lua` and the language servers in `plugins/lsp.lua`; expect a minute of downloads. `:Lazy` and `:Mason` show their progress.
- `:Lazy update` updates the plugins and rewrites `lazy-lock.json`; commit it to keep machines in sync.
