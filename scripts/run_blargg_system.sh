#!/usr/bin/env bash
# =============================================================================
# Project      : GameBoy Emulator
# File         : run_blargg_system.sh
# Description  : Runs every Blargg test ROM under blargg/ on the full system
#                (gb_top through tb_gb_boot, Verilator) with the stub boot rom,
#                and prints one result line per ROM, then a summary. The
#                result comes from the serial monitor in tb_gb_boot, which
#                stops the run on "Passed" or "Failed".
# Usage        : scripts/run_blargg_system.sh    (from anywhere in the repo)
# =============================================================================
set -u

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"
mkdir -p frames

verilator --binary --timing -j 0 -Wno-fatal -Wno-lint -Wno-style -Wno-WIDTH \
    --top-module tb_gb_boot -o gbboot tb/tb_gb_boot.v rtl/gb_top.v \
    rtl/cpu/*.v rtl/timer/*.v rtl/clocking/*.v rtl/memory/*.v \
    rtl/cartridge/*.v rtl/joypad/*.v rtl/ppu/*.v > /dev/null || exit 1

pass=0
total=0
for rom in blargg/cpu_instrs/*.gb blargg/instr_timing/*.gb; do
    name=$(basename "$rom" .gb)
    work=$(mktemp -d)
    head -c 32768 "$rom" | xxd -p -c1 > "$work/cart.hex"

    start=$(date +%s)
    out=$(obj_dir/gbboot +stub +cart="$work/cart.hex" +frames=3000 +every=100000)
    secs=$(( $(date +%s) - start ))

    if   echo "$out" | grep -aq "Passed"; then result="PASSED"
    elif echo "$out" | grep -aq "Failed"; then result="FAILED"
    else result="TIMEOUT (no verdict in 3000 frames)"
    fi
    frame=$(echo "$out" | grep -ao "done at frame [0-9]*" | grep -o "[0-9]*$")

    printf "%-24s %-36s frame %-6s %5ds\n" "$name" "$result" "${frame:--}" "$secs"
    total=$((total + 1))
    [ "$result" = "PASSED" ] && pass=$((pass + 1))
    if [ "$result" != "PASSED" ]; then
        echo "$out" > "frames/$name.log"
        cp frames/frame_last.pgm "frames/$name.pgm" 2>/dev/null
    fi
    rm -rf "$work"
done

echo
echo "$pass/$total passed"
[ "$pass" -eq "$total" ]
