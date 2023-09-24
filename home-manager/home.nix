# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes:
    #inputs.hyprland.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    
    # Hyprland config
    ./hyprland.nix
    #./waybar.nix
    ./waybar-new.nix
    ./kitty.nix

    # Import custom colorscheme
    #./colors.nix

    #TODO Firefox config 
    #./firefox.nix
    
  ];

  # Or choose a premade colorscheme, here's some I like:
  #colorScheme = inputs.nix-colors.colorSchemes.material;
  #colorScheme = inputs.nix-colors.colorSchemes.nord;
  #colorScheme = inputs.nix-colors.colorSchemes.woodland;
  #colorScheme = inputs.nix-colors.colorSchemes.atlas;
  #colorScheme = inputs.nix-colors.colorSchemes.material;
  #colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  #colorScheme = inputs.nix-colors.colorSchemes.onedark;
  colorScheme = inputs.nix-colors.colorSchemes.silk-dark;
  
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

  # Add packages #############################################

  fonts.fontconfig.enable = true;
  #fonts.fontconfig.defaultFonts.monospace = "JetBrainsMono Nerd Font";

  home.packages = with pkgs; [
    # Add programs here to install them for the user

    # Install nerdfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    
    # Programs
    firefox
    ledger
    libreoffice

    # Wayland/Hyprland stuff
    #wofi
    hyprpaper
    dunst

    # Music player, visualizer, controller
    cmus
    cava
    playerctl
    mpc-cli
    
    # Boring utilities
    xdg-desktop-portal
    qt5.qtwayland
    qt6.qtwayland
    brightnessctl
  ];

  # Configure packages ##################################

  programs = {

    git = {
      enable = true;
      userName = "Carson Moore";
      userEmail = "carson2477@live.com";
    };
    
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "(cd /nix-config && sudo nixos-rebuild switch --flake .#angkor)";
        test = "(cd /nix-config && sudo nixos-rebuild test --flake .#angkor)";
      };
      # History settings
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      # zsh plugin manager
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "alanpeabody";
      };
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "kitty -e";
          layer = "overlay";
          font = "JetBrains Mono Nerd Font";
          prompt = "'󱎱 '";
        };
        colors = {
          background = "${config.colorScheme.colors.base00}80";
          text = "${config.colorScheme.colors.base07}E6";
          #icon-theme = "hicolor";
          match = "${config.colorScheme.colors.base09}E6";
          selection = "${config.colorScheme.colors.base04}CC";
          selection-text = "${config.colorScheme.colors.base01}FF";
          selection-match = "${config.colorScheme.colors.base08}E6";
          border = "${config.colorScheme.colors.base03}E6";
        };
        border = {
          width = 3;
          radius = 10;
        };
      };
    };
    
    
    # Configure emacs version & packages, point to init.el
    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraPackages = epkgs: with epkgs; [
        use-package
        gruvbox-theme
        nerd-icons
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
        embark
        swiper
        base16-theme
      ];
      extraConfig = builtins.readFile ./emacs-init.el
                    # Add the base16 theme we are using in nixos to emacs
                    +''(use-package base16-theme
                        :config
                        (load-theme 'base16-${config.colorScheme.slug} t))
                        (set-cursor-color "#${config.colorScheme.colors.base09}") 
                        '';
    };
  };

  # Configure mpd
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
    audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }
    '';
  };

  # This service allows mpd to be detected by playerctl
  services.mpd-mpris = {
    enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  # Let home manager install ans manage itself.
  programs.home-manager.enable = true;

}

