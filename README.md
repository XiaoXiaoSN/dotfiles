# dotfiles

![lint](https://github.com/XiaoXiaoSN/dotfiles/actions/workflows/lint.yaml/badge.svg)

## Getting Started

### Editor

- `make neovim`
- `make vim`

### Shell

- `make fish`
- `make zsh`

### Useful tools

- `make git`
- `make tmux`
- `make util-scripts`

### Terminal emulator

- `make alacritty`

### Initialize macOS

- `make init.macOS`

### Setup Nix

- `make nix`
- `make nix.home-manager`

## Writer Guide

### Lint & Format

The repository use [EditorConfig](https://editorconfig.org/) and [editorconfig-checker](https://github.com/editorconfig-checker/editorconfig-checker) to help me keep the consistent coding styles :)

run below command to check format

```
editorconfig-checker
```

Also, we have [Prettier](https://prettier.io/) to further ensure the code format of the project.

run below command to check format

```
npx prettier --check .
```

or use `--write` to directly re-write it

```
npx prettier --write .
```
