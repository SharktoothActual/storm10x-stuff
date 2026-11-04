# Accelerometer support
This laptop has a single accelerometer that does *not* have a switch that indicates to the system when the screen is fully turned around.
As a result, the accelerometer can really only tell the orientation of the base, not the screen.
The way I got it "working" is rather roundabout, but it works well enough for those times where I actually do want to use it.

Accelerometer support for this device **does not** require systemd. Hallelujah!

You will need pretty much just one package: `iio-sensor-proxy`.
Install it from your package manager if you don't already have it.
It should just be in your distro's repos, no AUR or COPR required.

> [!NOTE]
> **For Gentoo users**: It's in GURU as `gnome-extra/iio-sensor-proxy`.

## GNOME method
*Tested on Fedora 45*

Like all things in GNOME, you will need an extension to get any basic functionality.
I used this one to get rotation working: [shyzus/gnome-shell-extension-screenrotate](https://extensions.gnome.org/extension/5389/screen-rotate/)
Install it and configure it so that it disables the touchpad automatically for any position other than your standard "laptop mode."
If you can't install it because it's outdated or something, now you know why I dislike GNOME. Go complain to the maintainer, not me.

> [!IMPORTANT]
> You can't disable the keyboard with this extension. It's a reported problem in GNOME that's been ignored since 2024.

My advice is to either hold the computer in such a way where you're less likely to hit the keyboard or look into that GNOME bug and contribute to them.

### On-screen keyboard configuration
The on-screen keyboard (I'm calling the OSK from now on) is built into GNOME and doesn't require any additional packages.

To enable the OSK, go to Settings > Accessibility > Typing > Enable Keyboard

Once you have it working, you'll see a little accessibility icon in the top bar (it looks like a little man T-posing).
You can hide him with [this extension](https://extensions.gnome.org/extension/7912/hide-accessibility-menu/).
You'll also note that the keyboard pops up too frequently when browsing the web.
My solution was to create a keyboard shortcut that toggles the OSK so I can turn it off and on as needed.

To do this, go to Settings > Keyboard > View and Customize Shortcuts > Accessibility > Turn on-screen keyboard on or off

If the OSK isn't popping up when you expect it to, **swipe up from the bottom of the screen towards the center**.
If it's still not showing after that, toggle the OSK using the keyboard shortcut you made and try again.

## KDE method
*Tested on Gentoo*

Once you have `iio-sensor-proxy` emerged, go to System Settings > Display & Monitor > Orientation: Automatic (uncheck the box next to it).
That's it, now your screen rotates.
If you're using Plasma 6.7 and later, the virtual keyboard should be automatically set up and just work out of the box.

Otherwise, if they keyboard isn't appearing, you may need to install `plasma-keyboard` from your distro's repos. Should start working immediately.

# Conclusion
Yeah the most painless setup by far is KDE, use that. Other than that, that's all I got.
I don't have any plans on doing this for COSMIC because COSMIC sucks.
No plans for Xfce or Cinnamon, either, since they both lack any proper touch support.
If you use a tiling window manager... please take a shower.

As far as I'm concerned, this doc is now complete.
