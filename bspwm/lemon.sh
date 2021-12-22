#!/usr/bin/bash

# Define the clock
Clock() {
        DATETIME=$(date "+%a %b %d, %T")

        echo -n "$DATETIME"
}

GetWorkspace() {
        # Get the workspace name
        WORKSPACE=$(bspc query -D -d focused --names)
        FORMAT=""
        NOOFWORKSPACE=$(bspc query -D | wc -l)
        for i in $(seq 1 $NOOFWORKSPACE)
        do
                NO=$(bspc query -N -d $i -n .window.\!hidden | wc -l)
                FORMAT="$FORMAT%{A:bspc desktop --focus $i:} ${NO}w${i} %{A}"
        done

        OUTPUT=$(echo $FORMAT | sed "s/w$WORKSPACE/%{+o}&%{-o}/g")

        echo -n "$OUTPUT"
}

GetVolume(){
        # Get the volume
        VOLUME=$(amixer get Master | grep -o "[0-9]*%" | head -n 1 | tr -d '%')
        echo -n "%{A5:pactl set-sink-volume 0 -1%:}%{A2:pavucontrol:}%{A4:pactl set-sink-volume 0 +1%:}$VOLUME%%%{A}%{A}%{A}"
}


GetNetwork(){
        # Get the network
        NETWORK=$(nmcli dev status | grep  -E "wl.[0-9]*"  | head -n 1 | sed 's/    */:/g' | cut -d ":" -f 3) #3-4 for ssid
        echo -n "%{A:/usr/bin/networkmanager_dmenu:}$NETWORK%{A}"
}

GetWindowName(){
        # Get the window name
        WINDOW_NAME=$(xdotool getactivewindow getwindowname)
        echo -n "$WINDOW_NAME"
}

LockScreen(){
        echo -n "%{A:betterlockscreen -l:}Lock%{A}"
}

Shutdown(){
        echo -n "%{A:systemctl poweroff:}Shutdown%{A}"
}

while true; do
        echo "  $(Clock) | $(GetWorkspace) | $(GetVolume) | $(GetNetwork) | $(GetWindowName) | %{r}$(LockScreen) | $(Shutdown) %{r} "
        sleep 0.5
done
