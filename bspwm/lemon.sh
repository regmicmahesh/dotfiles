#!/usr/bin/bash

RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

Camera() {
        CAMERA_STATUS=$(lsmod | grep uvcvideo | head -n 1 | awk '{print $3}')
        if [ "$CAMERA_STATUS" = "1" ]; then
                echo -n " using camera "
        fi
}


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
                FORMAT="$FORMAT%{A:bspc desktop --focus $i:} ${NO} %{A}"

                #if [ $NO -eq 0 ]; then
                #        FORMAT="$FORMAT%{A:bspc desktop --focus $i:} ${i} %{A}"
                #else
                #        FORMAT="$FORMAT%{A:bspc desktop --focus $i:} ${NO}w${i} %{A}"
                #fi
        done

        OUTPUT=$(echo $FORMAT | sed "s/w$WORKSPACE/%{+o}&%{-o}/g")

        echo -n "$OUTPUT"
}

CurrentWorkspace(){
        # Get the current workspace
        WORKSPACE=$(bspc query -D -d focused --names)
        if [ $WORKSPACE -eq 1 ]; then
                echo -n "1st"
        elif [ $WORKSPACE -eq 2 ]; then
                echo -n "2nd"
        elif [ $WORKSPACE -eq 3 ]; then
                echo -n "3rd"
        else
                echo -n "$WORKSPACE"
        fi
}

GetVolume(){
        # Get the volume
        VOLUME=$(amixer get Master | grep -o "[0-9]*%" | head -n 1 | tr -d '%')
        if [ $VOLUME -eq 0 ]; then
                VOLUME="mute?"
        elif [ $VOLUME -gt 50 ]; then
                VOLUME="loud?"
        else
                VOLUME="ok?"
        fi
        #echo -n "%{A5:pactl set-sink-volume 0 -1%:}%{A2:pavucontrol:}%{A4:pactl set-sink-volume 0 +1%:}$VOLUME%%%{A}%{A}%{A}"
        echo -n "%{A5:pactl set-sink-volume 0 -1%:}%{A:pavucontrol:}%{A4:pactl set-sink-volume 0 +1%:}${VOLUME}%{A}%{A}%{A}"
}


GetNetwork(){
        # Get the network
        NETWORK=$(nmcli dev status | grep  -E "wl.[0-9]*"  | head -n 1 | sed 's/    */:/g' | cut -d ":" -f 3 | sed -e 's/^connected/online /g' | sed -e 's/disconnected:--/offline /g')  #3-4 for ssid
        echo -n "%{A:/usr/bin/networkmanager_dmenu -l -1:}$NETWORK%{A}"
}

GetWindowName(){
        # Get the window name
        WINDOW_PID=$(xdotool getactivewindow getwindowpid)
        WINDOW_NAME=$(ps -p $WINDOW_PID -o comm=)

        #check if window name is empty
        if [ -z "$WINDOW_NAME" ]; then
                WINDOW_NAME="wallpaper???"
        fi

        echo -n "$WINDOW_NAME" 
}

GetMemoryUsage(){
        MEMORY=$(free -t | awk 'NR == 2 {printf("%.0f"), $3/$2*100}')

        if [ $MEMORY -gt 80 ]; then
                MEMORY="high usage"
        else
                MEMORY="normal usage"
        fi

        echo -n "%{A:/usr/bin/alacritty -e htop:}${MEMORY}%{A}"

}

GetCPUUsage(){
        CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' | sed 's/\..*//')
        if [ $CPU -gt 80 ]; then
                echo -n  "all hell break lose. this CPU is burning. "
        fi
}

LockScreen(){
        echo -n "%{A:betterlockscreen -l -u $HOME/Pictures/wallpaper.png:}Lock%{A}"
}

Shutdown(){
        echo -n "%{A:systemctl poweroff:}Shutdown%{A}"
}

while true; do
        echo "%{l} %{F#00ff00} $(GetWorkspace) %{F-}%{F#ffff00}| $(Clock) | $(GetNetwork)| $(GetWindowName) | $(Camera) | $(CurrentWorkspace) | $(GetMemoryUsage) | $(GetVolume) $(GetCPUUsage)| %{F-} %{l} %{r}%{F#ff0000}Error on line 32. Unexpected '%{F-}%{r}"
        sleep 0.5
done
