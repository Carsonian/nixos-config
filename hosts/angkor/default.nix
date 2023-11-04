# This is the system configuration file for angkor (personal laptop)

{ inputs, outputs, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/carson.nix

    ../common/optional/python
    ../common/optional/metabase.nix
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

  #Configure pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    #alsa.enable = true;
    #jack.enable = true;
    #pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  # Set keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "ctrl:nocaps";
  };
  # Use same config for ttyl console
  console.useXkbConfig = true;

  security.polkit.enable = true;

  # Setup greetd with tuigreet
  services.greetd = {
    enable = true;
    settings = {
      # Tuigreet as display manager
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -r --asterisks";
        user = "greeter";
      };
    };
  };

  # Use network manager
  networking.networkmanager.enable = true;
  # Turn off network wait because it slows down boot
  systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false; 

  # Setup swaylock with pam (otherwise it can't unlock)
  security.pam.services.swaylock = {};

  # Setup fingerprint login
  #services.fprintd.enable = true;
  #security.pam.services.carson.fprintAuth = config.services.fprintd.enable;
  
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
