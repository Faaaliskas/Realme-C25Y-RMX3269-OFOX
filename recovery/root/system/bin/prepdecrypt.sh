#!/sbin/sh
# Wait for the trusty IPC node, then signal crypto readiness

LOG=/tmp/prepdecrypt.log
exec > "$LOG" 2>&1

bootmode=$(getprop ro.bootmode)
[ -z "$bootmode" ] && bootmode=$(getprop ro.boot.mode)
if [ -n "$bootmode" ] && [ "$bootmode" != "recovery" ]; then
    echo "Not in recovery mode ($bootmode), skipping prepdecrypt"
    exit 0
fi

i=0
while [ $i -lt 30 ]; do
    [ -e /dev/trusty-ipc-dev0 ] && break
    sleep 1
    i=$((i + 1))
done

if [ -e /dev/trusty-ipc-dev0 ]; then
    echo "trusty-ipc node ready after ${i}s"
else
    echo "no trusty node after ${i}s, signaling anyway"
fi

setprop crypto.ready 1
