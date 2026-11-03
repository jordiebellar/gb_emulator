# Game Boy (DMG) on an FPGA

A Game Boy (DMG) written in Verilog that runs on a Digilent Basys 3 (Artix-7 XC7A35T). It boots the original boot ROM, plays a cartridge image from block RAM, draws the picture over VGA and takes input from a USB keyboard. The first game we ran on it was Tetris.

Built for **ECE 4333 (Capstone)** at Texas Tech University by Aaron Luebbert and Jordie Bellar.

| Owner | Blocks |
|---|---|
| Aaron Luebbert | bus and memory map, cartridge, WRAM and HRAM, PPU, OAM DMA, video and VGA, joypad, clocking, FPGA integration |
| Jordie Bellar | SM83 CPU, interrupt controller, timer, debug UART and bring-up |

## Status

- Boots the DMG boot ROM, then runs a 32 KB ROM-only cartridge (Tetris) on the Basys 3.
- 160 x 144 picture, 4 shades, scaled 3x to 480 x 432 and centered in a 640 x 480 @ ~59.5 Hz VGA signal.
- One 100 MHz clock drives everything. The Game Boy runs on clock enables, so there are no derived clocks.
- Post-implementation: about 15% of the LUTs and 30% of the block RAM, timing met at 100 MHz.

Not built: audio (APU), serial link, cartridge mappers (MBC) and cartridge RAM, and Game Boy Color. Reads from the missing I/O registers return `FF` and writes are ignored.

## Controls

Plug a USB keyboard into the Basys 3 USB port (the board's USB host chip presents it to the FPGA as PS/2). The layout is the default used by mGBA, RetroArch and most other emulators.

| Game Boy | Keyboard | Basys 3 board |
|---|---|---|
| D-pad | Arrow keys | `btnU` `btnD` `btnL` `btnR` |
| A | `X` | `sw0` |
| B | `Z` | `sw1` |
| Select | `Backspace` or either `Shift` | `sw2` |
| Start | `Enter` | `sw3` |
| Reset | - | `btnC` (replays the boot ROM) |

The keyboard and the board buttons work at the same time. The 16 LEDs show the CPU address bus, so a running machine flickers and a stuck CPU holds a pattern.

## Architecture

```
                         100 MHz clk
                              |
                          clk_div --> ce_gb (4.194304 MHz, one T-cycle)
                              |       ce_m  (every 4th ce_gb, one M-cycle)
                              |       ce_vga (25 MHz)
                              v
   +-----+   bus   +------------+----+---------+-----------------------+
   | cpu |<------->| memory_map |    |  cartridge  (boot ROM + 32 KB ROM)|
   +--+--+         | (decode +  |    |  wram, hram                       |
      |            |  read mux) |    |  ppu (vram, oam, registers)       |
      |            +------------+    |  oam_dma                          |
      |                              |  timer, joypad                    |
      +-- interrupt_ctrl <-----------+                                   |
                                     +-----------------------------------+
                                            |
                                  ppu --> video --> VGA
```

Every peripheral commits its own write on `sel && we && ce_m`, and the CPU samples reads on `ce_m`. `docs/interface_contract.pdf` is the contract the blocks were built against, and the header comment of each module says how it applies it.

The top level for the board is `rtl/fpga/gb_fpga_top.v`. It only adds the board pins, a power-on reset and input synchronizers around `rtl/gb_top.v`, the same `gb_top` the testbenches run.

## Repository layout

```
rtl/
  gb_top.v          the machine
  cpu/              SM83 core, interrupt controller
  timer/            DIV, TIMA, TMA, TAC
  clocking/         clock-enable generator
  memory/           address decode, WRAM, HRAM
  cartridge/        boot ROM overlay and 32 KB cartridge
  ppu/              mode timing, registers, VRAM, OAM, OAM scan,
                    pixel fetcher, OAM DMA, framebuffer, palette,
                    VGA timing and scaler
  joypad/           P1 register, PS/2 keyboard receiver
  fpga/             gb_fpga_top (the real board top), plus the
                    bring-up tops used to check the PPU and VGA path
  debug/            UART and the Blargg bring-up top
  bus/              bus_master.v, a simulation-only bus model
tb/                 one self-checking testbench per module, plus
                    full-system benches
constraints/        basys3_gb.xdc for the full machine, the other
                    .xdc files belong to the bring-up tops
scripts/            Vivado project scripts and the Blargg runners
docs/               interface contract and CPU interface diagram
roms/               where you put your own ROM images (not tracked)
```

## Build for the Basys 3

You need Vivado and your own ROM images. No ROMs are included, see [`roms/README.md`](roms/README.md) for the file names and format.

1. Put `boot_rom.hex` in `roms/boot/` and `cart_rom.hex` in `roms/game/`.
2. In the Vivado Tcl console run `source <repo>/scripts/vivado/create_gb.tcl`. It creates the project outside the repo and adds the sources, the constraints and the ROM paths.
3. Run Synthesis, Implementation and Generate Bitstream, then program the board from Hardware Manager.
4. Connect a VGA monitor and a USB keyboard. Press `btnC` to restart.

`GB_VIVADO_DIR` changes where the project is created.

## Simulation

Each module has a self-checking testbench in `tb/` that prints `ALL ... CHECKS PASSED` or lists the failures. With Icarus Verilog, for example:

```bash
mkdir -p sim
iverilog -g2005 -o sim/tb_ps2_keys tb/joypad/tb_ps2_keys.v rtl/joypad/ps2_keys.v
vvp sim/tb_ps2_keys
```

The PPU and bus testbenches use `rtl/bus/bus_master.v` and the PPU files they exercise, so add those to the command line. `sim/` holds build output and is not tracked.

For the whole machine, `tb/tb_gb_boot.v` runs `gb_top` under Verilator and dumps frames, and `scripts/run_blargg_system.sh` runs the Blargg `cpu_instrs` and `instr_timing` ROMs through it. `scripts/run_blargg.sh` runs the same ROMs on the CPU, timer and interrupt controller alone. Both expect the Blargg ROMs in a `blargg/` folder at the repository root.

## Documents

- `docs/interface_contract.pdf` - the bus, clock-enable and interrupt contract between the blocks.
- `docs/cpu_interface.drawio` - CPU interface diagram.

## Legal

This project contains no Nintendo code or game data. The boot ROM and any cartridge image must be dumped from hardware you own. Game Boy and Tetris are trademarks of their owners and are used here only to describe compatibility.
