# This is the system configuration file for angkor (personal laptop)

{ inputs, outputs, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/carson.nix

    ../common/optional/python
    
    ../common/de-wm/gnome.nix
    #../common/de-wm/hyprland-wm.nix
    
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
