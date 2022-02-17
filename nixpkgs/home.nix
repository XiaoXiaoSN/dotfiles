{ pkgs, ...}:

with pkgs;
{
  home.packages = [
    direnv
    fd
  ];

  home.file = {
    # Terminal & Shell
    ".config/alacritty/alacritty.yml".source = ../alacritty/alacritty.yml;
    # ".config/fish".source = ../fish;
    # ".zshrc".source = ../zsh/zshrc;
    # ".config/zsh".source = ../zsh/zsh_config;
  };
}
