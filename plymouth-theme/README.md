# Reworked version of 'plymouth-modern-bgrt' theme

Basically everything here down is the same thing as what is on the original repo, but I a few things where relevant.
All of my modifications are included as comments in the install script, **which you should already know to read before installing**.

I barely did anything other than take a really old theme and rework it for an oddball system.
I take no credit, @glics did all the work. If he has a tipbox or dono link, go find it and give him a tip for his work.
Don't ask to tip or donate to me, I don't deserve it nor want it.

---
A theme for plymouth which uses your system's UEFI logo (aka BGRT). 
Based on [plymouth-bgrt](https://github.com/darac/plymouth-bgrt).

You may want to tweak your kernel parameters to have a smooth transition from the bootloader to plymouth. \
On intel graphics, this is done by passing the `i915.fastboot=1` parameter. I would advise to add it to your bootloader
AFTER testing if it works, for example in GRUB by pressing `e` to edit the boot entry for one time only.

## Screenshot

Running on @glics's ThinkPad T440p, with a custom BIOS logo. Booting an encrypted root partition with a passphrase prompt.

![Screenshot](./preview.png)

## Installation

```sh
    sudo ./install.sh	# Runs a modified version of the original install script.
    sudo plymouth-set-default-theme -R plymouth-modern-bgrt
```

## GRUB Theme (which I have not reworked... yet... *possibly*)

You may also want to pair this with darac's [GRUB theme](https://github.com/darac/grub-bgrt).

If you use it, make sure that the boot_menu and the terminal don't cover your boot logo.
You can edit the theme.txt file if it does.

## License

All the files in this project are distributed under the [GNU General Public License](./LICENSE).

The reworked version is subject to this license and does not add its own. Original license included.

## Author of `plymouth-bgrt`

Paul Saunders
