My dotfiles
========

My dot files for ZSH, Bash, Vim and Neovim.

```
git clone https://github.com/mattmolo/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

`install.sh` links the dotfiles into `~`, then asks whether to set up Neovim and zsh-prezto.
Machine-specific settings (like `EDITOR`) go in `~/.local_shellrc`, which isn't tracked.

To install the tools below (everything except the optional language server toolchains), run:
```
bash ~/.dotfiles/tools_install.sh
```
It checks for each tool and only installs the missing ones, with Homebrew on MacOS and apt on Debian/Ubuntu.
Tools that apt doesn't have or ships too old (neovim, tree-sitter, diff-so-fancy, uv) go in `~/.local`.

## Tools:
### Zsh + Prezto
`install.sh` offers to run `prezto_install.sh`, which clones [prezto](https://github.com/sorin-ionescu/prezto) and links the zsh files. Install zsh first:

Install (MacOS) | Install Linux (Debian mainly)
--------------- | -----------------------------
already installed | `apt-get install zsh`

### Vim 8.0+
Certain plugins need Lua and Python to work in vim. Here's the easiest way to get those installed:

#### Debian/Ubuntu
```bash
sudo apt-get install vim-nox
```

#### MacOS
```bash
brew install vim
```

### Neovim 0.11+
The config lives in `nvim/` and is linked to `~/.config/nvim` by `install.sh`. Plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim) and install themselves on first launch.

#### Debian/Ubuntu
The `apt` package is usually too old, so use the release tarball:
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
```
(Use `nvim-linux-arm64` on ARM.)

#### MacOS
```bash
brew install neovim
```

#### What Neovim needs
Tool             | Purpose | Install (MacOS) | Install Linux (Debian mainly)
-----------------| ------- | --------------- | -----------------------------
tree-sitter CLI  | builds treesitter parsers | `brew install tree-sitter-cli` | release binary (`install.sh` does both)
C compiler       | builds treesitter parsers | `xcode-select --install` | `apt-get install build-essential`
ripgrep          | Telescope live grep | `brew` | `apt-get`
Hermit Nerd Font | icons in neo-tree and lualine (shows up as "Hurmit Nerd Font Mono") | [Hermit.zip](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/Hermit.zip) into `~/Library/Fonts` | [Hermit.zip](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/Hermit.zip) into `~/.local/share/fonts`

#### Language servers (optional)
[Mason](https://github.com/mason-org/mason.nvim) installs the language servers, but only when the tool each one
needs is on the machine (see `nvim/lua/plugins/lsp.lua`). Install the tool and the servers install
the next time Neovim opens.

Language servers                    | Needs   | Install (MacOS) | Install Linux (Debian mainly)
----------------------------------- | ------- | --------------- | -----------------------------
lua_ls                              | nothing | - | -
pyright, ts_ls (TypeScript), vue_ls | node/npm | `brew install node` | [NodeSource](https://github.com/nodesource/distributions) or `apt-get install nodejs npm`
rust_analyzer                       | cargo   | [rustup](https://rustup.rs) | [rustup](https://rustup.rs)
gopls                               | go      | `brew install go` | [go.dev/dl](https://go.dev/dl/) (`apt-get install golang` is often old)

### Basics:
Tool             | Purpose | Install (MacOS) | Install Linux (Debian mainly)
-----------------| ------- | --------------- | -----------------------------
jq               | json processor (used by `json-*` aliases) | `brew` | `apt-get`
bat              | pretty prints code (fzf previews) | `brew` | `apt-get` (installed as `batcat`; the aliases handle it)
fzf              | fuzzy find a file (Ctrl-T, Ctrl-R, `f`, `vf`, `gc`) | `brew` | `apt-get`
git              | version control | `brew` | `apt-get`
htop             | a pretty top | `brew` | `apt-get`
btop             | a prettier top | `brew` | `apt-get`
tmux             | terminal mutliplexer | `brew` | `apt-get`
wget             | get things off the web | `brew` | `apt-get`
ripgrep          | faster grep (`r`, fzf file lists) | `brew` | `apt-get`
diff-so-fancy    | fancy git diff's (git pager) | `brew` | [release script](https://github.com/so-fancy/diff-so-fancy/releases)
uv               | python versions, packages and tools | `brew` | [installer](https://docs.astral.sh/uv/getting-started/installation/)
ipython          | fancy python repl | `uv tool install ipython` | `uv tool install ipython`
virtualenv       | manage python environments (`venv`) | `uv tool install virtualenv` | `uv tool install virtualenv`

### Custom Scripts:
Tool                 | Purpose
---------------------| -------
z                    | quick jump to directories (`zi` picks one with fzf)
mac-ssh-proxy        | ssh tunnel your traffic
git-log-remote-or-not | git log preview for the `gc` branch picker
