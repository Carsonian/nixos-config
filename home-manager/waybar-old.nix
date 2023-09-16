{
  # My waybar config via nix settings
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
	      layer = "top";
	        modules-left = ["custom/launcher" "cpu""memory" "idle_inhibitor" "hyprland/window"];
	        modules-center = ["wlr/workspaces" "custom/waybar-media"];
	        modules-right = ["tray" "pulseaudio" "backlight" "network" "clock" "battery" "custom/power"];
	        pulseaudio = {
		        tooltip = false;
		        scroll-step = 5;
		        format = "{icon} {volume}%";
		        format-muted = " {volume}%";
		        on-click ="pactl set-sink-mute @DEFAULT_SINK@ toggle";
		        on-click-right ="gnome-control-center sound";
		        on-click-middle ="gnome-control-center sound";
		        format-icons = {
			        default = ["" "" ""];
		        };
	        };
	        
	        "custom/rarr" = {
	          format = "";
	        };
	        "custom/rarr#1" = {
	          format = "";
	        };
	        "custom/rarr#2" = {
	          format = "";
	        };
	        "custom/rarr#3" = {
	          format = "";
	        };
	        
	        "custom/larr" = {
	          format = "";
	        };
	        "custom/larr#1" = {
	          format = "";
	        };
	        "custom/larr#2" = {
	          format = "";
	        };
	        "custom/larr#3" = {
	          format = "";
	        };
	        "custom/larr#4" = {
	          format = "";
	        };
	        
	        idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };

          "hyprland/window" = {
            max-length = 29;
            format = "󰌪 {}";
          };
          
          "hyprland/language" = {
            format = " {}";
            format-us = "us";
            format-vi = "vi";
            keyboard-name = "AT Translated Set 2 keyboard";
          };
	        
          "wlr/workspaces" = {
            workspace-warparound ="false";
            on-click = "activate";
            all-outputs = true;
            sort-by-number = true;
            sort-by-name = false;
            format = "{icon}";
            format-icons = {
      		    "1" = " ";
      		    "2" = " ";
      		    "3" = " ";
      		    "4" = "﫸 ";
      		    "5" = "漣 ";
      		    "6" = " ";
      	    };
            #format-icons = ["" "" "" "" "﫸" "漣"];
            smooth-scrolling-threshold = 1;
          };

          "river/tags" = {
		        num-tags = 6;
          };
	        network = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            # format-wifi = " {essid}";
            format-wifi = " ";
            format-ethernet = " {ipaddr}/{cidr}";
            tooltip-format = " {essid} | {gwaddr}";
            format-linked = " {ifname} (No IP)";
            format-disconnected = "⚠ Disconnected";
            # format-alt = "{ifname}: {ipaddr}/{cidr}";
            format-alt = " {essid}";
            on-click-right = "gnome-control-center wifi";
            on-click-middle = "gnome-control-center wifi";
          };
	        backlight = {
		        tooltip = false;
		        # format = "盛 {}%";
		        format = "盛 ";
		        format-alt = "盛 {}%";
		        interval =1;
            on-scroll-up = "light -A 5";
		        on-scroll-down = "light -U 5";
	        };
          battery = {
            states = {
              good = 90;
              warning = 20;
              critical = 20;
            };
            format = "{icon}  {capacity}%";
            format-charging = "{icon}  {capacity}%";
            format-plugged = "{icon}  {capacity}%";
            format-alt = "{icon}  {time}";
            format-icons = ["" "" "" "" ""];
            on-click-right = "gnome-control-center power";
            on-click-middle = "gnome-control-center power";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-";
          };
	        tray ={
		        icon-size =18;
		        spacing = 10;
		        format = "{} ";
	        };
          clock = {
            format = "{: %I:%M %p   %d/%m/%Y}";
            format-alt = "{: %r   %d/%m/%Y}";
            on-click = "eww open --toggle calendar";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
            interval = 1;
          };
          cpu = {
            interval = 55;
            format = " {}%";
            max-length = 10;
            on-click-right = "kitty btm";
            on-click-middle = "kitty btm";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          memory = {
            interval = 5;
            format = " {used} GiB 易 {swapUsed} GiB";
            on-click-right = "kitty btm";
            on-click-middle = "kitty btm";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/media" = {
            interval = 30;
            format = "{icon} {}";
            return-type = "json";
            max-length = 20;
            format-icons = {
              spotify = " ";
              default = " ";
            };
            escape = true;
            exec = "$HOME/.config/system_scripts/mediaplayer.py 2> /dev/null";
            on-click = "playerctl play-pause";
          };
          "custom/launcher" ={
            format = " ";
            on-click = "fuzzel";
            #on-scroll-down = "hyprctl dispatch workspace +1";
            #on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/power" ={
            format = "  ";
            on-click = "eww open --toggle system-menu";
            on-click-middle = "hyprctl dispatch exit exit";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-";
          };
          "custom/wallpaper" ={
            format =" ";
            on-click = "bash ~/.config/system_scripts/pkill_bc";
          };
          "custom/ws#1" ={
            format = "  ";
            on-click = "hyprctl dispatch workspace 1";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#2" ={
            format = "  ";
            on-click = "hyprctl dispatch workspace 2";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#3" ={
            format = "  ";
            on-click = "hyprctl dispatch workspace 3";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#4" ={
            format = " 﫸 ";
            on-click = "hyprctl dispatch workspace 4";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#5" ={
            format = " 﨩 ";
            on-click = "hyprctl dispatch workspace 5";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#6" ={
            format = "  ";
            on-click = "hyprctl dispatch workspace 6";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
          "custom/ws#7" ={
            format = "  ";
            on-click = "hyprctl dispatch workspace 7";
            on-scroll-down = "hyprctl dispatch workspace +1";
            on-scroll-up = "hyprctl dispatch workspace -1";
          };
      };
      # [    﫸  ]
      "custom/waybar-media" = {
        return-type = "json";
        exec = "waybar-media.py status";
        on-click = "waybar-media.py playpause";
        on-scroll-up = "waybar-media.py previous";
        on-scroll-down = "waybar-media.py next";
        escape = true;
      };

      mpd = {
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
        format-disconnected = "Disconnected ";
        format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        interval = 10;
        consume-icons = {
          on = " "; # Icon shows only when "consume" is on
        };
        random-icons = {
          off = "<span color=\"#f53c3c\"></span> "; # Icon grayed out when "random" is off
          on = " ";
        };
        repeat-icons = {
          on = " ";
        };
        single-icons = {
          on = "1 ";
        };
        state-icons = {
          paused = "";
          playing = "";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
      };
    };
    
    style = ''

/**
 Paralellogram: transform: skew(20deg);



**/
* {
  border-radius: 10px;
  padding: 0 0 0 0;
  margin: 0 0 0 0;
  font-family: "SF Mono Nerd Font";
  /*font-family: "Ubuntu Nerd Font"; */
	min-height: 25px;
	font-size: 12pt;
}

#waybar {
  margin-left: 0;
  margin-right: 0;
	background: transparent;
}

