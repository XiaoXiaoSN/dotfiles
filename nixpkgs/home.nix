{ pkgs, ...}:

with pkgs;
{
  home.packages = [
    # useful tools
    bat
    direnv
    exa
    fd
    ranger # ra: filemanager for the console
    ripgrep # rg: fast grepper
    watch
    wget
  ];

  home.file = {
    # Terminal & Shell
    ".config/alacritty/alacritty.yml".source = ../alacritty/alacritty.yml;
    # ".config/fish".source = ../fish;
    # ".zshrc".source = ../zsh/zshrc;
    # ".config/zsh".source = ../zsh/zsh_config;
  };
}
