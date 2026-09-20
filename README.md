# Plymouth Greetings 🎨
A dynamic Plymouth boot splash theme featuring a welcoming "Hello" animation during boot and a "Goodbye" animation during shutdown.

![Plymouth](https://img.shields.io/badge/Plymouth-Theme-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Linux](https://img.shields.io/badge/OS-Linux-orange)

## Preview

|                          Boot ("Hello")                           |                           Shutdown ("Goodbye")                            |
| :---------------------------------------------------------------: | :-----------------------------------------------------------------------: |
| <img src="assets/hello/hello.png" alt="Boot Preview" width="380"> | <img src="assets/goodbye/goodbye.png" alt="Shutdown Preview" width="380"> |

## Prerequisites

Make sure you have these installed:
- `plymouth`
- An initramfs tool (`mkinitcpio`, `dracut`, or `initramfs-tools`)

## Installation

Just clone the repo and run the install script:

```bash
# Clone the repository
git clone https://github.com/dvsalmah/plymouth-greetings.git
cd plymouth-greetings

# Run the installer
chmod +x install.sh
./install.sh
```

The script will copy the files to `/usr/share/plymouth/themes/plymouth-greetings`, set it as your default theme, and rebuild your `initramfs` automatically.

## Configuration & Tweaks

You can tweak the animation size and speed inside [theme.script](theme.script):

```javascript
// Total frames
HELLO_FRAMES = 300;
GOODBYE_FRAMES = 300;

// Screen scale (0.30 = 30% of screen size)
BOX_SCALE = 0.30;

// Animation speed (1.0 = 1 frame per refresh at 50 FPS)
HELLO_STEP = 1.0;
GOODBYE_STEP = 1.0;
```

### Test without rebooting

You can quickly preview the animations locally with `dev.sh`:

```bash
# Preview boot animation (6 seconds)
./dev.sh boot 6

# Preview shutdown animation (6 seconds)
./dev.sh shutdown 6
```

### Apply your changes

After editing `theme.script`, simply run `./install.sh` again, or rebuild your initramfs manually:
- **Fedora / RHEL / openSUSE:** `sudo dracut -f`
- **Arch Linux:** `sudo mkinitcpio -P`
- **Debian / Ubuntu:** `sudo update-initramfs -u`

## Uninstallation

To remove the theme and go back to your default one (e.g. `bgrt`):

```bash
# Set back to default theme
sudo plymouth-set-default-theme -R bgrt

# Remove theme folder
sudo rm -rf /usr/share/plymouth/themes/plymouth-greetings
```

## License

[MIT License](https://github.com/dvsalmah/plymouth-greetings/blob/main/LICENSE).
Feel free to use, modify, and share!
