# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    
    # Hyprland config 
    #./hyprland.nix
    
    #./firefox.nix
    
  ];
  
  nixpkgs = {

    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Set username & home directory
  home = {
    username = "carson";
    homeDirectory = "/home/carson";
  };

  # Basic git configuration
  programs.git = {
    enable = true;
    userName = "carsonian";
    userEmail = "carson2477@live.com";
  };

  # Set nix-colors colorscheme
  #colorScheme = nix-colors.colorSchemes.dracula;
  colorScheme = import ./colors-greendarkish.nix;

  # Add packages #############################################

  home.packages = with pkgs; [
    # Add programs here to install them via home-modules

    # Terminal
    kitty

    # Programs
    firefox
    ledger

    # Wayland/Hyprland stuff
    waybar
    #font-awesome
    wofi
    hyprpaper
    dunst

    # Shell
    zsh

    # Boring utilities
    pipewire
    xdg-desktop-portal
    qt5.qtwayland
    qt6.qtwayland
  ];

  # Configure packages ##################################

  wayland.windowManager.hyprland = {
     enable = true;
     extraConfig = builtins.readFile ./hyprland.conf;
     settings = {
       decoration = {
         shadow_offset = "0 5";
         "col.shadow" = "rgba(00000099)";
       };

       #col.inactive_border = "#${config.colorScheme.colors.base05}";
     };
  };

  programs = {
    kitty = {
      enable = true;
      settings = {
        foreground = "#${config.colorScheme.colors.base05}";
        background = "#${config.colorScheme.colors.base00}";
        # ...
      };
    };
    
    # Configure emacs version & packages, point to init.el
    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraPackages = epkgs: with epkgs; [
        use-package
        gruvbox-theme
        ledger-mode
        nix-mode
        which-key
        magit
        flycheck
        sudo-edit
        beacon
        indent-guide
        smart-hungry-delete
        smooth-scrolling
        all-the-icons
        aggressive-indent
        vertico
        orderless
        marginalia
        consult
        embark
        embark-consult
        corfu
      ];
      extraConfig = builtins.readFile ./emacs-init.el;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  # Let home manager install ans manage itself.
  programs.home-manager.enable = true;

}

