# This is the system configuration file for angkor (personal laptop)

{ inputs, outputs, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/carson.nix

    ../common/optional/python.nix
    ../common/hyprland-wm.nix
    
  ];

  # Set hostname
  networking.hostName = "angkor";

  # Set the bootloader & boot options
  boot = {
    loader= {
      systemd-boot.enable = true;
      timeout = 0;
      systemd-boot.configurationLimit = 10;
    };
  };

  # Programs installed at a system level for angkor
  programs = {
    hyprland.enable = true;
  };

  # Set keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "ctrl:nocaps";
  };
  # Use same config for ttyl console
  console.useXkbConfig = true;

  security.polkit.enable = true;

  # Set timezone automatically
  services.automatic-timezoned.enable = true;


  # Create a config user group for users who can edit /nix-config
  # Note: You will have to grant permissions to the config folder to the config group if installing on a new system
  users.groups.config = {};

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  # services.openssh = {
  #   enable = true;
  #   # Forbid root login through SSH.
  #   settings.PermitRootLogin = "no";
  #   # Use keys only. Remove if you want to SSH using password (not recommended)
  #   settings.PasswordAuthentication = false;
  # };
  # openssh.authorizedKeys.keys = [
  #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
  # ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
