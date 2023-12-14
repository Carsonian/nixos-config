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

  services.swayidle =
    let
      lockCommand = "${pkgs.pkgs.swaylock-effects}/bin/swaylock -fF --screenshots --effect-vignette 0.8:0.8 --effect-greyscale --effect-blur 3x3 --clock --indicator --ring-ver-color 00cc0080 --inside-ver-color ${config.colorScheme.colors.base0B}";
      
    in
      {
        enable = true;
        systemdTarget = "hyprland-session.target";
        timeouts =
          let
            dpmsCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms";
          in
            [
              {
                timeout = 300;
                command = lockCommand;
                }
              {
                timeout = 600;
                command = "${dpmsCommand} off";
                resumeCommand = "${dpmsCommand} on";
              }
            ];
        events = [
          {
            event = "before-sleep";
            command = lockCommand;
          }
          {
            event = "lock";
            command = lockCommand;
          }
        ];
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

