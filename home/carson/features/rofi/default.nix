{ pkgs, config, ...}:

{
  imports = [
    
  ];
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "$HOME/.config/rofi";
    theme = ./style-theme2.rasi;
    font = "JetBrains Mono Nerd Font";
    plugins = with pkgs; [
      rofi-calc
      rofi-power-menu
      rofi-mpd
    ];
    extraConfig = {
      modes = "window,drun,run,ssh,combi,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
    };
  };
  
  home.file = {
    "$HOME/.config/rofi/powermenu.rasi" = {
      source = ./powermenu.rasi;
          };
  };
    
}
