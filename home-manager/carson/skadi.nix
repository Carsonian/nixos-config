{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global
    ./features/cli
    #./features/hyprland
    #./features/rofi
    #./features/music.nix
    ./features/kitty.nix
    ./features/vscode.nix
    #./features/emacs
    #./features/neovim
    ./features/fonts.nix
    ./features/firefox.nix
    
    inputs.nix-colors.homeManagerModule
  ];

  # Or choose a premade colorscheme, here's some I like:
  #colorScheme = inputs.nix-colors.colorSchemes.material;
  #colorScheme = inputs.nix-colors.colorSchemes.nord;
  #colorScheme = inputs.nix-colors.colorSchemes.woodland;
  #colorScheme = inputs.nix-colors.colorSchemes.atlas;
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  #colorScheme = inputs.nix-colors.colorSchemes.onedark;
  #colorScheme = inputs.nix-colors.colorSchemes.silk-dark;
  #colorScheme = inputs.nix-colors.colorSchemes.brushtrees-dark;

  home.packages = with pkgs; [
    # Add programs here to install them for the user

    # Programs
    #ledger
    #sqlite
    #libreoffice
    neofetch
    #multimarkdown

    appflowy
    logseq

    #freetube
    #bluetuith
    #android-file-transfer
  ];

  nixpkgs.config.permittedInsecurePackages = [
                "electron-27.3.11"
              ];


  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
    };
    defaultApplications = {
      "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "Carson Moore";
      userEmail = "carson2477@live.com";
    };
  };
}
