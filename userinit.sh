#!/system/bin/sh

echo "100000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "intelliactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "0" > /sys/module/mali/parameters/mali_debug_level
echo "0" > /sys/module/ump/parameters/ump_debug_level
echo "deadline" > /sys/block/mmcblk0/queue/scheduler
echo "0" > /sys/block/mmcblk0/queue/iostats
echo "noop" > /sys/block/mmcblk1/queue/scheduler
echo "0" > /sys/block/mmcblk1/queue/iostats
echo "1" > /sys/devices/virtual/sec/led/led_fade
echo "0" > /sys/devices/platform/samsung-battery/sdp_input_curr
echo "0" > /sys/devices/platform/samsung-battery/sdp_chrg_curr
echo "0" > /sys/devices/platform/samsung-battery/cdp_input_curr
echo "0" > /sys/devices/platform/samsung-battery/cdp_chrg_curr
echo "1" > /sys/devices/virtual/misc/mdnie/sequence_intercept
echo "1" > /sys/devices/virtual/misc/boeffla_sound/boeffla_sound
echo "1" > /sys/devices/virtual/misc/boeffla_sound/dac_direct
echo "1" > /sys/devices/virtual/misc/boeffla_sound/dac_oversampling
echo "1" > /sys/devices/virtual/misc/boeffla_sound/fll_tuning
echo "1" > /sys/devices/virtual/misc/boeffla_sound/speaker_tuning
echo "51 51" > /sys/devices/virtual/misc/boeffla_sound/headphone_volume
echo "51 51" > /sys/devices/virtual/misc/boeffla_sound/speaker_volume
echo "1" > /sys/devices/virtual/misc/boeffla_sound/privacy_mode
echo "0" > /sys/devices/virtual/camera/rear/camera_speaker_enabled
setprop qemu.hw.mainkeys 0

while [[ ! $(getprop sys.boot_completed) = 1 ]]; do sleep 1; done
/data/local/extmount.sh -b "125c3ac9-3704-454a-8aae-26d209691cc7" "sdcard1"
echo "35" > /sys/devices/virtual/timed_output/vibrator/pwm_value
