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

## Anyone looking to get this working on anything other than GNOME, best of luck to you.
If I switch DE's at some point (and I probably will at some point), I'll update this page if I have more info.
