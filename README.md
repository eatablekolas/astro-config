# AstroNvim Template

**NOTE:** This is for AstroNvim v6+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## Keybindings

Defined in `lua/config/keymaps.lua`.

### Comments
- Mode: normal  
  - Keys: `<C-_>`  
  - Command: `gcc` (remapped)  
  - Description: Toggle comment on current line

- Mode: visual  
  - Keys: `<C-_>`  
  - Command: `gc` (remapped)  
  - Description: Toggle comment on selection

### Buffers
- Mode: normal  
  - Keys: `<Tab>`  
  - Action: `buffer.nav(1)` (Lua function)  
  - Description: Go to next buffer

- Mode: normal  
  - Keys: `<S-Tab>`  
  - Action: `buffer.nav(-1)` (Lua function)  
  - Description: Go to previous buffer

- Mode: normal  
  - Keys: `<F4>`  
  - Action: `buffer.close()` (Lua function)  
  - Description: Close buffer

### Save
- Mode: normal  
  - Keys: `<C-s>`  
  - Command: `:w<cr>`  
  - Description: Save file

- Mode: insert  
  - Keys: `<C-s>`  
  - Command: `<C-o>:w<cr>`  
  - Description: Save file from insert mode

### Line manipulation
- Mode: normal  
  - Keys: `<A-j>`  
  - Command: `:m+<cr>==`  
  - Description: Move current line down

- Mode: insert  
  - Keys: `<A-j>`  
  - Command: `<Esc>:m+<cr>==gi`  
  - Description: Move current line down (from insert mode)

- Mode: normal  
  - Keys: `<A-down>`  
  - Command: `:m+<cr>==`  
  - Description: Move current line down

- Mode: insert  
  - Keys: `<A-down>`  
  - Command: `<Esc>:m+<cr>==gi`  
  - Description: Move current line down (from insert mode)

- Mode: normal  
  - Keys: `<A-k>`  
  - Command: `:m-2<cr>==`  
  - Description: Move current line up

- Mode: insert  
  - Keys: `<A-k>`  
  - Command: `<Esc>:m-2<cr>==gi`  
  - Description: Move current line up (from insert mode)

- Mode: normal  
  - Keys: `<A-up>`  
  - Command: `:m-2<cr>==`  
  - Description: Move current line up

- Mode: insert  
  - Keys: `<A-up>`  
  - Command: `<Esc>:m-2<cr>==gi`  
  - Description: Move current line up (from insert mode)

### LSP actions
- Mode: normal, insert, visual  
  - Keys: `<M-cr>`  
  - Action: `vim.lsp.buf.code_action`  
  - Description: Trigger LSP code actions (Alt + Enter). Note: disable Alt+Enter on Windows terminal if needed.

- Mode: normal  
  - Keys: `<F2>`  
  - Action: `vim.lsp.buf.rename`  
  - Description: Rename symbol

- Mode: normal  
  - Keys: `<F12>`  
  - Action: `vim.lsp.buf.definition`  
  - Description: Go to definition

### Mouse actions
- Mode: normal  
  - Keys: `C-LeftMouse`  
  - Command: `<LeftMouse>:lua vim.lsp.buf.definition()<cr>`  
  - Description: Ctrl + Click -> Go to definition (note: mouse actions should be avoided)
