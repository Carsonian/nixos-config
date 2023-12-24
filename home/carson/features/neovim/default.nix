{ pkgs, config, ...}:

{
  # Configure emacs version & packages, point to init.el
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile ./init.lua;
  };

}
