#!/usr/bin/env bash

theme="$HOME/.config/rofi/applet.rasi"

status="`playerctl status`"
loop="`playerctl loop`"
shuffle="`playerctl shuffle`"
artist="`playerctl metadata --format "{{ artist }} - {{ album }}"`"
song="`playerctl metadata --format "Now Playing: {{ title }} - {{ duration(position) }}/{{ duration(mpris:length) }}"`"

if [[ -z "$status" ]]; then
    prompt='Offline'
    mesg="MPD is Offline"
elif [[ ${status} == "Playing" || ${status} == "Paused" ]]; then
    prompt=${artist}
    mesg=${song}
else
    prompt='None'
    mesg="Nothing is playing"
fi
	list_col='6'
	list_row='1'

# Options
	if [[ ${status} == "Playing" ]]; then
	    option_1="󰏤"
	else
	    option_1="󰐊"
	fi
	option_2="󰓛"
	option_3="󰒮"
	option_4="󰒭"
	option_5="󰑖"
	option_6="󰒝"

# Toggle Actions
active=''
urgent=''
# Repeat
if [[ ${loop} == "Track" || ${loop} == "Playlist" ]]; then
    active="-a 4"
elif [[ ${loop} == "None" ]]; then
    urgent="-u 4"
else
    option_5=" Parsing Error"
fi
# Random
if [[ ${shuffle} == "On" ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [ ${shuffle} == "Off" ]; then
    [[ -n "$urgent" ]] && urgent+=",5" || urgent="-u 5"
else
    option_6=" Parsing Error"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
	playerctl play-pause
    elif [[ "$1" == '--opt2' ]]; then
	playerctl stop
    elif [[ "$1" == '--opt3' ]]; then
	playerctl previous
    elif [[ "$1" == '--opt4' ]]; then
	playerctl next
    elif [[ "$1" == '--opt5' ]]; then
	if [[ ${loop} == "Track" || ${loop} == "Playlist" ]]; then
	    playerctl loop "None"
	elif [[ ${loop} == "None" ]]; then
	    playerctl loop "Track"
	else
	    option_5=" Parsing Error"
	fi
    elif [[ "$1" == '--opt6' ]]; then
	if [[ ${shuffle} == "On" ]]; then
	    playerctl shuffle "Off"
	elif [ ${shuffle} == "Off" ]; then
	    playerctl shuffle "On"
	else
	    option_6=" Parsing Error"
	fi	
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
