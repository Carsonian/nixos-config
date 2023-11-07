{ pkgs, config, ...}:

{
  # My waybar config via nix settings
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "position" = "top";
        "layer" = "top";
        "height" = 16;
        "margin-top" = 0;
        "margin-bottom" = 0;
        "margin-left" = 0;
        "margin-right" = 0;
        "modules-left" = ["custom/launcher" "cpu" "memory" "disk" "custom/playerctl" "custom/playerlabel"];
        "modules-center" = [ "hyprland/workspaces"];
        "modules-right" = ["tray" "wireplumber" "backlight" "network" "clock" "battery"];
        
        # Modules configuration
	      "clock" = {
		      "format" = "  {:%H:%M}";
        	"format-alt" = "  {:%d/%m}";
          "tooltip" = "false";
	      };
	      
	      "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = false;
          "disable-scroll" = true;
		      "format" = "{icon}";
		      "on-click" = "activate";
		      "format-icons" = {
			      "urgent" = "";
			      "active" = "";
			      "default" = "󰧞";
            "sort-by-number" = true;
          };
        };

        "custom/playerctl" = {
          "format" = "{icon}";
          tooltip = false;
          "return-type" = "json";
          "max-length" = 64;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click" = "playerctl play-pause";
          "on-click-middle" = "playerctl previous";
          "on-click-right" = "playerctl next";
          "format-icons" = {
            "Playing" = "<span foreground='#${config.colorScheme.colors.base06}'>󰒮 󰐌 󰒭</span>";
            "Paused" = "<span foreground='#${config.colorScheme.colors.base04}'>󰒮 󰏥 󰒭</span>";
          };
        };

        "custom/playerlabel" = {
          tooltip = false;
          "format" = "<span>{}</span>";
          "return-type" = "json";
          "max-length" = 48;
          "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          "on-click" = "playerctl play-pause";
          "on-click-middle" = "playerctl previous";
          "on-click-right" = "playerctl next";
        };

        battery = {
          states = {
            good = 95;
            warning = 20;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}%  ";
          format-plugged = "{capacity}%  ";
          format-alt = "{time} {icon}";
          format-icons = [" "  " "  " "  " "  " "];
        };
        
        "memory" = {
          "format" = "<span color=\"#${config.colorScheme.colors.base0F}\"> </span>  {}%";
          tooltip-format = "{used}/{total} GiB";
          "interval" = 5;
          min-length = 6;
          max-length = 6;
        };

        "cpu" = {
          "format" = "<span color=\"#${config.colorScheme.colors.base0E}\">󰄧 </span> {usage}%";
          "interval" = 5;
          min-length = 6;
          max-length = 6;
        };

        "disk" = {
          "format" = "<span color=\"#${config.colorScheme.colors.base0D}\">󰋊 </span> {percentage_used}%";
          tooltip-format ="{used}/{total}";
          "interval" = 5;
          "path" = "/";
          min-length = 6;
          max-length = 6;
        };

        network = {
		      tooltip = true;
		      format-wifi = " ";
		      format-ethernet = "󰈁";
          tooltip-format = "   {essid}";
          format-disconnected = " ";
	      };

	      "tray" = {
		      "icon-size" = 16;
		      "spacing" = 5;
	      };

        wireplumber = {
	        tooltip = false;
		      scroll-step = 1;
		      format = "<span>{icon} </span>  {volume}%";
		      format-muted = "<span>󰝟 </span> {volume}%";
		      on-click ="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
		      format-icons = {
			      default = [""  ""  ""];
		      };
        };

        backlight = {
		      tooltip = false;
		      format = "<span>{icon} </span> {}%";
          "format-icons" = ["" "" "" "" "" "" "" "" "󰖨"];
		      interval =1;
          on-scroll-up = "brightnessctl s +1%";
		      on-scroll-down = "brightnessctl s 1%-";
	      };

        "custom/launcher" ={
          tooltip = false;
          format = " ";
          on-click = "fuzzel";
        };
      };
    };
    
    style = ''
    * {
    border: none;
    border-radius: 0px;
    font-family: JetbrainsMono Nerd Fonts;
    font-size: 14px;
    font-style: normal;
    min-height: 0;
    }

