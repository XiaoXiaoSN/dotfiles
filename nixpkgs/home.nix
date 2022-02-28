{ pkgs, ...}:

with pkgs;
{
  home.packages = [
    # useful tools
    bat
    direnv
    fd
    ripgrep # rg, fast grepper
  ];

  home.file = {
    # Terminal & Shell
    ".config/alacritty/alacritty.yml".source = ../alacritty/alacritty.yml;
    # ".config/fish".source = ../fish;
    # ".zshrc".source = ../zsh/zshrc;
    # ".config/zsh".source = ../zsh/zsh_config;
  };
}
