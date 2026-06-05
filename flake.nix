{
  description = "A NixOS virtual machine demonstrating onlyoffice with fonts support.";

  inputs = {
    nixpkgs.url = "github:emmanuelrosa/nixpkgs?ref=onlyoffice-vm";
  };

  outputs = { self, nixpkgs }: {
    nixosModules.tuigreet = import ./modules/tuigreet.nix;

    nixosConfigurations.onlyoffice-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.tuigreet
        ./configuration.nix
      ];
    };
  };
}