window#waybar {
    background: rgba(30, 30, 46, 0.5);
    border-bottom: 1px solid #282828;
    color: #f4d9e1
}

.modules-right {
    /*background-color: transparent;*/
    background-color: #${config.colorScheme.colors.base01};
    color: #${config.colorScheme.colors.base06};
    border-radius: 16px;
    font-size: 12px;
    padding: 5px 15px 5px 10px;
	  margin: 5px 15px 5px 5px;
    border-radius: 16px;
}

#workspaces {
	background: #${config.colorScheme.colors.base01};
	margin: 5px 5px 5px 5px;
  padding: 0px 9px 0px 5px;
	border-radius: 16px;
  border: solid 0px #f4d9e1;
  font-weight: normal;
  font-style: normal;
}

#workspaces button {
    color: #${config.colorScheme.colors.base01};
    padding: 0px 5px;
    border-radius: 16px;
    color: #928374;
}

#workspaces button.active {
    color: #${config.colorScheme.colors.base09};
    background-color: transparent;
    border-radius: 16px;
}

#custom-power {
	color: #${config.colorScheme.colors.base0B};
	background-color: #${config.colorScheme.colors.base01};
	border-radius: 5px;
	margin-right: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 0px;
	padding: 5px 10px;
}

#tray {
    background: #${config.colorScheme.colors.base01};
    margin: 5px 5px 5px 5px;
    border-radius: 16px;
    padding: 0px 5px;
    /*border-right: solid 1px #282738;*/
}

#wireplumber {
    margin-left: 6px;
}

#backlight {
    margin-left: 12px;
}

#network {
    margin-left: 12px;
}

#clock {
    margin-left: 15px;
}

#battery {
    margin-left: 12px;
    margin-right: 6px;
    color: #9ece6a;
}

#battery.charging {
    color: #9ece6a;
    margin-left: 10px;
    margin-right: 6px;
}

#battery.warning:not(.charging) {
    margin-left: 10px;
    margin-right: 6px;
    color: #f7768e;
    border-radius: 5px 5px 5px 5px;
}

#cpu, #memory, #disk {
    background-color: #${config.colorScheme.colors.base01};
    color: #${config.colorScheme.colors.base06};
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#custom-launcher
{
    background-color: #${config.colorScheme.colors.base00};
    font-size: 24px;
    color: #${config.colorScheme.colors.base0B};
    border-radius: 0px 24px 0px 0px;
    margin: 0px 0px 0px 0px;
    padding: 0 10px 0 10px;
    font-weight: bold;
}

#custom-playerctl {
	background: #${config.colorScheme.colors.base00};
  color: #${config.colorScheme.colors.base06};
	padding-left: 15px;
  padding-right: 15px;
	border-radius: 16px;
  /*border-left: solid 1px #282738;*/
  /*border-right: solid 1px #282738;*/
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 0px;
  font-weight: normal;
  font-style: normal;
  font-size: 15px;
}

#custom-playerlabel {
    background: transparent;
    color: #${config.colorScheme.colors.base06};
    padding-left: 10px;
    padding-right: 15px;
    border-radius: 16px;
    /*border-left: solid 1px #282738;*/
    /*border-right: solid 1px #282738;*/
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
}

#window {
    background: #282828;
    padding-left: 15px;
    padding-right: 15px;
    border-radius: 16px;
    /*border-left: solid 1px #282738;*/
    /*border-right: solid 1px #282738;*/
    margin-top: 5px;
    margin-bottom: 5px;
    font-weight: normal;
    font-style: normal;
}

        '';    
  };
}
