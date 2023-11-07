{ pkgs, config, ...}:

{
  imports = [
    
  ];
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
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
}
