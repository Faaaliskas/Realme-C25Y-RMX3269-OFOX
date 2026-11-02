#!/system/bin/sh
# Start the TEE TA supplier after storage proxies and /data are ready.

LOG=/tmp/start_tsupplicant.log
exec > "$LOG" 2>&1

i=0
while [ $i -lt 120 ]; do
    grep -q ' /data ' /proc/mounts && break
    sleep 1
    i=$((i + 1))
done

i=0
while [ $i -lt 60 ] && [ "$(getprop twrp.storage.ready)" != "1" ]; do
    sleep 1
    i=$((i + 1))
done

setprop vendor.sprd.tsupplicant.enabled 1
sleep 2
setprop twrp.tsupplicant.ready 1
