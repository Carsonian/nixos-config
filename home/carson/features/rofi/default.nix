{ pkgs, config, ...}:

{
  imports = [
    
  ];
  
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./style-theme.rasi;
    font = "JetBrains Mono Nerd Font";
    plugins = [ pkgs.rofi-power-menu pkgs.rofi-calc pkgs.rofi-mpd ];
    extraConfig = {
    };
  };
}
