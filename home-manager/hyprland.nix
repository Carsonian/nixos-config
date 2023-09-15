{
  # Hyprland config 
  wayland.windowManager.hyprland = {
    enable = true;
    settings =  {
      # Start of hyprland config
      # Put hyprland config here in nixos form

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor= "preferred,auto,auto";

      # Execute apps at launch
      exec-once = "waybar & hyprpaper";

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
        
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        col.inactive_border = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ 

        rounding = 10;

        blur = {
          enabled = "yes";
          size = 3;
          passes = 1;
          new_optimizations = "on";
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        col.shadow = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "Oworkspaces, 1, 6, default"
        ]; 
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/
        workspace_swipe = "off";
      };

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
        "$mainMod, V, togglefloating, "
        "$mainMod, G, pseudo, "# dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Exec programs
        "$mainMod, return, exec, kitty"
        "$mainMod, F, exec, firefox"
        "$mainMod, R, exec, wofi --show drun"
        
        # Cycle focus with n & p (emacs keys) 
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

    #extraConfig = ''
      
  };
}
