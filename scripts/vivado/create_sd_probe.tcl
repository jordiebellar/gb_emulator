# =============================================================================
# Project      : GameBoy Emulator
# File         : create_sd_probe.tcl
# Description  : creates the vivado project for sd_probe_top, the sd card
#                bring-up design, no game boy in it. sources are added by
#                reference, not copied.
#                run from the vivado tcl console:  source <repo>/scripts/vivado/create_sd_probe.tcl
#                GB_VIVADO_DIR overrides where the project is made.
# =============================================================================

set repo [file normalize [file join [file dirname [info script]] .. ..]]

if {[info exists ::env(GB_VIVADO_DIR)]} {
    set proj_dir [file normalize $::env(GB_VIVADO_DIR)]
} else {
    set proj_dir "C:/vivado_work/sd_probe"
}

create_project -force sd_probe $proj_dir -part xc7a35ticpg236-1L
set_property target_language Verilog [current_project]

add_files -norecurse [list \
    $repo/rtl/fpga/sd_probe_top.v \
    $repo/rtl/cartridge/sd_spi.v]

add_files -fileset constrs_1 -norecurse $repo/constraints/basys3_sd_probe.xdc

set_property top sd_probe_top [current_fileset]
update_compile_order -fileset sources_1

puts "project created at $proj_dir"
