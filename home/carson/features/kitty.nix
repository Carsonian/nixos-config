{ pkgs, config, ...}:

{

  programs.kitty = {
    enable = true;
    settings = {
      
      font_family = "JetBrains Mono Nerd Font";

      font_size = 12;
      confirm_os_window_close = 0;

      #map ctrl+shift+c  copy_to_clipboard;
      #map ctrl+shift+v  paste_from_clipboard;

      adjust_line_height = 0;
      
      window_padding_width = 20;

      # Coloring taken from here: https://github.com/kdrag0n/base16-kitty/blob/master/templates/default.mustache 

      background = "#${config.colorScheme.colors.base00}";
      foreground = "#${config.colorScheme.colors.base05}";
      
      selection_background =  "#${config.colorScheme.colors.base05}";
      selection_foreground =  "#${config.colorScheme.colors.base00}";
      background_opacity =  "0.5";

      # The color for highlighting URLs on mouse-over;
      url_color = "#${config.colorScheme.colors.base04}";

      # Nix colors themeing

      # Normal
      color0 = "#${config.colorScheme.colors.base00}";
      color1 = "#${config.colorScheme.colors.base08}";
      color2 = "#${config.colorScheme.colors.base0B}";
      color3 = "#${config.colorScheme.colors.base0A}";
      color4 = "#${config.colorScheme.colors.base0D}";
      color5 = "#${config.colorScheme.colors.base0E}";
      color6 = "#${config.colorScheme.colors.base0C}";
      color7 = "#${config.colorScheme.colors.base05}";

      # Bright
      color8 = "#${config.colorScheme.colors.base03}";
      color9 = "#${config.colorScheme.colors.base09}";
      color10 = "#${config.colorScheme.colors.base01}";
      color11 = "#${config.colorScheme.colors.base02}";
      color12 = "#${config.colorScheme.colors.base04}";
      color13 = "#${config.colorScheme.colors.base06}";
      color14 = "#${config.colorScheme.colors.base0F}";
      color15 = "#${config.colorScheme.colors.base07}";

      # Cursor
      cursor = "#${config.colorScheme.colors.base07}";
      cursor_text_color = "#${config.colorScheme.colors.base07}";

      # Window borders;
      active_border_color = "#${config.colorScheme.colors.base03}";
      inactive_border_color = "#${config.colorScheme.colors.base01}";

      # Tab bar
      tab_bar_style = "fade";
      tab_fade = 1;
      
      active_tab_background = "#${config.colorScheme.colors.base00}";
      active_tab_foreground = "#${config.colorScheme.colors.base05}";
      active_tab_font_style = "bold";
      
      inactive_tab_background = "#${config.colorScheme.colors.base01}";
      inactive_tab_foreground = "#${config.colorScheme.colors.base04}";
      inactive_tab_font_style = "bold";
      
      tab_bar_background = "#${config.colorScheme.colors.base01}";

    };
  };
}
