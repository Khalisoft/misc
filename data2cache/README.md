# data2cache

This is a simple AnyKernel2-based zip that i use for testing new roms or test
builds of my rom without touching the data partition, since is time-wasting
backuping and restoring the data partition (because for me is about 3GB) when i
need to test a rom i flash this zip on the new system image so in the next
boot it writes the new data to the cache partition (for me the cache partition
is very large, if i am not wrong 1.3GB so enough for a test) after that when i
am done i wipe the cache partition and reflash the boot image or the rom to
revert the changes and boot with the original data

Keep in mind that if you want to use this you should change the script to point
to the partitions of your device, also on my device there are two types of
fstab, one based on partition numbers (legacy and less portable but mostly
used) and a new fstab that use in my rom that is name-based so the script
recognizes the two types of fstab and changes it accordingly
