# https://nix-community.github.io/home-manager/
# Office real-world examples: https://nixos.wiki/wiki/Configuration_Collection
{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ input: {
    homeConfigurations = {
      "arios" = home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/arios";
        username = "arios";

        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          # inherit system;
          config = {
            allowUnfree = true;
          };
        };

        configuration.imports = [ ./home.nix ];
      };

      "arios@OUTSIDE" = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/arios";
        username = "arios";

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          # inherit system;
          config = {
            allowUnfree = true;
          };
        };

        configuration.imports = [
          ./home.nix
          ./users/outside.nix
        ];
      };
    };
  };
}
