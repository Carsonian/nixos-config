{ pkgs, config, ...}:

{
  fonts.fontconfig.enable = true;
#fonts.fontconfig.defaultFonts.monospace = "JetBrainsMono Nerd Font";

home.packages = with pkgs; [
  
  # Install nerdfonts
  nerd-fonts.jetbrains-mono
];
}
