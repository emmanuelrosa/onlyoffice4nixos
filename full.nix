{ config, pkgs, lib, ...}:
{
  virtualisation.vmVariant.virtualisation = lib.mkForce {
    cores = 8;
    memorySize = 8192;
  };

  programs.onlyoffice.extraFontPackages = lib.mkForce [ ];

  fonts.packages = with pkgs; [
    google-fonts 
  ];
}
