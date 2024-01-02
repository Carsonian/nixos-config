{ pkgs, config, ...}:

{
  # Hyprland config 
  wayland.windowManager.hyprland = {
    enable = true;
    settings =  {
      # Put hyprland config here in nixos form

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor= "eDP-1,1920x1080@60,0x0,1";

      # Execute apps at launch
      exec-once = ["dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY in hyrpland.conf"
                   "waybar"
                   "wpaperd"
                  ];

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      # This just makes it use logind first, avoiding an annoying message about skipping seatd
      env = ["XCURSOR_SIZE,24" "LIBSEAT_BACKEND,logind"];

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_options = "ctrl:nocaps";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
          clickfinger_behavior = 1;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/
        
        gaps_in = 10;
        gaps_out = 10;
        border_size = 2;
        #"col.active_border" = " rgb(09E85E) rgb(F4D06F) 45deg";
        #"col.active_border" = " rgb(${config.colorScheme.colors.base0A}) rgb(${config.colorScheme.colors.base0B}) 45deg";
        "col.active_border" = " rgb(${config.colorScheme.colors.base0B})";
        "col.inactive_border" = "rgb(1E2D24)";
        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vfr = true;
        vrr = 0;
        animate_manual_resizes = true;
        mouse_move_focuses_monitor = true;
        enable_swallow = true;
        swallow_regex = "^(wezterm)$";
      };

      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        blur = {
          enabled = "yes";
          size = 3;
          passes = 1;
          new_optimizations = "on";
          xray = true;
          ignore_opacity = true;
        };

        drop_shadow = "no";
        shadow_ignore_window = true;
        shadow_offset = "1 2";
        shadow_range = 10;
        shadow_render_power = 5;
        "col.shadow" = "0x66404040";
      };

      animations = {
        enabled = "yes";

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ]; 

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
        
      };

      dwindle = {
        force_split = 2;
        smart_resizing = false;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe=1;
        workspace_swipe_distance=400;
        workspace_swipe_invert=1;
        workspace_swipe_min_speed_to_force=30;
        workspace_swipe_cancel_ratio=0.5;
        workspace_swipe_create_new=0;
        workspace_swipe_forever=0;
      };

      
      windowrule=["opacity 1.0 override 0.9 override,^(firefox)$"
                  "opacity 0.9 override 0.8 override,^(neovide)$"];
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/


      # KEYBINDINGS ###########################################

      "$mainMod" = "SUPER";
      
      # Utility keybinds

      bind = [
        "$mainMod, Q, killactive"
        "SUPER_SHIFT, X, exit, "
        "$mainMod, right , swapwindow, r"
        "$mainMod, left, swapwindow, l"
        "$mainMod, up, swapwindow, u"
        "$mainMod, down, swapwindow, d"
        "$mainMod SHIFT, right, resizeactive, 25 0"
        "$mainMod SHIFT, left, resizeactive, -25 0"
        "$mainMod SHIFT, up, resizeactive, 0 -25"
        "$mainMod SHIFT, down, resizeactive, 0 25"
        "$mainMod, T, togglesplit,"

        # Exec programs
        "$mainMod, return, exec, kitty"
        "$mainMod, F, exec, firefox"
        "$mainMod, E, exec, neovide"
        "$mainMod, L, exec, swaylock -fF --screenshots --effect-vignette 0.8:0.8 --effect-greyscale --effect-blur 3x3 --clock --indicator --ring-ver-color 00cc0080 --inside-ver-color ${config.colorScheme.colors.base0B}"
        "$mainMod, R, exec, rofi -show"
        "$mainMod, P, exec, ~/.config/rofi/powermenu.sh"
        "$mainMod, V, exec, ~/.config/rofi/volume-applet.sh"
        "$mainMod, M, exec, ~/.config/rofi/mpd-applet.sh"
        
        # Cycle focus with n & p 
        "$mainMod, N, cyclenext"
        "$mainMod, P, cyclenext, prev"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # Scroll through existing workspaces with mainMod + scroll"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      
      # Move/resize windows with mainMod + LMB/RMB and dragging"
      bindm = ["$mainMod, mouse:272, movewindow"
               "$mainMod, mouse:273, resizewindow"
              ];
    };
    extraConfig = '''';
  };
}
