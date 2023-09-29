# This is the system configuration file for angkor (personal laptop)
# Same as configuration.nix 

{ inputs, outputs, lib, config, pkgs, ... }: {

  # You can import other NixOS modules here
  imports = [
    
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
  ];

  # Setup sudo
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
  
  # Install systemwide packages
  environment.systemPackages = with pkgs; [
    networkmanager
    git
  ];

  #Configure pipewirex
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

  programs.git.enable = true;

  # Set keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "ctrl:nocaps";
  };

  # Use same config for ttyl console
  console.useXkbConfig = true;

  networking.networkmanager.enable = true;
  programs.hyprland.enable = true;
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

  # Turn off network wait because it slows down boot
  systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false; 

  # Setup swaylock with pam (otherwise it can't unlock)
  security.pam.services.swaylock = {};

  # Setup fingerprint login
  #services.fprintd.enable = true;
  #security.pam.services.carson.fprintAuth = config.services.fprintd.enable;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

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
  
  # Create a config user group for users who can edit /nix-config
  # Note: You will have to grant permissions to the config folder to the config group if installing on a new system
  users.groups.config = {};

  # Set default shell to zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Configure system-wide user settings (groups, etc)
  users.users = {
    carson = {
      isNormalUser = true;
      packages = with pkgs; [
        # I use home manager to install packages so no user specific packages go here
      ];
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "config" "network"  "audio" "video" "input" "lp"];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings.PermitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    settings.PasswordAuthentication = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}