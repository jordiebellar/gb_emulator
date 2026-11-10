# ROM images

No ROM images are included. Nintendo's boot ROM and commercial games cannot be redistributed, so both have to come from hardware you own. This folder is where the build looks for them, and `.gitignore` keeps them out of git.

| File | What it is | Size |
|---|---|---|
| `boot/boot_rom.hex` | DMG boot ROM | 256 bytes |
| `game/cart_rom.hex` | cartridge image | 32 KB, ROM-only |

## Format

Plain text for `$readmemh`, one byte per line in hex, with no address markers.

```bash
xxd -p -c1 game.gb | head -n 32768 > roms/game/cart_rom.hex
xxd -p -c1 dmg_boot.bin > roms/boot/boot_rom.hex
```

A cartridge with a mapper (MBC) is not supported, so the image must be a plain 32 KB ROM such as Tetris.

Vivado finds the hex files by the absolute paths `scripts/vivado/create_gb.tcl` passes in, so run that script instead of adding the project by hand.
