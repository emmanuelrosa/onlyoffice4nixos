{
  description = "A Nix flake containing a package for ONLYOFFICE DesktopEditors.";

  inputs = {
    nixpkgs.url = "github:emmanuelrosa/nixpkgs/master";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, flake-compat }: {
    packages.x86_64-linux = let
      system = "x86_64-linux";

      pkgs = import "${nixpkgs}" {
        inherit system;
      };
    in {
      default = self.packages."${system}".onlyoffice-desktopeditors;
      onlyoffice-desktopeditors = pkgs.callPackage ./package.nix { };
    };
  };
}
