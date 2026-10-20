## timing exception for the ppu in ppu_demo_top
##
## every register in the ppu only loads when ce_gb is high, and ce_gb is high
## once every 23 or 24 clocks of the 100 mhz clock, the 4.194304 mhz t-cycle.
## between two loads the logic in front of a register has about 23 clocks to
## settle, but the timing tools assume one clock unless told otherwise. so a
## path from one register in the ppu to another is given 20 clocks, a little
## less than the real 23, to keep some margin.
##
## setup 20 and hold 19 is the usual pair, the hold check stays on the same
## edge it normally would.
##
## this only covers paths that start and end inside u_ppu. the video block,
## the clock divider, and the demo sequencer are not covered and still have
## to meet one clock.

set_multicycle_path -setup 20 -from [get_cells -hierarchical -filter {NAME =~ u_ppu/*}] -to [get_cells -hierarchical -filter {NAME =~ u_ppu/*}]
set_multicycle_path -hold 19 -from [get_cells -hierarchical -filter {NAME =~ u_ppu/*}] -to [get_cells -hierarchical -filter {NAME =~ u_ppu/*}]
