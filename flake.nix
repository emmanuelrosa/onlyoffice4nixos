{
  description = "A NixOS virtual machine demonstrating onlyoffice with fonts support.";

  inputs = {
    nixpkgs.url = "github:emmanuelrosa/nixpkgs?ref=onlyoffice-vm";
  };

  outputs = { self, nixpkgs }: {
    nixosModules.tuigreet = import ./modules/tuigreet.nix;

    nixosConfigurations = {
      onlyoffice-vm = self.nixosConfigurations.minimal;

      minimal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.tuigreet
          ./minimal.nix
        ];
      };

      full = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.tuigreet
          ./minimal.nix
          ./full.nix
        ];
      };
    };

    packages.x86_64-linux = let
      pkgs = import "${nixpkgs}" {
        system = "x86_64-linux";
      };
    in {
      onlyoffice-desktopeditors = pkgs.onlyoffice-desktopeditors.override {
        extraFontPackages = with pkgs; [
          dejavu_fonts
          freefont_ttf
          gyre-fonts
          liberation_ttf
          unifont
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji 
          google-fonts
        ];
      };
    };
  };
}
