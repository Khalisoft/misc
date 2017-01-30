# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=data2cache
do.devicecheck=1
do.initd=0
do.modules=0
do.cleanup=1
device.name1=t03g
device.name2=n7100
device.name3=GT-N7100
device.name4=
device.name5=

# shell variables
block=/dev/block/platform/dw_mmc/by-name/BOOT;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk
chmod 644 $ramdisk/sbin/media_profiles.xml


## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.smdk4x12
target=fstab.smdk4x12
if grep -q 0p16 "${target}"; then # legacy fstab
  ORIG=0p16
  DEST=0p12
else # name based fstab
  ORIG=USERDATA
  DEST=CACHE
fi

# delete every entry matching ${DEST}
sed -i "/${DEST}/d" "${target}"

# change ${ORIG} mount to ${DEST}
sed -i "s/${ORIG}/${DEST}/g" "${target}"

# end ramdisk changes

write_boot;

## end install

