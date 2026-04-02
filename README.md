# Dotfiles

## Neovim on Arch

Symlink the config:

```sh
stow -v nvim -t ~/
```

Install the required Arch packages:

```sh
sudo pacman -S neovim ripgrep wl-clipboard clang tree-sitter-cli
```

Install Codex ACP for `agentic.nvim`:

```sh
npm i -g @zed-industries/codex-acp
```

Start Neovim and install/update plugins and parsers:

```vim
:PlugInstall
:TSUpdate
:TSInstall markdown markdown_inline html yaml lua vim cpp c ruby
```

If something still looks broken, check:

```vim
:checkhealth nvim-treesitter
:checkhealth provider
```
