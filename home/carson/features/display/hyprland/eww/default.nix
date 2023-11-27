{ pkgs, config, ...}:

{
  home.file = {
    "/.config/eww/eww.yuck" = {
      source = ./eww-bar/eww.yuck;
    };
  };
  home.file = {
    "/.config/eww/eww.scss" = {
      source = ./eww-bar/eww.scss;
    };
  };
}
