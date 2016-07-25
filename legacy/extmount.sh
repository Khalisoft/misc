#!/system/bin/sh
#
# Mount external devices to internal sdcard
#
# Get rid of android permissions on external sdcard/devices and link them on
# internal sdcard so we can read/write on them, this can make some apps work
# again, like Syncthing (that cannot understand android's storage access
# framework uri/paths)
#
# We will use the "mount --bind" since the sdcard doesn't understand the links
# created with "ln -s" because the fat filesystem doesn't support it (sdcard
# creates a virtual fat filesystem on the internal sdcard)
#
# Usage:
# - extmount.sh -b [device] [dest]
# - extmount.sh -u [dest]

plog() { echo "INFO: $@"; }
perr() { echo "ERROR: $@"; exit 1; }

INTPATH="/data/media/0" # real internal sdcard path
DEVROOT="$INTPATH/mnt" # the folder where we will mount the devices
EXTPATH="/mnt/media_rw" # the real mountpoints of external devices (sdcard, otg, ...)

case "$1" in
	-b) # bind
		DEVICE="$EXTPATH/$2" # device mountpoint path
		DEST="$DEVROOT/$3" # destination

		# initialize
		mkdir -p "$DEVROOT" && \
			plog "$DEVROOT created" || \
			perr "failed to create $DEVROOT"
			

		# check if $DEST exists and if is empty
		if [[ -d "$DEST" ]]; then
			if mountpoint -q -- "$DEST"; then
				perr "$DEST is already mounted"
			else
				rmdir "$DEST" 2> /dev/null && \
					plog "removed $DEST" || \
					perr "$DEST not empty"
			fi
		fi

		mkdir -p "$DEST" && \
			plog "$DEST created" || \
			perr "failed to create $DEST"

		mount --bind "$DEVICE" "$DEST" && \
			plog "$DEVICE mounted to $DEST" || \
			perr "failed to mount $DEVICE to $DEST"

		# avoid duplicates in apps
		touch "$DEVROOT"/.nomedia && \
			plog "created .nomedia in $DEVROOT" || \
			perr "failed to create .nomedia in $DEVROOT"

		# set permissions for android services, daemons, ...
		chown -R "media_rw:media_rw" "$DEVROOT" && \
		find "$DEVROOT" -type d -exec chmod 775 {} \; && \
		find "$DEVROOT" -type f -exec chmod 664 {} \; && \
			plog "permissions setted on $DEVROOT" || \
			perr "failed to set permissions on $DEVROOT"

		# scan sdcard to find new files
		#am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///sdcard
	;;
	-u) # unbind
		DEST="$DEVROOT/$2" # destination

		# check if $DEST exists and if is empty
		if [[ -d "$DEST" ]]; then
			if mountpoint -q -- "$DEST"; then
				umount "$DEST" && \
					plog "$DEST unmounted" || \
					perr "failed to unmount $DEST"
			else
				plog "$DEST already unmounted"
			fi
			rmdir "$DEST" 2> /dev/null && \
				plog "$DEST removed" || \
				perr "$DEST not empty"
		else
			perr "$DEST doesn't exists"
		fi
	;;
esac

plog "done" && exit
