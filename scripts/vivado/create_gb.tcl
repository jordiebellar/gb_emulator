# =============================================================================
# Project      : GameBoy Emulator
# File         : create_gb.tcl
# Description  : creates the vivado project for gb_fpga_top, the full game boy
#                on the basys 3. sources are added by reference, not copied.
#                the rom hex files are passed to gb_fpga_top as absolute paths
#                so $readmemh can't silently miss them during synthesis.
#                run from the vivado tcl console:  source <repo>/scripts/vivado/create_gb.tcl
#                GB_VIVADO_DIR overrides where the project is made.
# =============================================================================

set repo [file normalize [file join [file dirname [info script]] .. ..]]

if {[info exists ::env(GB_VIVADO_DIR)]} {
    set proj_dir [file normalize $::env(GB_VIVADO_DIR)]
} else {
    set proj_dir "C:/vivado_work/gb_full"
}

create_project -force gb_full $proj_dir -part xc7a35ticpg236-1L
set_property target_language Verilog [current_project]

add_files -norecurse [concat \
    [list $repo/rtl/fpga/gb_fpga_top.v \
          $repo/rtl/gb_top.v \
          $repo/rtl/cpu/cpu.v \
          $repo/rtl/cpu/interrupt_ctrl.v \
          $repo/rtl/timer/timer.v \
          $repo/rtl/clocking/clk_div.v \
          $repo/rtl/memory/memory_map.v \
          $repo/rtl/memory/wram.v \
          $repo/rtl/memory/hram.v \
          $repo/rtl/cartridge/cartridge.v \
          $repo/rtl/joypad/joypad.v \
          $repo/rtl/joypad/ps2_keys.v] \
    [glob $repo/rtl/ppu/*.v]]

add_files -fileset constrs_1 -norecurse $repo/constraints/basys3_gb.xdc

set boot_hex $repo/roms/boot/boot_rom.hex
set cart_hex $repo/roms/game/cart_rom.hex
foreach f [list $boot_hex $cart_hex] {
    if {![file exists $f]} { error "missing rom file: $f" }
}
set_property generic "BOOT_ROM_FILE=\"$boot_hex\" CART_ROM_FILE=\"$cart_hex\"" [current_fileset]

set_property top gb_fpga_top [current_fileset]
update_compile_order -fileset sources_1

puts "project created at $proj_dir"