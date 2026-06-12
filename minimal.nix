{ config, pkgs, lib, ...}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.vmVariant.virtualisation = {
    cores = 4;
    memorySize = 4096;
  };

  users.users.johngalt = {
    isNormalUser = true;
    initialPassword = "onlyoffice";
  };

  services.tuigreet = {
    enable = true;
    rememberLastLoggedInUser = true;
    rememberUserSession = true;
    userMenu = true;
    enableAsterisks = true;
  };

  # Set up auto-login
  services.greetd.settings.initial_session = {
    user = "johngalt";
    command = "${lib.getExe pkgs.labwc}";
  };

  programs.labwc.enable = true;
  programs.onlyoffice.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
  ];

  fonts.packages = with pkgs; [
    # You can add more fonts here.
    # google-fonts 
  ];

  systemd.user.services.labwc-config-generator = let
    autostart = pkgs.writeText "autostart" ''
      ${lib.getExe pkgs.swaybg} -i ${pkgs.nixos-artwork.wallpapers.catppuccin-frappe}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-frappe.png > /dev/null 2>&1 &
      ${lib.getExe pkgs.sfwbar} > /dev/null 2>&1 &
    '';

    script = pkgs.writeShellScript "labwc-config-generator.bash" ''
      export PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.labwc pkgs.labwc-menu-generator ]}
      mkdir -p $HOME/.config/labwc
      labwc-menu-generator > $HOME/.config/labwc/menu.xml
      cp -f ${autostart} $HOME/.config/labwc/autostart
    '';
  in {
    description = "Generates a user configuration for labwc";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = script;
    };
  };

  systemd.user.services.sample-document-downloader = let
    document = pkgs.fetchurl {
      url = "https://sample-files.com/downloads/documents/docx/sample-files.com-image-document.docx";
      hash = "sha256-jCqMRyXne7+03ceSVnTcIhYRo5uHbb1+ou/IKecLhTA=";
    };

    script = pkgs.writeShellScript "sample-document-downloader.bash" ''
      export PATH=${lib.makeBinPath [ pkgs.coreutils ]}
      export TARGET="$HOME/Documents/sample-files.com-image-document.docx"
      mkdir -p $HOME/Documents
      cp -n ${document} "$TARGET"
      chown johngalt:users "$TARGET"
      chmod u+w "$TARGET"
    '';
  in {
    description = "Downloads a sample docx document";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = script;
    };
  };

  system.stateVersion = "26.05";
}
