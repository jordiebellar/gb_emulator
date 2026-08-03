# GameBoy Emulator (Hardware Implementation)

An in-progress hardware implementation of the original GameBoy's SM83 CPU core in Verilog, built as my Capstone project for ECE. The goal is a synthesizable core capable of fetching, decoding, and executing SM83 instructions against a mapped memory space, eventually extending toward a full GameBoy-on-FPGA system.

**Status: work in progress.** The CPU core currently implements a working fetch/decode/execute pipeline with a meaningful subset of the SM83 instruction set; large parts of the system (PPU, timers, interrupts, I/O registers, cartridge MBC support) are not yet implemented. See [Scope](#scope) below for exactly what's covered today.

## Architecture

```
gb_top
├── cpu           # SM83 CPU core: fetch/decode/execute state machine
└── memory_map    # Bus-connected ROM + WRAM
```

`gb_top.v` wires the CPU and memory map together over a simple shared bus (16-bit address, 8-bit data in/out, single write-enable line). The CPU drives `addr`/`data_out`/`we`; `memory_map` drives `data_out` (read data) back to the CPU based on the requested address.

**Memory map (current):**

| Range | Size | Contents |
|---|---|---|
| `0x0000`–`0x7FFF` | 32 KB | ROM (loaded from `rom.hex` via `$readmemh`) |
| `0xC000`–`0xDFFF` | 8 KB | Work RAM |
| everything else | — | reads as `0xFF` (unmapped) |

This mirrors the real GameBoy's ROM and WRAM regions but doesn't yet implement VRAM, OAM, echo RAM, I/O registers, or high RAM.

## CPU core

The CPU (`rtl/cpu/cpu.v`) is a state-machine implementation (`FETCH` → `DECODE` → `EXECUTE`, with dedicated `FETCH_IMM`, `STACK_PUSH`, and `STACK_POP` states for multi-cycle operations) rather than a single-cycle design, matching how the real SM83 handles variable-length instructions and memory access timing.

**Registers implemented:** `A`, `F` (flags: Z/N/H/C), `B`, `C`, `D`, `E`, `H`, `L`, `PC`, `SP`, and an internal instruction register (`IR`).

**Instructions implemented so far:**
- `LD r, r'` and `LD r, n` (register-to-register and immediate loads, including `(HL)` as a memory operand)
- `INC r`, `DEC r` (register forms; `(HL)` memory form is stubbed, not yet wired)
- `ADD A, r`, `SUB A, r`, `AND A, r`, `XOR A, r`, `OR A, r`, `CP A, r` (with correct Z/N/H/C flag behavior per operation)
- `JP nn`, `JR n`, `JR cc, n` (all four condition codes: NZ, Z, NC, C)
- `CALL nn`, `RET` (including stack push/pop of the 16-bit return address)

**Not yet implemented:** 16-bit register-pair loads/arithmetic, bit operations (`CB`-prefixed instruction set), rotates/shifts, `PUSH`/`POP` for general register pairs, interrupts (`RETI`, `EI`/`DI`), halt/stop, and the `(HL)` memory operand for `INC`/`DEC`.

## Verification

`tb/cpu/tb_cpu.v` is a minimal testbench: it backs the CPU with a full 64 KB behavioral RAM array, hand-loads a few bytes (a `CALL` immediately followed by a `JP` back to itself, then a `RET`) to exercise the stack push/pop and jump paths, and dumps waveforms for inspection. It's a smoke test at this stage, not a coverage suite — no golden-model comparison or per-instruction test cases yet.

To run it with Icarus Verilog:

```bash
iverilog -o sim/tb_cpu tb/cpu/tb_cpu.v rtl/cpu/cpu.v
vvp sim/tb_cpu
gtkwave sim/waves/tb_cpu.vcd
```

(`sim/` is git-ignored — waveform output and build artifacts stay local.)

## Repo structure

```
.
├── docs/
│   └── cpu_interface.drawio   # CPU/bus interface diagram
├── rtl/
│   ├── bus/
│   │   └── memory_map.v       # ROM + WRAM address decoding
│   ├── cpu/
│   │   └── cpu.v              # SM83 CPU core
│   └── gb_top.v               # Top-level integration
└── tb/
    └── cpu/
        └── tb_cpu.v           # CPU testbench
```

## Roadmap

- [ ] Finish the remaining SM83 instruction set (16-bit ops, CB-prefixed bit ops, rotates/shifts, interrupts)
- [ ] `(HL)` memory operand support for INC/DEC
- [ ] PPU (background/window/sprite rendering)
- [ ] Timer and interrupt controller
- [ ] I/O register space and joypad input
- [ ] Cartridge MBC support (beyond flat 32 KB ROM)
- [ ] Per-instruction testbenches with expected-state checks (moving beyond the current smoke test)
- [ ] FPGA target integration (part of the broader capstone handheld build)
