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
          "modules-right" = ["tray" "wireplumber" "backlight" "network" "battery" "clock"];
          
          # Modules configuration
	          "clock" = {
		          "format" = "  {:%H:%M}";
		        "tooltip" = "true";
        	  "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        	  "format-alt" = "  {:%d/%m}";
	          };
	        
	          "hyprland/workspaces" = {
              "active-only" = false;
              "all-outputs" = true;
              "disable-scroll" = true;
		          "format" = "{icon}";
		          "on-click" = "activate";
		          "format-icons" = {
                "1" = "󰧞";
                "2" = "󰧞";
			          "urgent" = "";
			          "active" = "";
			          "default" = "󰧞";
                "sort-by-number" = true;
              };
              "persistent-workspaces" = {
                "*" = 2; # 2 workspaces by default on every monitor
              };
            };

            "custom/playerctl" = {
              "format" = "{icon}";
              "return-type" = "json";
              "max-length" = 64;
              "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
              "on-click-middle" = "playerctl play-pause";
              "on-click" = "playerctl previous";
              "on-click-right" = "playerctl next";
              "format-icons" = {
                "Playing" = "<span foreground='#E5B9C6'>󰒮 󰐌 󰒭</span>";
                "Paused" = "<span foreground='#928374'>󰒮 󰏥 󰒭</span>";
              };
            };

            "custom/playerlabel" = {
              "format" = "<span>{}</span>";
              "return-type" = "json";
              "max-length" = 48;
              "exec" = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
              "on-click-middle" = "playerctl play-pause";
              "on-click" = "playerctl previous";
              "on-click-right" = "playerctl next";
              "format-icons" = {
                "Playing" = "<span foreground='#E5B9C6'>󰒮 󰐌 󰒭</span>";
                "Paused" = "<span foreground='#928374'>󰒮 󰏥 󰒭</span>";
              };
            };


            battery = {
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-charging = "{capacity}%  ";
              format-plugged = "{capacity}%  ";
              format-alt = "{time} {icon}";
              format-icons = [" "  " "  " "  " "  " "];
            };
            
            "memory" = {
              "format" = "󰍛 {}%";
              "format-alt" = "󰍛 {used}/{total} GiB";
              "interval" = 5;
            };

            "cpu" = {
              "format" = " {usage}%";
              "format-alt" = " {avg_frequency} GHz";
              "interval" = 5;
            };

            "disk" = {
              "format" = "󰋊 {}%";
              "format-alt" = "󰋊 {used}/{total} GiB";
              "interval" = 5;
              "path" = "/";
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
		          format = "{icon}  {volume}%";
		          format-muted = "󰝟  {volume}%";
		          on-click ="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
		          format-icons = {
			          default = [""  ""  ""];
		          };
            };

            backlight = {
		          tooltip = false;
		          format = "{icon} {}%";
              "format-icons" = ["" "" "" "" "" "" "" "" ""];
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

#workspaces {
	background: #${config.colorScheme.colors.base01};
	margin: 5px 5px 5px 5px;
  padding: 0px 5px 0px 5px;
	border-radius: 16px;
  border: solid 0px #f4d9e1;
  font-weight: normal;
  font-style: normal;
}
#workspaces button {
    color: #${config.colorScheme.colors.base06};
    padding: 0px 5px;
    border-radius: 16px;
    color: #928374;
}

#workspaces button.active {
    color: #${config.colorScheme.colors.base09};
    background-color: transparent;
    border-radius: 16px;
}

#custom-date, #clock, #battery, #network #wireplumber {
	background: transparent;
	padding: 5px 5px 5px 5px;
	margin: 5px 5px 5px 5px;
  border-radius: 8px;
  border: solid 0px #f4d9e1;
}

#custom-date {
	color: #D3869B;
}

#custom-power {
	color: #24283b;
	background-color: #db4b4b;
	border-radius: 5px;
	margin-right: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 0px;
	padding: 5px 10px;
}

#tray {
    background: #282828;
    margin: 5px 5px 5px 5px;
    border-radius: 16px;
    padding: 0px 5px;
    /*border-right: solid 1px #282738;*/
}

#clock {
    color: #${config.colorScheme.colors.base06};
    background-color: #282828;
    font-size: 15px;
    border-radius: 0px 0px 0px 24px;
    padding-left: 13px;
    padding-right: 15px;
    margin-right: 0px;
    margin-left: 10px;
    margin-top: 0px;
    margin-bottom: 0px;
    font-weight: bold;
    /*border-left: solid 1px #282738;*/
}

#battery {
    color: #9ece6a;
    font-size: 15px;
}

#battery.charging {
    color: #9ece6a;
    font-size: 15px;
}

#battery.warning:not(.charging) {
    background-color: #f7768e;
    color: #24283b;
    font-size: 15px;
    border-radius: 5px 5px 5px 5px;
}

#wireplumber {
    color: #${config.colorScheme.colors.base06};
    font-size: 15px;
    margin-left: 6px;
    margin-right: 6px;
}

#backlight {
    color: #${config.colorScheme.colors.base06};
    font-size: 15px;
    margin-left: 6px;
    margin-right: 6px;
}

#network {
    color: #${config.colorScheme.colors.base06};
    font-size: 15px;
    border-radius: 8px;
    margin-left: 6px;
    margin-right: 6px;
}

#custom-playerctl {
	background: #282828;
  color: #${config.colorScheme.colors.base06};
	padding-left: 15px;
  padding-right: 14px;
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

#custom-launcher
{
    background-color: #282828;
    font-size: 24px;
    color: #${config.colorScheme.colors.base0B};
    border-radius: 0px 24px 0px 0px;
    margin: 0px 0px 0px 0px;
    padding: 0 20px 0 13px;
    font-weight: bold;
}

#cpu {
    background-color: #282828;
    color: #${config.colorScheme.colors.base06};
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#memory {
    background-color: #282828;
    color: #${config.colorScheme.colors.base06};
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

#disk {
    background-color: #282828;
    color: #${config.colorScheme.colors.base06};
    border-radius: 16px;
    margin: 5px;
    margin-left: 5px;
    margin-right: 5px;
    padding: 0px 10px 0px 10px;
    font-weight: bold;
}

        '';    
  };
}
