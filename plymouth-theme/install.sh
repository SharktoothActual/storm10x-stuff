#!/bin/bash

# Old-school permissions check
echo "If you get permissions errors, rerun this as root using sudo or doas."

# THIS WAS NOT WRITTEN BY ME
# I only made a few modifications
# I am leaving comments to explain things clearly

# Configurables
PLYMOUTH_DIR=/usr/share/plymouth/themes
PLYMOUTH_THEME=plymouth-modern-bgrt

# -----------------------------------------------
# THIS ENTIRE BLOCK INTENTIONALLY COMMENTED OUT
# The Storm10x doesn't expose bgrt, hence the reason I extracted the image from the BIOS in the first place
# -----------------------------------------------
# Sanity Checks
# if [[ ! -r /sys/firmware/acpi/bgrt/image ]]; then
	# echo "Sorry, I can't read /sys/firmware/acpi/bgrt/image"
	# echo "Your system is not suitable for this theme"
	# exit 1
# fi

## Comment: If you uncomment this for some reason, note that `convert` is deprecated by the command `magick`.
# command -v convert >/dev/null 2>&1 || { echo >&2 "I require convert (from imagemagick) but it's not installed.  Aborting."; exit 1; }
# command -v install >/dev/null 2>&1 || { echo >&2 "I require install (from coreutils) but it's not installed.  Aborting."; exit 1; }
# command -v awk >/dev/null 2>&1 || { echo >&2 "I require awk but it's not installed.  Aborting."; exit 1; }

# OK. Convert the image to PNG
# convert /sys/firmware/acpi/bgrt/image theme/bgrt.png

# Replace the placeholders with the image offsets
# < theme/bgrt.script.in awk \
	# -v BGRTLEFT=$(</sys/firmware/acpi/bgrt/xoffset) \
	# -v BGRTTOP=$(</sys/firmware/acpi/bgrt/yoffset) \
	# '{gsub (/\$BGRTLEFT\$/, BGRTLEFT);
	  # gsub (/\$BGRTTOP\$/, BGRTTOP);
	  # print}' > theme/bgrt.script
# ------------------------------------------------

# This part has been modified to statically align the image in the center, since we can't pull it from /sys
< theme/bgrt.script.in awk \
	-v BGRTLEFT=706 \
	-v BGRTTOP=548 \
	'{gsub (/\$BGRTLEFT\$/, BGRTLEFT);
	  gsub (/\$BGRTTOP\$/, BGRTTOP);
	  print}' > theme/bgrt.script

# Finally, install the theme

install -d ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}
install -m644 theme/plymouth-modern-bgrt.plymouth ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/
install -m644 theme/bgrt.{script,png} ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/
install -m644 theme/{box,bullet,progress_{bar,box}}.png ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/

# I've commented all this out becaue I honestly have no idea why it's here. Likely an old requirement.
# [ -d /lib/lsb/init-functions.d ] && install -m644 scripts/init-functions /lib/lsb/init-functions.d/999-bgrt
# [ -d /etc/initramfs-tools/hooks ] && install -m755 scripts/initramfs-hook /etc/initramfs-tools/hooks/bgrt-fonts

echo "Install complete."
echo "To use this theme, run as root:"
echo "	plymouth-set-default-theme -R ${PLYMOUTH_THEME}"
echo ""
echo "If you got an error about scripts, you may need to install plymouth-scripts (that's what Fedora calls it anyway)"
echo "If your package manager can't find plymouth-scripts, search for it and append your distro's name to the search"
