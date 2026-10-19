# creates the vivado project for the basic video output test
#
# run it from vivado with  Tools > Run Tcl Script  or from the tcl console
#   source <repo>/scripts/vivado/create_video_test.tcl
# or from a command prompt
#   vivado -mode batch -source scripts/vivado/create_video_test.tcl
#
# the project is made outside the repo so the build folders stay out of
# onedrive. the sources are added by reference and are not copied, so
# edits in the repo show up in vivado right away.
# set the environment variable GB_VIVADO_DIR to put the project somewhere else.

set repo [file normalize [file join [file dirname [info script]] .. ..]]

if {[info exists ::env(GB_VIVADO_DIR)]} {
    set proj_dir [file normalize $::env(GB_VIVADO_DIR)]
} else {
    set proj_dir "C:/vivado_work/gb_video_test"
}

create_project -force gb_video_test $proj_dir -part xc7a35tcpg236-1
set_property target_language Verilog [current_project]
set_property simulator_language Verilog [current_project]

# design sources - reference only, no copy
add_files -norecurse [list \
    $repo/rtl/fpga/video_test_top.v \
    $repo/rtl/clocking/clk_div.v \
    $repo/rtl/ppu/video.v \
    $repo/rtl/ppu/vga_sync.v \
    $repo/rtl/ppu/framebuffer.v \
    $repo/rtl/ppu/palette.v \
]

# constraints
add_files -fileset constrs_1 -norecurse $repo/constraints/basys3_video_test.xdc

# simulation
add_files -fileset sim_1 -norecurse $repo/tb/fpga/tb_video_test_top.v

set_property top video_test_top [get_filesets sources_1]
set_property top tb_video_test_top [get_filesets sim_1]
set_property -name {xsim.simulate.runtime} -value {-all} -objects [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "project created at $proj_dir"
puts "next - Run Synthesis, Run Implementation, Generate Bitstream, then program the board"
