#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}
################################################################################
if [ ! -f /data/property/persist.spectrum.profile ]; then
    setprop persist.spectrum.profile 0
fi
{

sleep 10

# Little Cluster
chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/*

# Big Cluster
chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/*

# I/O Scheduler
setprop sys.io.scheduler "maple"

sleep 20

}&
