#!/usr/bin/env python3
# =============================================================================
# project      : gameboy emulator
# file         : mkcard.py
# author       : aaron luebbert
# date         : 2026-11-16
# description  : checks a game boy rom and prepares it for the sd card
#                cartridge. it never touches a disk, it only reads the rom and
#                writes a .img copy next to it for a disk imaging tool.
#
#                  python mkcard.py game.gb
#                  python mkcard.py game.gb -o card.img
#
#                it reads the header, says whether the cartridge hardware can
#                run the game, and prints the number the sd_probe_top bring-up
#                design should show for the rom (switch setting and checksum).
#                the card holds the raw rom from sector 0, no file system. the
#                rom is padded to a whole number of 512 byte sectors, real roms
#                already are.
#
#                writing the card with win32 disk imager
#                  - pick the .img file, pick the card's drive letter, and read
#                    the letter twice. the tool overwrites that whole drive
#                  - press write. windows will then say the card is unreadable
#                    and offer to format it. say no, that is expected
#                  - verify only in the same tool re-reads the card and
#                    compares it with the file
# =============================================================================
import argparse
import os
import sys

LOGO_START = bytes([0xCE, 0xED, 0x66, 0x66])

# cart type byte at 0147, what it is and whether the cartridge hardware does it
TYPES = {
    0x00: ("rom only", True),
    0x01: ("mbc1", True), 0x02: ("mbc1 + ram", True), 0x03: ("mbc1 + ram + battery", True),
    0x05: ("mbc2", False), 0x06: ("mbc2 + battery", False),
    0x08: ("rom + ram", True), 0x09: ("rom + ram + battery", True),
    0x0B: ("mmm01", False), 0x0C: ("mmm01 + ram", False), 0x0D: ("mmm01 + ram + battery", False),
    0x0F: ("mbc3 + clock + battery", True), 0x10: ("mbc3 + clock + ram + battery", True),
    0x11: ("mbc3", True), 0x12: ("mbc3 + ram", True), 0x13: ("mbc3 + ram + battery", True),
    0x19: ("mbc5", True), 0x1A: ("mbc5 + ram", True), 0x1B: ("mbc5 + ram + battery", True),
    0x1C: ("mbc5 + rumble", True), 0x1D: ("mbc5 + rumble + ram", True),
    0x1E: ("mbc5 + rumble + ram + battery", True),
    0x20: ("mbc6", False), 0x22: ("mbc7 + sensor", False),
    0xFC: ("pocket camera", False), 0xFD: ("bandai tama5", False),
    0xFE: ("huc3", False), 0xFF: ("huc1 + ram + battery", False),
}

RAM_KB = {0: 0, 1: 2, 2: 8, 3: 32, 4: 128, 5: 64}


def main():
    ap = argparse.ArgumentParser(description="check a rom and prepare it for the sd card cartridge")
    ap.add_argument("rom", help="the .gb file")
    ap.add_argument("-o", "--out", help="image file to write, default is the rom name with .img")
    ap.add_argument("--no-image", action="store_true", help="only check the rom, write nothing")
    a = ap.parse_args()

    with open(a.rom, "rb") as f:
        rom = f.read()

    if len(rom) < 0x150:
        sys.exit("error: file is too small to be a game boy rom")

    problems = []
    notes = []

    if rom[0x104:0x108] != LOGO_START:
        problems.append("the nintendo logo is missing at 0104, this does not look like a game boy rom")

    chk = 0
    for b in rom[0x134:0x14D]:
        chk = (chk - b - 1) & 0xFF
    if chk != rom[0x14D]:
        problems.append("header checksum is wrong (file is %02X, header says %02X)" % (chk, rom[0x14D]))

    title = bytes(b for b in rom[0x134:0x144] if 0x20 <= b < 0x7F).decode("ascii", "replace")
    ctype = rom[0x147]
    name, ok = TYPES.get(ctype, ("unknown type %02X" % ctype, False))
    romsz = rom[0x148]
    hdr_bytes = 32768 << romsz if romsz <= 8 else 0
    ramsz = RAM_KB.get(rom[0x149], 0)

    print("title        : %s" % title)
    print("cart type    : %02X  %s" % (ctype, name))
    print("rom size     : %d KB in the header, %d KB in the file" % (hdr_bytes // 1024, len(rom) // 1024))
    print("cart ram     : %d KB" % ramsz)

    if not ok:
        problems.append("the cartridge hardware does not support this cart type (%s)" % name)
    if rom[0x143] == 0xC0:
        problems.append("this is a game boy color only game, this is a dmg system")
    elif rom[0x143] == 0x80:
        notes.append("color enhanced, it will run in its normal game boy mode")
    if hdr_bytes and hdr_bytes != len(rom):
        problems.append("the file is %d bytes but the header says %d" % (len(rom), hdr_bytes))
    if len(rom) > 8 * 1024 * 1024:
        problems.append("the cartridge hardware handles roms up to 8 MB")
    if ramsz > 32:
        notes.append("the cartridge hardware has 32 KB of cart ram, this game wants %d KB" % ramsz)
    if name.endswith("battery") or "battery" in name:
        notes.append("saves are kept in fpga ram only, they are lost when power goes off")

    sectors = (len(rom) + 511) // 512
    padded = rom + bytes(sectors * 512 - len(rom))

    # what sd_probe_top shows after btnL with sw15-sw8 = n, it reads (n + 1) * 8 sectors
    n_max = min(255, sectors // 8 - 1)
    if n_max < 0:
        n_max = 0
    nsec = (n_max + 1) * 8
    total = sum(padded[: nsec * 512]) & 0xFFFF
    print("")
    print("sd_probe_top check")
    print("  sector 0, sw7-sw0 = 82   shows  %02X%02X  (the logo start)" % (padded[0x104], padded[0x105]))
    print("  sector 0, sw7-sw0 = 9A   shows  %02X%02X  (the title start)" % (padded[0x134], padded[0x135]))
    print("  sector 0, sw7-sw0 = A3   shows  %02X%02X  (sgb flag, cart type)" % (padded[0x146], padded[0x147]))
    print("  btnL with sw15-sw8 = %02X reads %d sectors and shows  %04X" % (n_max, nsec, total))

    if notes:
        print("")
        for n in notes:
            print("note: " + n)
    if problems:
        print("")
        for p in problems:
            print("problem: " + p)

    if not a.no_image:
        out = a.out or (os.path.splitext(a.rom)[0] + ".img")
        if os.path.abspath(out) == os.path.abspath(a.rom):
            sys.exit("error: the output would overwrite the rom")
        with open(out, "wb") as f:
            f.write(padded)
        print("")
        print("wrote %s (%d sectors)" % (out, sectors))

    sys.exit(1 if problems else 0)


if __name__ == "__main__":
    main()
