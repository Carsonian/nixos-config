#!/usr/bin/env bash

# Theme path
theme="$HOME/.config/rofi/powermenu.rasi"

# CMDs
uptime="`awk '{printf("%d days, %d hours, %02d mins, %02d seconds\n",($1/60/60/24),($1/60/60%24),($1/60%60),($1%60))}' /proc/uptime | cut -c 9-50`"
# uptime="`awk '{printf("%d days, %d hours, %02d mins, %02d seconds\n",($1/60/60/24),($1/60/60%24),($1/60%60),($1%60))}' /proc/uptime`"
host=`hostname`

# Options
shutdown='⏻'
reboot=''
lock=''
suspend=''
logout=''
yes='󰄬'
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${theme}
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${theme}
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
			systemctl suspend
		elif [[ $1 == '--logout' ]]; then
		    if [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
				hyprctl dispatch exit
			elif [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			fi
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		swaylock -fF --screenshots --effect-vignette 0.8:0.8 --effect-greyscale --effect-blur 3x3 --clock --indicator --ring-ver-color 00cc0080 --inside-ver-color b8bb26
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
