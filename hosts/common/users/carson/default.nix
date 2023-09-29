{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
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

  home-manager.users.carson = import ../../../../home/carson/${config.networking.hostName}.nix;

}
