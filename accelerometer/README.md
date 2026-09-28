# Accelerometer support
This laptop has a single accelerometer that does *not* have a switch that indicates to the system when the screen is fully turned around.
As a result, the accelerometer can really only tell the orientation of the base, not the screen.
The way I got it "working" is rather roundabout, but it works well enough for those times where I actually do want to use it.

> [!NOTE]
> This only works in GNOME, and relies on the use of an extension that gets updated whenever the maintainer feels like it.
> Nothing against them, I just prefer *not* to rely on extensions for things because they're just side projects for people.

You will want this extension to get the rotation working: [shyzus/gnome-shell-extension-screenrotate](https://extensions.gnome.org/extension/5389/screen-rotate/)

You will want to configure it so that it disables the touchpad automatically for any position other than your standard "laptop mode."

> [!IMPORTANT]
> You can't disable the keyboard with this extension. It's a GNOME problem.
> There is a bug report on GNOME that was made 2 years ago, but like all GNOME bug reports it's been completely fucking ignored.

My advice is to just hold the computer in such a way where you're less likely to hit the keyboard.
If it's that big of an issue for you, now is a good time for you to learn how to code that. I would, however A) I don't really code either and B) it doesn't bug me.

# On-screen keyboard configuration
The on-screen keyboard (I'm calling the OSK from now on) is built into GNOME and doesn't require any additional packages.
But of course, it's not perfect.

To enable the OSK, go to Settings > Accessibility > Typing > Enable Keyboard

Once you have it working, you'll see a little accessibility icon in the top bar (it looks like a little man T-posing).
If that icon annoys you as much as it annoys me, get [this extension](https://extensions.gnome.org/extension/7912/hide-accessibility-menu/).
As much as I like to avoid extensions, this one is so simple that updates to GNOME shouldn't break it.

> [!TIP]
> When GNOME updates and inevitably breaks your extensions, you can modify the extensions to include your version of GNOME as being compatible.
> The file is located at `~/.local/share/gnome-shell/extensions/<extension-id>/metadata.json`
>
> Alternatively, you can just run `gsettings set org.gnome.shell disable-extension-version-validation true` to turn off version checking for all extensions.

So now that you have the OSK enabled, you'll find that any box you click on now pulls up the OSK. Which is very annoying, to say the least.
While GNOME's solution is for us to go fuck ourselves, my solution is to create a keyboard shortcut that toggles the OSK.

Go to Settings > Keyboard > View and Customize Shortcuts > Accessibility > Turn on-screen keyboard on or off

I use **Ctrl + Alt + Space** to do it. You can use that to toggle the keyboard on or off if the OSK popping up when clicking gets annoying.

If the OSK isn't popping up when you expect it to, **swipe up from the bottom of the screen towards the center**.
If it's still not showing after that, toggle the OSK using the keyboard shortcut you made and try again.

### Anyone looking to get this working on anything other than GNOME, best of luck to you.
If I switch DE's (and I probably will at some point), I'll update this page if I have more info.
