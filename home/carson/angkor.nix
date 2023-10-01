{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global
    ./features/cli
    ./features/display/hyprland
    ./features/music.nix
    ./features/kitty.nix
    ./features/emacs/default.nix
    ./features/fonts.nix
    
    inputs.nix-colors.homeManagerModule

  ];

  colorScheme = inputs.nix-colors.colorschemes.gruvbox-dark-hard;

  home.packages = with pkgs; [
    # Add programs here to install them for the user

    # Programs
    firefox
    ledger
    libreoffice
    neofetch
    
    multimarkdown
  ];

  # Configure packages with home manager options ##################################

  programs = {

    git = {
      enable = true;
      userName = "Carson Moore";
      userEmail = "carson2477@live.com";
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
    
  };
  
}
