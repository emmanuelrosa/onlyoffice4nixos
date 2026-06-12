{ config, pkgs, lib, ...}:
{
  virtualisation.vmVariant.virtualisation = lib.mkForce {
    cores = 8;
    memorySize = 8192;
  };

  fonts.packages = with pkgs; [
    google-fonts 
  ];
}