#waybar.hidden {
	opacity: 0.2;
}

#custom-launcher {
  margin-left: 0px;
  background-color: #1e201f;
  color: #d8caac;
  padding-top: 1px;
  padding-bottom: 1px;
  border-radius: 12px;
  border: 3px solid transparent;
  padding-left: 5px;
  padding-right: 2px;
  
}

#clock {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
  
}

#cpu {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
  
  
}

#memory {
	color: #d8caac;
  background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
  
  
}

#idle_inhibitor {
  color: #D8CAAC;
  background-color: #1e201f;
  border-radius: 12px;
  /*border: 3px solid transparent;*/
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#window {
  color: #d8caac;
  background-color: #1e201f;
  border-radius: 12px;
  /*border: 3px solid transparent;*/
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#workspaces {
  color: #d8caac;
  /*background-color: rgba(30, 32, 31, 0.7);*/
  background-color: transparent;
  border-radius: 12px;
  /*border: 3px solid #d8caac;*/
  padding-left: 320px;
  padding-right: 320px;
    
}

#workspaces button {
  padding-top: 3px;
  padding-bottom: 3px;
  padding-left: 5px;
  padding-right: 5px;
  color: #d8caac;
    
  
}

#workspaces button.active {
  color: #161320;
  background-color: #a8b370;
}

#workspaces button:hover {
  color: #161320;
  
}

#workspaces button.focused {
  color: #161320;
  
}

#workspaces button.urgent {
  color: #161320;
  
}

#tray {
	margin-left: 10px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #d8caac;
	background: #1E201F;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
	
}
#tray menu{
  padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	color: #D8CAAC;
	background-color: #1E201F;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
	
}


#pulseaudio {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
	
	
}

#backlight {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 0px;
	
  
}

#network {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  /*margin-left: 3px;
  margin-right: 4px;*/
  padding-left: 5px;
  padding-right: 4px;
	
  
}

#battery {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  margin-left: 3px;
  margin-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
	
  
}

#battery.charging, #battery.plugged {
	  color: #A8B468;
    background-color: #1e201f;
}

#battery.critical:not(.charging) {
    background-color: #B5E8E0;
    color: #161320;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

/*
#battery.good {
	  color: #B1E0AD;
    background-color: #D4B7F7;
}
*/

#custom-power {
	color: #d8caac;
	background-color: #1e201f;
  border-radius: 12px;
  border: 3px solid transparent;
  padding-left: 1px;
  padding-right: 5px;
}

@keyframes blink {
    to {
        background-color: #BF616A;
        color: #B5E8E0;
    }
}


#custom-ws{
  
  background-color: #f7cdec;
  color: #161320;
}

/* Unused */

#idle_inhibitor{
	  color: #161320;
}

#custom-wallpaper {
	  color: #161320;
}

#custom-updates {
	  color: #161320;
}

#custom-media {
	  color: #161320;
}

#battery.warning:not(.charging) {
    background: #f53c3c;
    color: white;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}





/* Hover */
#custom-launcher:hover {
  color: #3E5B32;
  background-color: #A8B468;
}

#clock:hover {
  color: #3E5B32;
  background-color: #A8B468;
}

#cpu:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#memory:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#window:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#workspaces button.active:hover {
    color: #d8caac;
    background-color: #e76c69;
}

#workspaces button:hover {
  color: #3E5B32;
  background-color: #e76c69;
  
}

#tray:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#pulseaudio:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#backlight:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#network:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#battery:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

#battery.charging, #battery.plugged:hover {
  color: #3E5B32;
  background-color: #A8B468;
	  
}

#battery.critical:not(.charging):hover {
  color: #d8caac;
  background-color: #e76c69;
    
}

/*
#battery.good {
	  color: #B1E0AD;
    background-color: #D4B7F7;
}
*/

#custom-power:hover {
  color: #3E5B32;
  background-color: #A8B468;
	
}

        '';    
};
}
