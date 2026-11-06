#!/sbin/sh
# Mount prodnv, prepare /tmp/sprd_ss, then start secure storage proxies.
# Using /tmp/sprd_ss ensures /data is never held open or locked by storageproxyd,
# allowing /data to be formatted or wiped without ERROR 255.

LOG=/tmp/start_storage_proxies.log
exec > "$LOG" 2>&1

i=0
while [ $i -lt 30 ] && ! grep -q ' /mnt/vendor ' /proc/mounts; do
    mkdir -p /mnt/vendor
    mount -t ext4 /dev/block/by-name/prodnv /mnt/vendor 2>/dev/null
    sleep 1
    i=$((i + 1))
done
grep -q ' /mnt/vendor ' /proc/mounts && echo "prodnv mounted at /mnt/vendor" || echo "prodnv not mounted after ${i}s"

mkdir -p /tmp/sprd_ss
chown system:system /tmp/sprd_ss
chmod 0770 /tmp/sprd_ss

setprop ctl.start vendor.rpmbproxy
sleep 1
setprop ctl.start vendor.nsproxy

echo "storage proxies started"
setprop twrp.storage.ready 1
