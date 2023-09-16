{

  programs.kitty = {
    enable = true;
    settings = {
      #font_family JetBrains Mono Nerd Font;

      font_size = 12;
      confirm_os_window_close = 0;

      #map ctrl+shift+c  copy_to_clipboard;
      #map ctrl+shift+v  paste_from_clipboard;

      adjust_line_height = 0;
      #cursor = "#00ccff";

      # A port of forest night by sainnhe;
      # https://github.com/sainnhe/forest-night;

      ## name:     Everforest Dark B;
      ## author:   nope;
      ## license:  idk;
      ## blurb:    everforesttttttt;

      #window;
      window_padding_width = 20;
      selection_foreground =  "#d8caac";
      selection_background =  "#505a60";
      background_opacity =  "0.5";

      foreground = "#a9b1d6";
      background = "#1a1b26";

      # Black;
      color0 = "#414868";
      color8 = "#414868";

      # Red;
      color1 = "#f7768e";
      color9 = "#f7768e";

      # Green;
      color2  = "#73daca";
      color10 = "#73daca";

      # Yellow;
      color3  = "#e0af68";
      color11 = "#e0af68";

      # Blue;
      color4  = "#7aa2f7";
      color12 = "#7aa2f7";

      # Magenta;
      color5  = "#bb9af7";
      color13 = "#bb9af7";

      # Cyan;
      color6  = "#7dcfff";
      color14 = "#7dcfff";

      # White;
      color7  = "#c0caf5";
      color15 = "#c0caf5";

      # Cursor;
      cursor = "#c0caf5";
      cursor_text_color = "#1a1b26";

      # Selection highlight;
      #selection_foreground = "none";
      #selection_background = "#28344a";

      # The color for highlighting URLs on mouse-over;
      url_color = "#9ece6a";

      # Window borders;
      active_border_color = "#3d59a1";
      inactive_border_color = "#101014";
      bell_border_color = "#e0af68";

      # Tab bar
      tab_bar_style = "fade";
      tab_fade = 1;
      active_tab_foreground = "#3d59a1";
      active_tab_background = "#16161e";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#16161e";
      inactive_tab_font_style = "bold";
      tab_bar_background = "#101014";

      # Title bar;
      #macos_titlebar_color = "#16161e";

      # Storm";
      # background = "#24283b";
      # cursor_text_color = "#24283b";
      # active_tab_background   = "#1f2335";
      # inactive_tab_background = "#1f2335";
      # macos_titlebar_color = "#1f2335";
    };
  };
}
