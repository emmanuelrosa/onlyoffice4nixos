{ config, pkgs, lib, ...}:
{
  programs.onlyoffice.extraFontPackages = lib.mkForce [ ];
}
