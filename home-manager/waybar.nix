{
  # My waybar config via nix settings
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
	      layer = "top";
	      modules-left = ["custom/launcher" "cpu" "memory" "custom/media" "network" "tray"];
	      modules-center = ["river/tags"];
	      modules-right = ["custom/updates" "custom/wallpaper" "backlight" "pulseaudio" "clock"  "battery" "custom/power"];
	      
	      pulseaudio = {
		      tooltip = false;
		      scroll-step = 5;
		      format = "{icon} {volume}%";
		      format-muted = "{icon} {volume}%";
		    on-click ="pactl set-sink-mute @DEFAULT_SINK@ toggle";
		    format-icons = {
			    default = [""  ""  ""];
		    };
	      };

        "river/tags" = {
		      num-tags = 6;
        };
	        network = {
		        tooltip = false;
		        format-wifi = "  {essid}";
		        format-ethernet = "";
	        };
	        backlight = {
		        tooltip = false;
		        format = " {}%";
		        interval =1;
            on-scroll-up = "light -A 5";
		        on-scroll-down = "light -U 5";
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
	        };
            clock = {
              format = "{: %I:%M %p   %d/%m/%Y}";
            };
            cpu = {
            interval = 15;
            format = " {}%";
            max-length = 10;
            };
          memory = {
            interval = 30;
            format = "󰍛 {}%";
            max-length = 10;
          };
          "custom/media" = {
            interval = 30;
            format = "{icon} {}";
            return-type = "json";
            max-length = 20;
            format-icons = {
              spotify = " ";
              default = " ";
            };
            escape = true;
            exec = "$HOME/.config/system_scripts/mediaplayer.py 2> /dev/null";
            on-click = "playerctl play-pause";
          };
          "custom/launcher" ={
            format = " ";
            on-click = "fuzzel";
            #on-click-right = "killall rofi";
          };
          "custom/power" ={
            format = " ";
            on-click = "bash ~/.config/rofi/leave/leave.sh";
          };
          # "custom/updates" ={
          #   format = "{} Update(s)";
          #   exec = "checkupdates | wc -l";
          #   exec-if = "[[ $(checkupdates | wc -l) != 0 ]]";
          #   interval = 15;
          #   on-click = "alacritty -e paru -Syu && notify-send 'The system has been updated' ";
          # };
          "custom/wallpaper" ={
            format =" ";
            on-click = "bash ~/.config/system_scripts/pkill_bc";
          };  
      };
    };
      
    style = ''
* {
	border: none;
	border-radius: 10;
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
#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #161320;
	transition: none;
}

#tags button {
	transition: none;
	color: #B5E8E0;
	background: transparent;
	font-size: 16px;
	border-radius: 2px;
}

#tags button.occupied {
	transition: none;
	color: #F28FAD;
	background: transparent;
	font-size: 4px;
}

#tags button.focused {
	color: #ABE9B3;
    border-top: 2px solid #ABE9B3;
    border-bottom: 2px solid #ABE9B3;
}

#tags button:hover {
	transition: none;
	box-shadow: inherit;
	text-shadow: inherit;
	color: #FAE3B0;
    border-color: #E8A2AF;
    color: #E8A2AF;
}

#tags button.focused:hover {
    color: #E8A2AF;
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
	background: #bd93f9;
}

#pulseaudio {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1A1826;
	background: #FAE3B0;
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
	background: #B5E8E0;
}

#battery.charging, #battery.plugged {
	color: #161320;
    background-color: #B5E8E0;
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
	background: #F8BD96;
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
	background: #ABE9B3;
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
	background: #DDB6F2;
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
	background: #96CDFB;
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
    color: #89DCEB;
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
	background: #F28FAD;
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
	background: #C9CBFF;
}

#custom-updates {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #161320;
	background: #E8A2AF;
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
	background: #F2CDCD;
}
        '';    
  };
}