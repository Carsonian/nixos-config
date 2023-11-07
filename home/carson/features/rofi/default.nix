{ pkgs, config, ...}:

{
  imports = [
    
  ];
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "$HOME/.config/rofi";
    font = "JetBrains Mono Nerd Font";
    plugins = with pkgs; [
      rofi-calc
      rofi-power-menu
      rofi-mpd
    ];
    extraConfig = {
      modes = "window,drun,run,ssh,combi,calc,power-menu:$HOME/.config/rofi/powermenu.sh";
    };
  };

  home.file = {
    "/.config/rofi/config.rasi" = {
      source = ./style-theme2.rasi;
    };
  };
  home.file = {
    "/.config/rofi/powermenu.rasi" = {
      source = ./powermenu.rasi;
    };
  };
  home.file = {
    "/.config/rofi/powermenu.sh" = {
      source = ./powermenu.sh;
      executable = true;
    };
  };
  
}
