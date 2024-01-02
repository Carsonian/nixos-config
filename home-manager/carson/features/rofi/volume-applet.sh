#!/usr/bin/env bash

theme="$HOME/.config/rofi/applet.rasi"

# Volume Info
speaker="`wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -c 11-12 | sed 's/$/%/'`"
mic="`wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | cut -c 11-12 | sed 's/$/%/'`"
bluetooth_device="`bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Connected\|Name"| head -1 | cut -c 8-50 `"
bluetooth_connected="`bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Connected\|Name"| tail -1| cut -c 13-50`"

if [[ ${bluetooth_connected} == "yes" ]]; then
    bluetooth_connected="Connected"
else
    bluetooth_connected="Disconnected"
fi  

active=""
urgent=""

# Speaker Info
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep '\[MUTED\]'; then
	active="-a 1"
	stext='Unmute'
	sicon='󰕾'
else
	urgent="-u 1"
	stext='Mute'
	sicon='󰖁'
fi

# Microphone Info
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep '\[MUTED\]'; then
    [ -n "$active" ] && active+=",3" || active="-a 3"
	mtext='Mute'
	micon='󰍭'
else
    [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
	mtext='Unmuted'
	micon='󰍬'
fi

# Theme Elements
prompt="Volume - $speaker"
mesg="󰂯 $bluetooth_device - $bluetooth_connected"
list_col='5'
list_row='1'
win_width='670px'

# Options
option_1="󰝝"
option_2="$sicon"
option_3="󰝞"
option_4="$micon"
option_5="󰂳"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "󰕾";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Execute Command
run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
	wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
    elif [[ "$1" == '--opt2' ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    elif [[ "$1" == '--opt3' ]]; then
	wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
    elif [[ "$1" == '--opt4' ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
	elif [[ "$1" == '--opt5' ]]; then
		kitty -e bluetuith
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
esac
