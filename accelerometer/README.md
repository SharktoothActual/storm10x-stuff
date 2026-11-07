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

## Screen rotation (GNOME method)
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

## Screen rotation (KDE method)
*Tested on Gentoo*

Once you have `iio-sensor-proxy` emerged, go to System Settings > Display & Monitor > Orientation: Automatic (uncheck the box next to it).
That's it, now your screen rotates.
If you're using Plasma 6.7 and later, the virtual keyboard should be automatically set up and just work out of the box.

Otherwise, if they keyboard isn't appearing, you may need to install `plasma-keyboard` from your distro's repos. Should start working immediately.

# Disabling the mouse and keyboard when in tablet mode (All desktops)
I wrote a script that monitors the output of `iio-sensor-proxy` and disconnects the mouse and keyboard when not oriented like a laptop.
It's universal, so if you got the other stuff running then this will work for you, too.
**It's a daemon, so you'll need to write your own systemd unit file**.
If you're like me and using OpenRC, I've written a unit file for you. Provided below.

To get started, create the file `/usr/local/bin/auto-rotate-inputs` with the following contents:
```bash
#!/bin/bash

toggle_inputs() {
  # Target these devices, which you can get by running `libinput list-devices` or `xinput list`
  local touchpad="HTIX5288|093A:0255"
  local keyboard="AT Translated" # Specifying the device ID is a good way to detach the touchscreen, use this instead
  local action="$1"

  for input_dir in /sys/class/input/input*; do
          if [ -f "$input_dir/name" ]; then
                  dev_name=$(cat "$input_dir/name" 2>/dev/null)

                  if echo "$dev_name" | grep -qiE "$touchpad|$keyboard"; then
                          if ! echo "$dev_name" | grep -qi "touchscreen"; then
                                  if [ -f "$input_dir/inhibited" ]; then
                                          echo "$action" > "$input_dir/inhibited" 2>/dev/null || true
                                  fi
                        fi
                  fi
          fi
  done
}

# Listen to iio-sensor-proxy and if the orientation changes, toggle inputs accordingly
stdbuf -oL monitor-sensor 2>/dev/null | grep --line-buffered "Accelerometer orientation changed:" | while read -r line; do
        # Suspend at the login screen, as this acts very glitchy there
        if loginctl show-session $(loginctl | awk '/active/ {print $1}') 2>/dev/null | grep -q "LockedHint=yes"; then
                continue
        fi

  if echo "$line" | grep -qiE "normal"; then
    toggle_inputs 0
  else
    toggle_inputs 1
  fi
done
````
The notes are there so you can follow along with the script if you're not much on coding (that's me).
**Make it executable** with `sudo chmod +x /usr/local/bin/auto-rotate-inputs`.

### THIS NEXT FILE IS FOR OPENRC. THIS WILL NOT WORK FOR YOU IF YOU'RE USING SYSTEMD.
If you don't know what systemd is, **copy and paste the contents of the below file and ask an AI to make it work with your distro**.

For the elite systemd-free linuxchads, create `/etc/init.d/auto-rotate-inputs` and drop the following into it:
```bash
#!/sbin/openrc-run

name="Auto Rotate Inputs Daemon"
description="Inhibits keyboard and touchpad for 2-in-1 devices"
command="/usr/local/bin/auto-rotate-inputs"
command_background="yes"
pidfile="/run/auto-rotate-inputs.pid"

depend() {
        need dbus
        after dbus
}
```
**Make it executable** with `sudo chmod +x /etc/init.d/auto-rotate-inputs`.
Next, add it to default with `sudo rc-update add auto-rotate-inputs default` and start it with `sudo rc-service auto-rotate-inputs start`.

> [!NOTE]
> I will add a systemd unit file in here someday, but until then you can always just copy the contents of the OpenRC init file and ask your favorite AI to convert it into a systemd unit for you
> I would do this myself but I'm not willing to put code I can't test out into the wild.
> The real solution is to not use systemd by get "gitting gud".

# Conclusion
Yeah the most painless setup by far is KDE, use that. Other than that, that's all I got.
I don't have any plans on doing this for COSMIC because COSMIC sucks.
No plans for Xfce or Cinnamon, either, since they both lack any proper touch support.
If you use a tiling window manager... please take a shower.

As far as I'm concerned, this doc is now complete.
