# BIOS Splash images
These are the startup images displayed at boot taken directly from the BIOS itself.
The original images are 1920x1200, which you'll note *isn't actually native resolution*.
This screws with custom backgrounds and alignment, so I made slightly stretched copies for your convenience.

There are two versions:
| Version | Description |
| --- | --- |
| splash | Unmodified original version and a cropped version of the original |
| splash1280 | Slightly stretched version of the original, as original isn't native res |

For both cropped versions, I made those both. `splash.bmp` is the actual, original file.

For the 1280 version of the cropped image, used the same process I did for `splashCropped.bmp`, but instead of using `splash.bmp` I used `splash1280.bmp`.
Using this one allows the BIOS to switch to the framebuffer without the image randomly shrinking a bit.
