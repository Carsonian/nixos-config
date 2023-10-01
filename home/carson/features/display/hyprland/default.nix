{ pkgs, config, ...}:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    # Packages needed for my hyprland setup
    
    #rofi wayland
    wpaperd
    dunst

    # Boring utilities
    xdg-desktop-portal
    qt5.qtwayland
    qt6.qtwayland
    brightnessctl
  ];

  programs = {
    swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    };
  };

  # Add wpaperd config files to home directory
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
  
}

