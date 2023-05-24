{ pkgs, ...}:

with pkgs;
{
  home = {
    stateVersion = "21.05";

    username = "renhao";
    homeDirectory = "/home/renhao";

    packages = [
      pkgs.fd
      pkgs.nodejs-16_x
    ];
  };

  # ref: https://github.com/nix-community/nixos-vscode-server
  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];
  services.vscode-server.enable = true;
  services.vscode-server.nodejsPackage = pkgs.nodejs-16_x;
}
