#!/system/bin/sh
echo 0 > /flashlight/brightness
chmod 0666 /flashlight/brightness
last="0"
while true; do
    v=$(cat /flashlight/brightness 2>/dev/null)
    if [ "$v" != "$last" ]; then
        last="$v"
        if [ "$v" = "0" ]; then
            echo 3 > /sys/devices/virtual/misc/sprd_flash/test
        elif [ "$v" = "1" ]; then
            echo 12 > /sys/devices/virtual/misc/sprd_flash/test
        fi
    fi
    sleep 0.2
done
