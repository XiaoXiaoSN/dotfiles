{ pkgs, ...}:

with pkgs;
{
  home.packages = [
    hack-font
  ];

  home.file = {
    # Terminal & Shell
    # ".config/fish".source = ../fish;
    # ".zshrc".source = ../zsh/zshrc;
    # ".config/zsh".source = ../zsh/zsh_config;
  };
}
