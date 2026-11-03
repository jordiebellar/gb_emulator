// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtb_gb_boot.h for the primary calling header

#ifndef VERILATED_VTB_GB_BOOT___024ROOT_H_
#define VERILATED_VTB_GB_BOOT___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtb_gb_boot__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtb_gb_boot___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ tb_gb_boot__DOT__clk;
        CData/*0:0*/ tb_gb_boot__DOT__rst;
        CData/*7:0*/ tb_gb_boot__DOT__din;
        CData/*0:0*/ tb_gb_boot__DOT__use_stub;
        CData/*0:0*/ tb_gb_boot__DOT__boot_d;
        CData/*0:0*/ tb_gb_boot__DOT__mooneye;
        CData/*0:0*/ tb_gb_boot__DOT__trace3;
        CData/*1:0*/ tb_gb_boot__DOT__prev_mode;
        CData/*0:0*/ tb_gb_boot__DOT__trace;
        CData/*7:0*/ tb_gb_boot__DOT__sb;
        CData/*1:0*/ tb_gb_boot__DOT____Vlvbound_hcb4af1a2__0;
        CData/*1:0*/ tb_gb_boot__DOT____Vlvbound_hc55e2fae__0;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__ce_gb;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__ce_m;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__cpu_we;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__if_clear_wire;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__if_clear_we_wire;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_cart_rom;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_boot_disable;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_cart_ram;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_wram;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_ppu_vram;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_ppu_oam;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_ppu_reg;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_oam_dma;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_joypad;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_serial;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_timer;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_apu;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_hram;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__cart_data_out;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__wram_data_out;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__cpu_blocked;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__wram_sel_eff;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__pixel_valid;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__irq_vblank;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__pixel_shade;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__pixel_y;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data;
    };
    struct {
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
        CData/*5:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_c;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_a;
        CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__src_reg;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__new_hi;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__wr_start;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_q;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_q;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_sel_q;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_hram__DOT__rdata;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_hca9c3d5e__0;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_h93a773fe__0;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d4;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n;
        CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n;
        CData/*6:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate;
        CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr;
    };
    struct {
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid;
        CData/*6:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win;
        CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__penalty;
        CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_r;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__reg_rdata;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_n;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_r;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__rdata;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__rdata;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h0c289f98__0;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h5630b187__0;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_ha0aefced__0;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r;
        CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_next;
        CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__div_write;
        CData/*2:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next;
        CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_btn;
        CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_dir;
        CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__Vfuncout;
        CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id;
        CData/*0:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__Vfuncout;
        CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s;
        CData/*0:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__Vfuncout;
        CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s;
        CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__tb_gb_boot__DOT__clk__0;
    };
    struct {
        CData/*0:0*/ __Vtrigprevexpr___TOP__tb_gb_boot__DOT__rst__0;
        CData/*0:0*/ __VactContinue;
        SData/*8:0*/ tb_gb_boot__DOT__m3_start;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__cpu_addr;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__mem_addr;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
        SData/*8:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter;
        SData/*8:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n;
        SData/*8:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__diff;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo;
        SData/*12:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__data_lo;
        SData/*12:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16;
        SData/*9:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__cnt_next;
        SData/*15:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0;
        SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt;
        SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt;
        IData/*31:0*/ tb_gb_boot__DOT__max_frames;
        IData/*31:0*/ tb_gb_boot__DOT__dump_every;
        IData/*31:0*/ tb_gb_boot__DOT__after_boot;
        VlWide<32>/*1023:0*/ tb_gb_boot__DOT__cart_name;
        VlWide<32>/*1023:0*/ tb_gb_boot__DOT__boot_name;
        IData/*31:0*/ tb_gb_boot__DOT__n;
        IData/*31:0*/ tb_gb_boot__DOT__frame;
        IData/*31:0*/ tb_gb_boot__DOT__boot_frame;
        IData/*31:0*/ tb_gb_boot__DOT__fd;
        IData/*31:0*/ tb_gb_boot__DOT__x;
        IData/*31:0*/ tb_gb_boot__DOT__y;
        VlWide<8>/*255:0*/ tb_gb_boot__DOT__fname;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc;
        VlWide<10>/*319:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
        VlWide<10>/*319:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head;
        IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged;
        IData/*31:0*/ __VactIterCount;
        QData/*47:0*/ tb_gb_boot__DOT__last6;
        QData/*32:0*/ tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc_next;
        VlUnpacked<CData/*1:0*/, 23040> tb_gb_boot__DOT__fb;
        VlUnpacked<CData/*7:0*/, 256> tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom;
        VlUnpacked<CData/*7:0*/, 32768> tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_rom;
        VlUnpacked<CData/*7:0*/, 8192> tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem;
        VlUnpacked<CData/*7:0*/, 127> tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem;
        VlUnpacked<CData/*7:0*/, 8192> tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem;
        VlUnpacked<CData/*7:0*/, 160> tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem;
    };
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_h1f51f8f2__0;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtb_gb_boot__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtb_gb_boot___024root(Vtb_gb_boot__Syms* symsp, const char* v__name);
    ~Vtb_gb_boot___024root();
    VL_UNCOPYABLE(Vtb_gb_boot___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
