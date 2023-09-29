{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global
    #./features/cli
    #./features/emacs
    ./features/display/hyprland
    #./features/music.nix
    ./features/kitty.nix

    inputs.nix-colors.homeManagerModule.default
  ];

  colorscheme = inputs.nix-colors.colorschemes.gruvbox-dark-hard;

  # To move to features folder...

  home.packages = with pkgs; [
    # Add programs here to install them for the user

    # Install nerdfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    
    # Programs
    firefox
    ledger
    libreoffice
    neofetch

    # Wayland/Hyprland stuff
    #rofi wayland
    wpaperd
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
    multimarkdown
  ];

  # Add config files to home directory (for programs without built-in home manager options)
  home.file = { 
    "/.config/wpaperd/wallpaper.toml" = {
      text = ''
      [default]
      path = "/home/carson/Pictures/Wallpapers/"
      # duration = "30m"
      sorting = "random"
      apply-shadow = true
   '';
    };
  };

  # Configure packages with home manager options ##################################

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

    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };

    btop = {
      enable = true;
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
        markdown-mode
        which-key
        magit
        flycheck
        sudo-edit
        beacon
        indent-guide
        smart-hungry-delete
        smooth-scrolling
        speed-type
        aggressive-indent
        dashboard
        projectile
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

  
}
