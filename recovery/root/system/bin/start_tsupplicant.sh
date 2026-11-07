#!/sbin/sh
# Start TEE supplicant after storage proxies are ready
# On Realme C25Y (UMS512), Keymaster and Gatekeeper TAs are in TOS (trustos partition)

LOG=/tmp/start_tsupplicant.log
exec > "$LOG" 2>&1

i=0
while [ $i -lt 30 ] && [ "$(getprop twrp.storage.ready)" != "1" ]; do
    sleep 1
    i=$((i + 1))
done

setprop vendor.sprd.tsupplicant.enabled 1
sleep 1
setprop twrp.tsupplicant.ready 1
echo "tsupplicant started and gatekeeper signaled"
