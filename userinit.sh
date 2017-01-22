#!/system/bin/sh

# misc settings
printf 1 > /sys/devices/virtual/sec/led/led_fade
printf 0 > /sys/devices/platform/samsung-battery/sdp_input_curr
printf 0 > /sys/devices/platform/samsung-battery/sdp_chrg_curr
printf 0 > /sys/devices/platform/samsung-battery/cdp_input_curr
printf 0 > /sys/devices/platform/samsung-battery/cdp_chrg_curr
printf 1 > /sys/devices/virtual/misc/mdnie/sequence_intercept
printf 1 > /sys/devices/virtual/misc/boeffla_sound/boeffla_sound
printf 1 > /sys/devices/virtual/misc/boeffla_sound/dac_direct
printf 1 > /sys/devices/virtual/misc/boeffla_sound/dac_oversampling
printf 1 > /sys/devices/virtual/misc/boeffla_sound/fll_tuning
printf 1 > /sys/devices/virtual/misc/boeffla_sound/speaker_tuning
printf 1 > /sys/devices/virtual/misc/boeffla_sound/privacy_mode
printf 0 > /sys/devices/virtual/camera/rear/camera_speaker_enabled

# disable internet while waiting for afwall (this block can be disabled if first parameter is passed)
if [ -z "${1}" ]; then
  for iptables in iptables ip6tables; do
    for i in INPUT OUTPUT FORWARD; do
      "${iptables}" -wP "${i}" DROP
    done
  done
fi

# userinit is executed after data is mounted (this is default behavior on
# cyanogenmod and on my aosp rom) so we don't need to wait
mnt=/data/media/0/mnt
mount -t ext4 -o noatime,nobarrier,commit=100,data=writeback /dev/block/mmcblk1p1 "${mnt}"/sdcard1
find "${mnt}" -type f -exec chmod 664 {} \;
find "${mnt}" -type d -exec chmod 775 {} \;
chown -R "media_rw:media_rw" "${mnt}"
unset mnt

while [ ! "$(getprop sys.boot_completed)" = 1 ]; do
  sleep 2
done

printf 35 > /sys/devices/virtual/timed_output/vibrator/pwm_value
