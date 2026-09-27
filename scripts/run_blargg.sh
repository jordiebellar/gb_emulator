#!/usr/bin/env bash
# =============================================================================
# Project      : GameBoy Emulator
# File         : run_blargg.sh
# Description  : Runs every Blargg test ROM under blargg/ through tb_blargg
#                and prints one result line per ROM, then a summary.
#                Each ROM runs in its own temp directory, because tb_blargg
#                loads rom.hex from the directory vvp runs in.
# Usage        : scripts/run_blargg.sh    (from anywhere in the repo)
# =============================================================================
set -u

ROOT=$(cd "$(dirname "$0")/.." && pwd)
SIM="$ROOT/sim/sim_blargg.vvp"
cd "$ROOT"

iverilog -o "$SIM" tb/cpu/tb_blargg.v rtl/cpu/cpu.v \
    rtl/cpu/interrupt_ctrl.v rtl/timer/timer.v || exit 1

pass=0
total=0
for rom in blargg/cpu_instrs/*.gb blargg/instr_timing/*.gb; do
    name=$(basename "$rom" .gb)
    work=$(mktemp -d)
    head -c 32768 "$rom" | xxd -p -c1 > "$work/rom.hex"

    start=$(date +%s)
    result=$(cd "$work" && vvp "$SIM" | grep -a -E "RESULT|WATCHDOG|stopping" | tail -1)
    secs=$(( $(date +%s) - start ))
    [ -z "$result" ] && result="no result line (check the tb)"

    printf "%-24s %-36s %5ds\n" "$name" "$result" "$secs"
    total=$((total + 1))
    case "$result" in *PASSED*) pass=$((pass + 1)) ;; esac
    rm -rf "$work"
done

echo
echo "$pass/$total passed"
[ "$pass" -eq "$total" ]