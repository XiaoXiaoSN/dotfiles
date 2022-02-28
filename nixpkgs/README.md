## Install Nix
https://nixos.org/download.html

## Install HomeManager Standalone
https://nix-community.github.io/home-manager/index.html#sec-install-standalone

https://nix-community.github.io/home-manager/options.html

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-env -iA nixpkgs.home-manager
```

## Ref
https://nixos.wiki/wiki/Nix_Expression_Language
