{ pkgs, config, ...}:

{
  # My waybar config via nix settings
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
	      layer = "top";
 	      modules-left = ["custom/launcher" "cpu" "memory" "network" "custom/media"];
	      modules-center = ["wlr/workspaces"];
        # "wlr/workspaces"
	      modules-right = [ "wireplumber" "backlight" "clock"  "battery" "custom/power"];

        wireplumber = {
	        tooltip = false;
		      scroll-step = 1;
		      format = "{icon} {volume}%";
		      format-muted = "󰝟 {volume}%";
		      on-click ="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
		      format-icons = {
			      default = [""  ""  ""];
		      };
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
      		  "2" = " ";
      		  "3" = " ";
      		  "4" = " ";
      		  "5" = " ";
      		  "6" = " ";
      	  };
          smooth-scrolling-threshold = 1;
        };

	      network = {
		      tooltip = true;
		      format-wifi = " ";
		      format-ethernet = "󰈁";
          tooltip-format = "  {essid}";
          format-disconnected = " ";
	      };
	      backlight = {
		      tooltip = false;
		      format = " {}%";
		      interval =1;
          on-scroll-up = "brightnessctl s +1%";
		      on-scroll-down = "brightnessctl s 1%-";
	      };
        
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [""  ""  ""  ""  ""];
        };
	      tray ={
		      icon-size =18;
		      spacing = 10;
          format = "{} ";
	      };
        clock = {
          format = "{: %I:%M %p   %d/%m/%Y}";
        };
        cpu = {
          interval = 15;
          format = " {usage}%";
          min-length = 5;
          max-length = 5;
        };
        memory = {
          interval = 30;
          format = "󰍛 {}%";
          min-length = 5;
          max-length = 5;
        };
        "custom/media" = {
          interval = 10;
          format = "  {}";
          max-length = 30;
          tooltip = false;
          exec = "playerctl metadata --format '{{ title }} - {{ artist }}'";
          on-click = "playerctl play-pause";
        };
        "custom/launcher" ={
          tooltip = false;
          format = " ";
          on-click = "fuzzel";
        };
        "custom/power" ={
          tooltip = false;
          format = "⏻ ";
          on-click = "shutdown now";
        };
        "custom/wallpaper" ={
          format =" ";
          on-click = "bash ~/.config/system_scripts/pkill_bc";
        };  
      };
    };
    
    style = ''
* {
	border: none;
	border-radius: 10px;
    font-family: "JetbrainsMono Nerd Font" ;
	font-size: 15px;
	min-height: 10px;
}

window#waybar {
	background: transparent;
}

window#waybar.hidden {
	opacity: 0.2;
}

#window {
	margin-top: 6px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
    color: transparent;
	background: transparent;
}

#network {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	/*background: #bd93f9;*/
  background: #${config.colorScheme.colors.base0D}
}

#wireplumber {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1A1826;
	background: #${config.colorScheme.colors.base0B};
}

#battery {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	/*background: #B5E8E0;*/
  background: #FAE3B0;
 }

#battery.charging, #battery.plugged {
	color: #161320;
    background-color: #ABE983;
}

#battery.critical:not(.charging) {
    background-color: #EF6F6C;
    color: #161320;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

@keyframes blink {
    to {
        background-color: #BF616A;
        color: #B5E8E0;
    }
}

#backlight {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base0A};
}
#clock {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base0C};
	/*background: #1A1826;*/
}

#memory {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base0E};
}
#cpu {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base0F};
}

#tray {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #B5E8E0;
	background: #161320;
}

#custom-launcher {
	font-size: 24px;
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 5px;
	border-radius: 10px;
	transition: none;
    /*color: #89DCEB;*/
  color: #${config.colorScheme.colors.base04};
    background: #161320;
}

#custom-power {
	font-size: 20px;
	margin-top: 6px;
	margin-left: 8px;
	margin-right: 8px;
	padding-left: 10px;
	padding-right: 5px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base09};
}

#custom-wallpaper {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base09};
}

#custom-media {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #${config.colorScheme.colors.base05};
}

#workspaces {
  color: #d8caac;
  /*background-color: rgba(30, 32, 31, 0.7);*/
  background-color: transparent;
  border-radius: 10px;
  /*border: 3px solid #d8caac;*/
  padding-left: 320px;
  padding-right: 320px;
    
}

#workspaces button {
  /*padding-top: 3px;*/
  /*padding-bottom: 3px;*/
  /*padding-left: 5px;*/
  /*padding-right: 5px;*/
  color: #${config.colorScheme.colors.base00};
  margin-top: 6px;
	margin-left: 8px;
	padding-left: 5px;
	padding-right: 5px;
	margin-bottom: 0px;
}

#workspaces button.active {
  color: #${config.colorScheme.colors.base00};
  background-color: #${config.colorScheme.colors.base04};
}

#workspaces button:hover {
  color: #${config.colorScheme.colors.base05};
  /*background-color: #${config.colorScheme.colors.base05};*/
}

#workspaces button.focused {
  color: #${config.colorScheme.colors.base06};
  /*background-color: #${config.colorScheme.colors.base04};*/
}

#workspaces button.urgent {
  color: #161320;
}
        '';    
  };
}
