## Install Nix

https://nixos.org/download.html

## Install HomeManager Standalone

https://nix-community.github.io/home-manager/index.html#sec-install-standalone

https://nix-community.github.io/home-manager/options.html

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-env -iA nixpkgs.home-manager
```

Install/Update packages by Home Manager

```bash
# check git changes are added

cd nixpkgs

home-manager build
home-manager switch
```

## Ref

https://nixos.wiki/wiki/Nix_Expression_Language
