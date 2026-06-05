{ config, lib, pkgs, ... }:

let
  cfg = config.services.tuigreet;
in {
  meta = {
    maintainers = with lib.maintainers; [ emmanuelrosa ];
  };

  options.services.tuigreet = {
    enable = lib.mkEnableOption "enable tuigreet, a text-based greetd greeter. Also enables greetd";
    package = lib.mkPackageOption pkgs "tuigreet" { };

    rememberLastLoggedInUser = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "remember last logged-in user";
    };

    rememberUserSession = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "remember last selected session for each user";
    };

    userMenu = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "allow graphical selection of users from a menu";
    };

    minUserId = lib.mkOption {
      type = lib.types.ints.positive;
      default = 1000;
      description = "minimum UID to display in the user selection menu";
    };

    enableAsterisks = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "display asterisks when a secret is typed";
    };
  };

  config = lib.mkIf config.services.tuigreet.enable {
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session.command = ''
        ${cfg.package}/bin/tuigreet --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions ${lib.optionalString cfg.rememberLastLoggedInUser "--remember"} ${lib.optionalString cfg.rememberUserSession "--remember-user-session"} ${lib.optionalString cfg.userMenu "--user-menu"} --user-menu-min-uid ${builtins.toString cfg.minUserId} ${lib.optionalString cfg.enableAsterisks "--asterisks"} --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now' '';
    };
  };
}
