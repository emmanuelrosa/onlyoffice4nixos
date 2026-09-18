# ONLYOFFICE4NIXOS

This repository is a Nix flake containing a package for ONLYOFFICE DesktopEditors, as suggested in Nixpkgs PR [526315](https://github.com/NixOS/nixpkgs/pull/526315).

The package adds the ability to bundle additional fonts, as a workaround for the issue decribed in [https://github.com/ONLYOFFICE/DocumentServer/issues/1859](https://github.com/ONLYOFFICE/DocumentServer/issues/1859).

# Getting started

How you add this package to your NixOS configuration will depend on whether you are using Nix flakes, or not:

## Installation with Nix flakes

Edit your `flake.nix` to add this repository to your `inputs`:

**flake.nix**
```
inputs.onlyoffice4nixos.url = "github:emmanuelrosa/onlyoffice4nixos";
```

Next, you need to get `onlyoffice4nixos` into your flake outputs. There are different ways to do this. Here's one way:

**flake.nix**
```
  outputs = { self, nixpkgs, onlyoffice4nixos }@attrs: {
    ...
  };
```

Next, add `onlyoffice4nixos` to your NixOS configuration. This example uses `@attrs` to do this:

**flake.nix**
```
  outputs = { self, nixpkgs, onlyoffice4nixos }@attrs: {
    nixosConfigurations."nixos" = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
      ];
    };
  };
```

Finally, edit your `configuration.nix` to add the `onlyoffice-desktopeditors` package to your `systemPackages`: 

**configuration.nix**
```
{inputs, pkgs, ...}: {
  environment.systemPackages = [
    (onlyoffice4nixos.packages.x86_64-linux.onlyoffice-desktopeditors.override {
      # Optionally, add the fonts you want to bundle with ONLYOFFICE:
      extraFontPackages = with pkgs; [
        noto-fonts-cjk-sans
        nanum
        pretendard
        liberation_ttf
      ];
    })
  ];
}
```

## Installation with npins

First, add this repo using npins:

```
npins add github emmanuelrosa onlyoffice4nixos
```

Finally, edit your `configuration.nix` to add the `onlyoffice-desktopeditors` package to your `systemPackages`: 

**configuration.nix**
```
  let
    sources = import ./npins;
  in {
    environment.systemPackages = [
      ((import sources.onlyoffice-desktopeditors).override {
        # Optionally, add the fonts you want to bundle with ONLYOFFICE:
        extraFontPackages = with pkgs; [
          noto-fonts-cjk-sans
          nanum
          pretendard
          liberation_ttf
        ];
      })
    ];
  }
}
```

## Installation with plain Nix

Edit your `configuration.nix` to add the `onlyoffice-desktopeditors` package to your `systemPackages`: 

**configuration.nix**
```
  let
    rev = "A GIT REVISION GOES HERE";
    onlyoffice4nixos = import (fetchTarball "https://github.com/emmanuelrosa/onlyoffice4nixos/archive/${rev}.tar.gz") { };
  in {
    environment.systemPackages = [
      (onlyoffice4nixos.onlyoffice-desktopeditors.override {
        # Optionally, add the fonts you want to bundle with ONLYOFFICE:
        extraFontPackages = with pkgs; [
          noto-fonts-cjk-sans
          nanum
          pretendard
          liberation_ttf
        ];
      })
    ];
  }
}
```
