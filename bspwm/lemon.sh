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
        echo -n "%{A:/usr/bin/networkmanager_dmenu -l -1:}$NETWORK%{A}"
}

GetWindowName(){
        # Get the window name
        WINDOW_NAME=$(xdotool getactivewindow getwindowname)
        echo -n "$WINDOW_NAME" | cut -c 1-20
}

GetMemoryUsage(){
        MEMORY=$(free -t | awk 'NR == 2 {printf("Memory: %.2f%"), $3/$2*100}')
        echo -n "$MEMORY"
}

GetCPUUsage(){
        CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
        echo -n "CPU: $CPU"
}

LockScreen(){
        echo -n "%{A:betterlockscreen -l -u $HOME/Pictures/wallpaper.png:}Lock%{A}"
}

Shutdown(){
        echo -n "%{A:systemctl poweroff:}Shutdown%{A}"
}

while true; do
        echo "  $(Clock) | $(GetWorkspace) | $(GetVolume) | $(GetNetwork) | $(GetWindowName) | $(GetMemoryUsage) | $(GetCPUUsage) %{r}$(LockScreen) | $(Shutdown) %{r} "
        sleep 0.5
done
