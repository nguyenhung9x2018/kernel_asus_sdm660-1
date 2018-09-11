# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { 
kernel.string=AnyKernel2 by osm0sis @ xda-developers
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
initd=/system/etc/init.d/;
patch=/tmp/anykernel/patch;
postboot = /vendor/bin/init.qcom.post_boot.sh

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;

#Rename init.post-boot script
mv $postboot $postboot.bak

## AnyKernel install
dump_boot;

# begin ramdisk changes

#Remove old kernel stuffs from ramdisk
ui_print "cleaning up..."
 rm -rf $ramdisk/init.PbH.rc
 rm -rf $ramdisk/init.PbH.sh

backup_file init.rc;
replace_string init.rc "cpuctl cpu,timer_slack" "mount cgroup none /dev/cpuctl cpu" "mount cgroup none /dev/cpuctl cpu,timer_slack";
append_file init.rc "run-parts" init;

insert_line init.rc "init.darkonah.rc" after "import /init.usb.rc" "import /init.darkonah.rc";
insert_line init.rc "init.spectrum.rc" after "import /init.darkonah.rc" "import /init.spectrum.rc";

# end ramdisk changes

write_boot;

## end install

