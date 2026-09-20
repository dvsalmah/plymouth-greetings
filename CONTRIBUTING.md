# Contributing

Wanna tweak something or swap the animations? Here's the TL;DR on how everything works under the hood so you don't have to dig through the code.

## Stuff in this repo

- `assets/hello/` - Boot animation frames (`hello-1.png` .. `hello-300.png`)
- `assets/goodbye/` - Shutdown animation frames (`goodbye-1.png` .. `goodbye-300.png`)
- `theme.script` - The actual Plymouth logic (scaling, loading, looping)
- `dev.sh` - Quick test script so you don't have to reboot your PC
- `install.sh` - Installs the theme and rebuilds initramfs

## How theme.script actually works

### Boot vs Shutdown
Plymouth simply checks `Plymouth.GetMode()`. If it's `"boot"`, it grabs `hello-` frames. Anything else (shutdown, reboot), it grabs `goodbye-`.

### The Looping
- It just counts `1 -> 2 -> ... -> 300`.
- Once it hits 301, it wraps right back to 1 (`301 - 300 = 1`).
- Plymouth ticks at 50 FPS. Moving 1 frame per tick means 300 frames = a neat 6-second loop.
- It only updates the screen when the frame integer actually changes, saving unnecessary redraws.

### Scaling & Centering
- `BOX_SCALE = 0.30` means the animation takes up 30% of your screen size.
- It calculates the aspect ratio on the fly, so your frames won't get stretched or distorted on ultrawide or weird aspect ratio monitors.


## Testing (don't reboot your PC)

You can preview animations directly in your current session:

```bash
# Test boot animation (6 secs)
./dev.sh boot 6

# Test shutdown animation (6 secs)
./dev.sh shutdown 6
```

## Dropping in your own frames

If you're swapping the animations with your own:
- **Naming:** Keep them numbered sequentially (`hello-1.png` .. `hello-300.png` or `goodbye-1.png` .. `goodbye-300.png`).
- **Resolution:** 16:9 ratio. Around `640x360` is the sweet spot (it's rendered at 30% scale anyway, so 1080p source is just a waste of space).
- **Compression:** Quantize PNGs to a 256-color palette so your `/boot` partition and initramfs stay nice and tiny (<10 MB).
- **Framerate:** 300 frames at 50 FPS gives you a clean 6-second loop.
