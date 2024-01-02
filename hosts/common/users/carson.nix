# Configurations for my user on all systems

{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Set user settings & groups
  #users.mutableUsers = false;
  users.users.carson = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "config"
      "input"
      "lp"
    ];
  };

  # Import my home manager config
  home-manager.users.carson = import ../../../home-manager/carson/${config.networking.hostName}.nix;

  # Set default shell to zsh
  users.defaultUserShell = pkgs.zsh;

  # Setup some sudo settings
  security.sudo = {
    enable = true;
    extraConfig = "Defaults:carson timestamp_timeout=30";
    extraRules = [{
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/poweroff";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

}
