# Neovim Config

<img width="1280" height="720" alt="2026-08-1919-57-21-ezgif com-video-to-gif-converter(1)" src="https://github.com/user-attachments/assets/e18951bb-0f7f-4fe9-8769-be80073d9373" />

A personal [AstroNvim](https://github.com/AstroNvim/AstroNvim) configuration for **Windows**, built around three things:

- **[Neovide](https://neovide.dev/) as the GUI** — the font, window behaviour, and most of the chord-heavy keymaps assume it.
- **PowerShell 7 (`pwsh`) as the shell** — the built-in terminal, `cmake-tools`, and `:!` all run through it.
- **A named-pipe server** — so external tools (Godot, scripts, anything else) can open files at a given line in the *already-running* instance.

> **NOTE:** This is for AstroNvim v6+.

## Requirements

| Requirement | Notes |
|---|---|
| [Neovim 0.11+](https://github.com/neovim/neovim/releases/tag/stable) | Required by AstroNvim v6. Developed against 0.12.x. |
| [Neovide](https://neovide.dev/) | The intended GUI — see [Neovide](#neovide). |
| [PowerShell 7](https://github.com/PowerShell/PowerShell) (`pwsh.exe`) | **Required.** `lua/config/options.lua` pins `shell` to `pwsh.exe`. |
| A Nerd Font | **FiraCode Nerd Font Mono** specifically — it is hard-coded as the Neovide `guifont`. |
| [git](https://git-scm.com/) | Plugin management, `vim-fugitive`, `diffview`. |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Powers the Snacks pickers and grep. Install: `winget install BurntSushi.ripgrep` |
| [fd](https://github.com/sharkdp/fd) | Fast file finder. Install: `winget install sharkdp.fd` |
| A C compiler | Required by Treesitter for parsing. See [C compiler requirements](https://docs.rs/cc/latest/cc/#compile-time-requirements). |
| CMake + a C/C++ toolchain | *Optional* — only needed for `cmake-tools`. |

Language servers, formatters, linters, and debug adapters are installed on demand through `:Mason`.

## Installation

Back up anything you already have:

```powershell
Move-Item $env:LOCALAPPDATA\nvim      $env:LOCALAPPDATA\nvim.bak
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
```

Clone this repository into the Neovim config directory:

```powershell
git clone https://github.com/eatablekolas/astro-config $env:LOCALAPPDATA\nvim
```

Start it:

```powershell
neovide
```

The first launch bootstraps `lazy.nvim` and installs every plugin. Let `:Lazy` finish, then restart.

> **Non-Windows:** the config will start, but `lua/config/options.lua` sets `shell` and friends to `pwsh.exe`. Replace or delete that block before using it on Linux/macOS. The pipe server already handles both platforms.

## Neovide

This config is **meant to be run under Neovide**. Everything in `lua/polish.lua` sits behind a `vim.g.neovide` guard, so terminal Neovim still works — it just silently skips all of it:

- `guifont` set to `FiraCode Nerd Font Mono:h12`
- Progress bar disabled, mouse hidden while typing
- Window size remembered between sessions
- Drag-selection enabled in the message area
- Native right-click menu registered (`NeovideRegisterRightClick`)
- `<F11>` toggles fullscreen

## External tools — the pipe server

On every launch, `lua/polish.lua` starts a Neovim server on a named pipe:

| Platform | Address |
|---|---|
| Windows | `\\.\pipe\nvim-server` |
| Everything else | `<stdpath("run")>/nvim-server.pipe` |

You get a notification when it comes up — or a warning if it fails.

Any external program can then drive the running instance through Neovim's remote client. For example, to jump the open window to a file and line:

```powershell
nvim --server \\.\pipe\nvim-server --remote-send ":e C:\path\to\file.txt|42<CR>"
```

Note that it is `nvim.exe` doing the sending, not `neovide.exe`. `--remote-send` is Neovim's own remote-client protocol: it forwards the keys to the running GUI and exits immediately.

### Godot

To make Godot open scripts in your running Neovide instance, go to **Editor → Editor Settings → Text Editor → External** and set:

| Setting | Value |
|---|---|
| **Use External Editor** | on |
| **Exec Path** | `C:\Program Files\Neovim\bin\nvim.exe` |
| **Exec Flags** | see below |

```
--server \\\\.\\pipe\\nvim-server --remote-send ":e {file}|{line}<CR>"
```

> [!IMPORTANT]
> **Every backslash must be doubled.** Godot's exec-flags parser consumes single backslashes as escapes, so the pipe address has to be written `\\\\.\\pipe\\nvim-server` — **not** `\\.\pipe\nvim-server`, even though that is the real address. Godot flatly refuses to work without the doubling: it will open nothing and tell you nothing about why.

A few more things worth knowing:

- **Start Neovide first.** The pipe only exists while an instance is running — Godot talks to it, it does not launch it.
- `{file}` and `{line}` are Godot's own placeholders. Type them literally, exactly as shown; Godot substitutes them before the command runs.
- The `|` between them is a Vim command separator, so the whole `:e ...<CR>` string opens the file *and* jumps to the line in one go.

## Layout

```
init.lua                    bootstraps lazy.nvim, then loads (in order):
├── lua/config/options.lua     pwsh shell setup (Windows)
├── lua/config/keymaps.lua     raw vim.keymap.set bindings
├── lua/lazy_setup.lua         plugin spec root — sets leader keys, imports:
│   ├── astronvim.plugins        AstroNvim v6 core
│   ├── lua/community.lua        AstroCommunity packs
│   └── lua/plugins/*.lua        one LazySpec per file
└── lua/polish.lua             Neovide settings + pipe server (runs last)
```

Three files are AstroNvim's own configuration modules, customised through `opts` rather than by patching AstroNvim:

| File | Controls |
|---|---|
| `lua/plugins/astrocore.lua` | Options, autocommands, sessions, and most custom keymaps |
| `lua/plugins/astrolsp.lua` | LSP features, format-on-save policy, per-server config |
| `lua/plugins/astroui.lua` | Colorscheme and icon overrides *(currently inactive)* |

Files starting with `if true then return {} end` follow AstroNvim's "example, not active" template convention. Currently inactive: `astroui.lua`, `mason.lua`, `none-ls.lua`, `treesitter.lua`, `plugins/user.lua`, `community.lua`. Delete that line to activate one.

`lazy-lock.json` pins exact plugin commits. It is generated by `:Lazy` — don't hand-edit it.

## Plugins

On top of the AstroNvim v6 defaults:

| Plugin | What it adds |
|---|---|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | File explorer and smart picker. Heavily customised: shows hidden and ignored files, 30 columns wide, custom focus toggle, auto-quits when it is the last window standing. |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code in a floating terminal, with diff accept/reject. |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating `pwsh` terminal on `<C-\>`. |
| [resession.nvim](https://github.com/stevearc/resession.nvim) | Session save/load, bound to `<C-s>` and `<C-o>`. |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Side-by-side diffs and file history. |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands (`:Git commit`, `:Git push`, …). |
| [satellite.nvim](https://github.com/lewis6991/satellite.nvim) | Decorated scrollbar — diagnostics, git signs, search hits. |
| [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim) | CMake configure/build/run/debug from inside Neovim. |
| [dooing](https://github.com/atiladefreitas/dooing) | Lightweight to-do list. |

`lua/plugins/neotree.lua` is kept but `enabled = false` — the Snacks explorer replaced it.

## Keybindings

Leader is `<Space>`, local leader is `,`.

### Editing

Defined in `lua/config/keymaps.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal | `<C-/>` | Toggle comment on current line |
| visual | `<C-/>` | Toggle comment on selection |
| normal, insert | `<A-j>` / `<A-Down>` | Move current line down |
| normal, insert | `<A-k>` / `<A-Up>` | Move current line up |

### LSP

From `lua/config/keymaps.lua` and `lua/plugins/astrolsp.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal, insert, visual | `<M-CR>` | Code actions |
| normal | `<F2>` | Rename symbol |
| normal | `<F12>` | Go to definition |
| normal | `Ctrl` + `Click` | Go to definition |
| normal | `gD` | Go to declaration |
| normal | `<Leader>uY` | Toggle semantic highlighting (buffer) |

### Buffers

Defined in `lua/plugins/astrocore.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal | `<Tab>` | Next buffer |
| normal | `<S-Tab>` | Previous buffer |
| normal | `<F4>` | Close buffer |

### Sessions

Defined in `lua/plugins/resession.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal | `<C-s>` | Write the file **and** save the session |
| normal | `<C-o>` | Load the saved session |

### Explorer and search

Defined in `lua/plugins/snacks.lua`, plus AstroNvim defaults.

| Mode | Keys | Action |
|---|---|---|
| normal | `<Leader>e` | Toggle explorer |
| normal | `<Leader>o` | Toggle explorer focus — jump in, and back out |
| normal | `<Leader><Space>` | Smart find files |
| normal | `<Leader>ff` | Find files |
| normal | `<Leader>fw` | Find words (grep) |

### Terminal

Defined in `lua/plugins/toggleterm.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal, terminal | `<C-\>` | Toggle floating terminal (`pwsh`) |

### Git

Defined in `lua/plugins/astrocore.lua`, backed by `vim-fugitive` and `diffview.nvim`.

| Mode | Keys | Action |
|---|---|---|
| normal | `<Leader>gc` | Commit staged changes |
| normal | `<Leader>ga` | Amend last commit |
| normal | `<Leader>gP` | Push to origin |
| normal | `<Leader>gdd` | Open diffview |
| normal | `<Leader>gdh` | Open diffview file history |
| normal | `<Leader>gdc` | Close diffview |

### Claude Code

Defined in `lua/plugins/claude-code.lua`.

| Mode | Keys | Action |
|---|---|---|
| normal, visual | `<M-,>` | Focus Claude |
| terminal | `<M-,>` | Hide Claude |
| normal | `<Leader>ac` | Toggle Claude |
| normal | `<Leader>af` | Focus Claude |
| normal | `<Leader>ar` | Resume a previous session |
| normal | `<Leader>aC` | Continue the last session |
| normal | `<Leader>am` | Select model |
| normal | `<Leader>ab` | Add current buffer to context |
| visual | `<Leader>as` | Send selection to Claude |
| normal | `<Leader>aa` | Accept proposed diff |
| normal | `<Leader>ad` | Reject proposed diff |

### Miscellaneous

| Mode | Keys | Action | Source |
|---|---|---|---|
| normal | `<F11>` | Toggle fullscreen (Neovide only) | `lua/polish.lua` |
| normal | `<Leader>td` | Toggle the to-do window | `dooing` default |

Everything not listed here is an AstroNvim v6 default — press `<Leader>` and let which-key show you the rest.

## Behaviour worth knowing

- **`<C-o>` no longer jumps back.** It is rebound to *load session*, shadowing Vim's built-in jumplist mapping.
- **Session autosave is off.** Sessions are only written when you press `<C-s>`. `gitcommit` and `gitrebase` buffers are excluded.
- **The explorer can quit Neovim.** If the Snacks explorer ends up as the last remaining window, the config runs `qa` so you are not stranded in an empty sidebar.
- **Format-on-save is off**, and LSP formatting is disabled for `lua_ls`, `clangd`, and `csharp_ls` — use `stylua` / `clang-format` instead. Codelens and inlay hints start disabled; semantic tokens start enabled.
- **CMake builds land in `bin/${variant:buildType}`**, `compile_commands.json` is copied to the project root, and both the executor and the runner use a floating `pwsh` toggleterm.

## Development

| Task | Command |
|---|---|
| Format Lua | `stylua .` |
| Lint Lua | `selene .` |
| Reload config | `:so` (or restart) |
| Update plugins | `:Lazy sync` |
| Manage LSPs and tools | `:Mason` |
| Health check | `:checkhealth astronvim` |
