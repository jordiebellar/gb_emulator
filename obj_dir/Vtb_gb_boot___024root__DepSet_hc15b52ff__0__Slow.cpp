// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_gb_boot.h for the primary calling header

#include "Vtb_gb_boot__pch.h"
#include "Vtb_gb_boot___024root.h"

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_static__TOP(Vtb_gb_boot___024root* vlSelf);

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_static(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_static\n"); );
    // Body
    Vtb_gb_boot___024root___eval_static__TOP(vlSelf);
}

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_static__TOP(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_static__TOP\n"); );
    // Body
    vlSelf->tb_gb_boot__DOT__clk = 0U;
    vlSelf->tb_gb_boot__DOT__rst = 1U;
    vlSelf->tb_gb_boot__DOT__max_frames = 0x190U;
    vlSelf->tb_gb_boot__DOT__dump_every = 0x14U;
    vlSelf->tb_gb_boot__DOT__after_boot = 0x96U;
    vlSelf->tb_gb_boot__DOT__use_stub = 0U;
    vlSelf->tb_gb_boot__DOT__frame = 0U;
    vlSelf->tb_gb_boot__DOT__boot_frame = 0xffffffffU;
    vlSelf->tb_gb_boot__DOT__boot_d = 1U;
    vlSelf->tb_gb_boot__DOT__mooneye = 0U;
    vlSelf->tb_gb_boot__DOT__trace3 = 0U;
    vlSelf->tb_gb_boot__DOT__prev_mode = 0U;
    vlSelf->tb_gb_boot__DOT__trace = 0U;
    vlSelf->tb_gb_boot__DOT__sb = 0U;
    vlSelf->tb_gb_boot__DOT__last6 = 0ULL;
}

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_initial__TOP(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP\n"); );
    // Init
    IData/*31:0*/ tb_gb_boot__DOT__k;
    tb_gb_boot__DOT__k = 0;
    IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i;
    tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i = 0;
    IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i;
    tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i = 0;
    IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i = 0;
    IData/*31:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i = 0;
    VlWide<6>/*191:0*/ __Vtemp_2;
    VlWide<6>/*191:0*/ __Vtemp_3;
    // Body
    tb_gb_boot__DOT__k = 0U;
    while (VL_GTS_III(32, 0x5a00U, tb_gb_boot__DOT__k)) {
        vlSelf->tb_gb_boot__DOT____Vlvbound_hcb4af1a2__0 = 0U;
        if (VL_LIKELY((0x59ffU >= (0x7fffU & tb_gb_boot__DOT__k)))) {
            vlSelf->tb_gb_boot__DOT__fb[(0x7fffU & tb_gb_boot__DOT__k)] 
                = vlSelf->tb_gb_boot__DOT____Vlvbound_hcb4af1a2__0;
        }
        tb_gb_boot__DOT__k = ((IData)(1U) + tb_gb_boot__DOT__k);
    }
    __Vtemp_2[0U] = 0x2e686578U;
    __Vtemp_2[1U] = 0x5f726f6dU;
    __Vtemp_2[2U] = 0x626f6f74U;
    __Vtemp_2[3U] = 0x6f6f742fU;
    __Vtemp_2[4U] = 0x6d732f62U;
    __Vtemp_2[5U] = 0x726fU;
    VL_READMEM_N(true, 8, 256, 0, VL_CVT_PACK_STR_NW(6, __Vtemp_2)
                 ,  &(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom)
                 , 0, ~0ULL);
    __Vtemp_3[0U] = 0x2e686578U;
    __Vtemp_3[1U] = 0x5f726f6dU;
    __Vtemp_3[2U] = 0x63617274U;
    __Vtemp_3[3U] = 0x616d652fU;
    __Vtemp_3[4U] = 0x6d732f67U;
    __Vtemp_3[5U] = 0x726fU;
    VL_READMEM_N(true, 8, 32768, 0, VL_CVT_PACK_STR_NW(6, __Vtemp_3)
                 ,  &(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_rom)
                 , 0, ~0ULL);
    tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i = 0U;
    while (VL_GTS_III(32, 0x2000U, tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i)) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem[(0x1fffU 
                                                             & tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i)] = 0U;
        tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i = 
            ((IData)(1U) + tb_gb_boot__DOT__dut__DOT__u_wram__DOT__i);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata = 0U;
    tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i = 0U;
    while (VL_GTS_III(32, 0x7fU, tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i)) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_hca9c3d5e__0 = 0U;
        if (VL_LIKELY((0x7eU >= (0x7fU & tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i)))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem[(0x7fU 
                                                                 & tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i)] 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_hca9c3d5e__0;
        }
        tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i = 
            ((IData)(1U) + tb_gb_boot__DOT__dut__DOT__u_hram__DOT__i);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__rdata = 0U;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i = 0U;
    while (VL_GTS_III(32, 0x2000U, tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i)) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem[(0x1fffU 
                                                                         & tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i)] = 0U;
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i 
            = ((IData)(1U) + tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__i);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__rdata = 0U;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i = 0U;
    while (VL_GTS_III(32, 0xa0U, tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i)) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h0c289f98__0 = 0U;
        if (VL_LIKELY((0x9fU >= (0xffU & tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i)))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem[(0xffU 
                                                                            & tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i)] 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h0c289f98__0;
        }
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i 
            = ((IData)(1U) + tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__i);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__rdata = 0U;
}

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_final(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_gb_boot___024root___dump_triggers__stl(Vtb_gb_boot___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtb_gb_boot___024root___eval_phase__stl(Vtb_gb_boot___024root* vlSelf);

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_settle(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vtb_gb_boot___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("tb/tb_gb_boot.v", 51, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtb_gb_boot___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_gb_boot___024root___dump_triggers__stl(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_gb_boot___024root___stl_sequent__TOP__0(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___stl_sequent__TOP__0\n"); );
    // Init
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__irq_timer;
    tb_gb_boot__DOT__dut__DOT__irq_timer = 0;
    CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__cmp_off_next;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__cmp_off_next = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m0_next;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m0_next = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m1_next;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m1_next = 0;
    CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal = 0;
    CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT____VdfgTmp_h905c5a62__0;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT____VdfgTmp_h905c5a62__0 = 0;
    CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw = 0;
    CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r = 0;
    CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel = 0;
    CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src = 0;
    CData/*1:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0 = 0;
    CData/*3:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0 = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie_n;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie_n = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_h2564491b__0;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_h2564491b__0 = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_hc2d88e5c__0;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_hc2d88e5c__0 = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__bus_wr;
    tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__bus_wr = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_write;
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_write = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_now;
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_now = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_next;
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_next = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick;
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick = 0;
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0;
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0 = 0;
    CData/*0:0*/ __VdfgTmp_h3183dfc6__0;
    __VdfgTmp_h3183dfc6__0 = 0;
    CData/*7:0*/ __VdfgTmp_hf5649b4a__0;
    __VdfgTmp_hf5649b4a__0 = 0;
    CData/*7:0*/ __VdfgTmp_hfbf07a09__0;
    __VdfgTmp_hfbf07a09__0 = 0;
    // Body
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc_next 
        = (0x1ffffffffULL & (0xabcc771ULL + (QData)((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r) 
           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now 
        = ((5U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q)
            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in 
        = ((8U > (0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                           >> 8U))) ? (0x1fU & ((IData)(8U) 
                                                - (7U 
                                                   & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                      >> 8U))))
            : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xfffcU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | ((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
               ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                         << 1U)) | (1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo)))
               : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                         >> 6U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                          >> 7U)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xfff3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q)) 
                   | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                            >> 1U))) : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                                               >> 5U)) 
                                        | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                                 >> 6U)))) 
              << 2U));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xffcfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 1U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 2U)))
                : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 4U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 5U)))) 
              << 4U));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xff3fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 2U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 3U)))
                : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 3U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 4U)))) 
              << 6U));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xfcffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 3U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 4U)))
                : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 2U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 3U)))) 
              << 8U));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xf3ffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 4U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 5U)))
                : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 1U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 2U)))) 
              << 0xaU));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0xcfffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 5U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 6U)))
                : ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q)) 
                   | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                            >> 1U)))) << 0xcU));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow 
        = ((0x3fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow)) 
           | (((0x20000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                ? ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          >> 6U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo) 
                                           >> 7U)))
                : ((2U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q) 
                          << 1U)) | (1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo)))) 
              << 0xeU));
    __VdfgTmp_hf5649b4a__0 = ((0x9fU >= (0xffU & ((IData)(1U) 
                                                  + 
                                                  (0xfcU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                                      << 1U)))))
                               ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem
                              [(0xffU & ((IData)(1U) 
                                         + (0xfcU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                             << 1U))))]
                               : 0U);
    __VdfgTmp_hfbf07a09__0 = ((0x9fU >= (0xfcU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                                  << 1U)))
                               ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem
                              [(0xfcU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                         << 1U))] : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)
                                                    ? 
                                                   (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                                                     << 8U) 
                                                    | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx))
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read)
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)
            : ([&]() {
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__Vfuncout 
                    = ((4U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                        ? ((2U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                            ? ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                : 0U) : ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                                          ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                          : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                        : ((2U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                            ? ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                            : ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
            }(), (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__Vfuncout)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color 
        = ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
            ? (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo))
            : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_serial = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_apu = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma = 0U;
    if ((0x7fffU < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
        if ((1U & (~ ((0x8000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                      & (0x9fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
            if ((1U & (~ ((0xa000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                          & (0xbfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                if ((1U & (~ ((0xc000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                              & (0xdfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                    if ((1U & (~ ((0xe000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                  & (0xfdffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                        if ((1U & (~ ((0xfe00U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                      & (0xfe9fU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                            if ((0xff00U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                if ((1U & (~ ((0xff01U 
                                               <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                              & (0xff02U 
                                                 >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                    if ((1U & (~ ((0xff04U 
                                                   <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                  & (0xff07U 
                                                     >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                        if ((0xff0fU 
                                             != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                            if ((1U 
                                                 & (~ 
                                                    ((0xff10U 
                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                     & (0xff3fU 
                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                if (
                                                    (1U 
                                                     & (~ 
                                                        ((0xff40U 
                                                          <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                         & (0xff45U 
                                                            >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                    if (
                                                        (0xff46U 
                                                         != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                        if (
                                                            (1U 
                                                             & (~ 
                                                                ((0xff47U 
                                                                  <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                                 & (0xff4bU 
                                                                    >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                            if (
                                                                (0xff50U 
                                                                 != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                                if (
                                                                    ((0xff80U 
                                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                                     & (0xfffeU 
                                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                                                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram = 1U;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    if (
                                                        (0xff46U 
                                                         == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                        vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma = 1U;
                                                    }
                                                }
                                            }
                                            if (((0xff10U 
                                                  <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                 & (0xff3fU 
                                                    >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_apu = 1U;
                                            }
                                        }
                                    }
                                }
                                if (((0xff01U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                     & (0xff02U >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_serial = 1U;
                                }
                            }
                            if ((0xff00U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad = 1U;
                            }
                        }
                        if (((0xfe00U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                             & (0xfe9fU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam = 1U;
                        }
                    }
                }
            }
            if (((0xa000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                 & (0xbfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram = 1U;
            }
        }
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y = ((0x80U 
                                                   & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                                   ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r)
                                                   : 0U);
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_now 
        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac) 
            >> 2U) & ([&]() {
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s 
                    = (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac));
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt;
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__Vfuncout 
                    = (1U & ((2U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s))
                              ? ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s))
                                  ? ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt) 
                                     >> 7U) : ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt) 
                                               >> 5U))
                              : ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s))
                                  ? ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt) 
                                     >> 3U) : ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt) 
                                               >> 9U))));
            }(), (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__Vfuncout)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__irq_vblank = 
        ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) 
           & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
              >> 7U)) & (0x1c7U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter))) 
         & (0x8fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_blocked 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run) 
           & (0xffU != (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                                 >> 8U))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom = 0U;
    if ((0x7fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom = 1U;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0 
        = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt) 
                      + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg = 0U;
    if ((0x7fffU < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
        if (((0x8000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
             & (0x9fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram = 1U;
        }
        if ((1U & (~ ((0x8000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                      & (0x9fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
            if ((1U & (~ ((0xa000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                          & (0xbfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                if ((1U & (~ ((0xc000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                              & (0xdfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                    if ((1U & (~ ((0xe000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                  & (0xfdffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                        if ((1U & (~ ((0xfe00U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                      & (0xfe9fU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                            if ((0xff00U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                if ((1U & (~ ((0xff01U 
                                               <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                              & (0xff02U 
                                                 >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                    if ((1U & (~ ((0xff04U 
                                                   <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                  & (0xff07U 
                                                     >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                        if ((0xff0fU 
                                             != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                            if ((1U 
                                                 & (~ 
                                                    ((0xff10U 
                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                     & (0xff3fU 
                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                if (
                                                    (1U 
                                                     & (~ 
                                                        ((0xff40U 
                                                          <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                         & (0xff45U 
                                                            >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                    if (
                                                        (0xff46U 
                                                         != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                        if (
                                                            (1U 
                                                             & (~ 
                                                                ((0xff47U 
                                                                  <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                                 & (0xff4bU 
                                                                    >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                            if (
                                                                (0xff50U 
                                                                 == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable = 1U;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if (((0xc000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                     & (0xdfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = 1U;
                } else if (((0xe000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                            & (0xfdffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = 1U;
                }
            }
        }
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)
            ? (6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                            >> 5U))) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram));
    if ((0x7fffU < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
        if ((1U & (~ ((0x8000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                      & (0x9fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
            if ((1U & (~ ((0xa000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                          & (0xbfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                if ((1U & (~ ((0xc000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                              & (0xdfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                    if ((1U & (~ ((0xe000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                  & (0xfdffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                        if ((1U & (~ ((0xfe00U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                      & (0xfe9fU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                            if ((0xff00U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                if ((1U & (~ ((0xff01U 
                                               <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                              & (0xff02U 
                                                 >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                    if ((1U & (~ ((0xff04U 
                                                   <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                  & (0xff07U 
                                                     >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                        if ((0xff0fU 
                                             == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                            vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl = 1U;
                                        } else if (
                                                   (1U 
                                                    & (~ 
                                                       ((0xff10U 
                                                         <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                        & (0xff3fU 
                                                           >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                            if ((1U 
                                                 & (~ 
                                                    ((0xff40U 
                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                     & (0xff45U 
                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                if (
                                                    (0xff46U 
                                                     != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                    if (
                                                        (1U 
                                                         & (~ 
                                                            ((0xff47U 
                                                              <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                             & (0xff4bU 
                                                                >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                        if (
                                                            (0xff50U 
                                                             != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                            if (
                                                                (1U 
                                                                 & (~ 
                                                                    ((0xff80U 
                                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                                     & (0xfffeU 
                                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                                if (
                                                                    (0xffffU 
                                                                     == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl = 1U;
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        if ((0xff0fU 
                                             != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                            if ((1U 
                                                 & (~ 
                                                    ((0xff10U 
                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                     & (0xff3fU 
                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
                                                if (
                                                    ((0xff40U 
                                                      <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                     & (0xff45U 
                                                        >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg = 1U;
                                                } else if (
                                                           (0xff46U 
                                                            != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                    if (
                                                        ((0xff47U 
                                                          <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                                         & (0xff4bU 
                                                            >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                                        vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg = 1U;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (((0xff04U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                                         & (0xff07U 
                                            >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                                        vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer = 1U;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter;
    vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) 
                                               & (3U 
                                                  == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw 
        = ((7U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx))
            ? 0U : (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx) 
                             - (IData)(7U))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16 
        = ((0xfff0U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16)) 
           | (((8U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                      >> 3U)) | (4U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                       >> 4U))) | (
                                                   (2U 
                                                    & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                                                       >> 6U)) 
                                                   | (1U 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                                         >> 7U)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16 
        = ((0xff0fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16)) 
           | (((0x80U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                         << 3U)) | (0x40U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                             << 2U))) 
              | ((0x20U & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now)) 
                 | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                             >> 1U)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16 
        = ((0xf0ffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16)) 
           | (((0x800U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                          << 9U)) | (0x400U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                               << 8U))) 
              | ((0x200U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                            << 6U)) | (0x100U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                                 << 5U)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16 
        = ((0xfffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16)) 
           | (((0x8000U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                           << 0xfU)) | (0x4000U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                                   << 0xeU))) 
              | ((0x2000U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now) 
                             << 0xcU)) | (0x1000U & 
                                          ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r) 
                                           << 0xbU)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in;
    if ((((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
          & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                          >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U)))))) 
         & (0U == (3U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xfffffff0U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((8U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                         >> 0x1cU)) | ((4U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                              >> 0x1aU)) 
                                       | (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                >> 
                                                (0xfU 
                                                 & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U)))))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x30U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xffffff0fU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x80U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                            >> 0x18U)) | ((0x40U & 
                                           (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                            >> 0x16U)) 
                                          | (0x30U 
                                             & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                 >> 
                                                 (0xfU 
                                                  & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                << 4U)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(2U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x300U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xfffff0ffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x800U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                             >> 0x14U)) | ((0x400U 
                                            & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                               >> 0x12U)) 
                                           | (0x300U 
                                              & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                  >> 
                                                  (0xfU 
                                                   & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                 << 8U)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(3U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x3000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xffff0fffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x8000U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                              >> 0x10U)) | ((0x4000U 
                                             & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                >> 0xeU)) 
                                            | (0x3000U 
                                               & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                   >> 
                                                   (0xfU 
                                                    & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                  << 0xcU)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(4U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x30000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xfff0ffffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x80000U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                               >> 0xcU)) | ((0x40000U 
                                             & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                >> 0xaU)) 
                                            | (0x30000U 
                                               & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                   >> 
                                                   (0xfU 
                                                    & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                  << 0x10U)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(5U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x300000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xff0fffffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x800000U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                >> 8U)) | ((0x400000U 
                                            & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                               >> 6U)) 
                                           | (0x300000U 
                                              & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                  >> 
                                                  (0xfU 
                                                   & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                 << 0x14U)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(6U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x3000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xf0ffffffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x8000000U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                 >> 4U)) | ((0x4000000U 
                                             & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                >> 2U)) 
                                            | (0x3000000U 
                                               & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                   >> 
                                                   (0xfU 
                                                    & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                  << 0x18U)))));
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src 
        = (0x1fU & ((IData)(7U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in)));
    if ((IData)(((0U == (0x30000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)) 
                 & ((8U > (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src)) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                    >> (0xfU & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged 
            = ((0xfffffffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged) 
               | ((0x80000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head) 
                  | ((0x40000000U & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                     << 2U)) | (0x30000000U 
                                                & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow) 
                                                    >> 
                                                    (0xfU 
                                                     & VL_SHIFTL_III(4,32,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src), 1U))) 
                                                   << 0x1cU)))));
    }
    if ((0x28U > (0x3fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                           >> 1U)))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x 
            = __VdfgTmp_hf5649b4a__0;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data 
            = ((((0x9fU >= (0xffU & ((IData)(3U) + 
                                     (0xfcU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                               << 1U)))))
                  ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem
                 [(0xffU & ((IData)(3U) + (0xfcU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                            << 1U))))]
                  : 0U) << 0x18U) | ((((0x9fU >= (0xffU 
                                                  & ((IData)(2U) 
                                                     + 
                                                     (0xfcU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                                         << 1U)))))
                                        ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem
                                       [(0xffU & ((IData)(2U) 
                                                  + 
                                                  (0xfcU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                                      << 1U))))]
                                        : 0U) << 0x10U) 
                                     | (((IData)(__VdfgTmp_hf5649b4a__0) 
                                         << 8U) | (IData)(__VdfgTmp_hfbf07a09__0))));
    } else {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x = 0xffU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data = 0xffffffffU;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__diff 
        = (0x1ffU & (((IData)(0x10U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y)) 
                     - ((0x28U > (0x3fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt) 
                                           >> 1U)))
                         ? (IData)(__VdfgTmp_hfbf07a09__0)
                         : 0xffU)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row 
        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win)
                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc)
                     : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y) 
                        + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0 
        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y) 
                   - (0xffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj 
        = ((~ ((vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
                >> 3U) & (0U != (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color)))) 
           & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
               >> 1U) & (0U != (3U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff 
        = ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_blocked)) 
           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram));
    vlSelf->tb_gb_boot__DOT__dut__DOT__cart_data_out 
        = ((1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)
                   ? (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                         >> 7U)) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom)))
            ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_sel_q)
                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_q)
                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_q))
            : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable)
                ? 0xffU : 0U));
    tb_gb_boot__DOT__dut__DOT__irq_timer = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
                                            & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending));
    __VdfgTmp_h3183dfc6__0 = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win) 
           & VL_GTES_III(10, (0x3ffU & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                  >> 8U)) 
                                        - (IData)(8U))), (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw)));
    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3;
        if ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))) {
            if ((0x1c7U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n 
                    = ((0x99U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r))
                        ? 0U : (0xffU & ((IData)(1U) 
                                         + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r))));
            } else {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n 
                    = (0x1ffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter)));
            }
        } else {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n = 1U;
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n = 4U;
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n = 0U;
        }
    } else {
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d4;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n 
        = ((3U == (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n))
            ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb)
                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)
                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1))
            : (((1U == (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n)) 
                & (0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n)))
                ? 0U : (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_d4_n)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT____VdfgTmp_h905c5a62__0 
        = ((0x99U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n)) 
           & (8U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode 
        = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)
            : 0U);
    if ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx 
            = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr) 
                       + ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling) 
                          & (0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt)))));
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok 
            = (1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling) 
                        | (0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count)))));
    } else {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok = 0U;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__data_lo 
        = (0x1fffU & (((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                        ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx) 
                           << 4U) : ((IData)(0x800U) 
                                     + ((0x800U & (
                                                   (~ 
                                                    ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx) 
                                                     >> 7U)) 
                                                   << 0xbU)) 
                                        | (0x7f0U & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx) 
                                            << 4U))))) 
                      + (0xeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row) 
                                 << 1U))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r 
        = (0xfU & ((0x40000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                    ? (((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                         ? 0xfU : 7U) - (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0))
                    : (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj)
            ? ((4U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)
                ? 2U : 1U) : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__wram_data_out 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff)
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata)
            : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__wr_start 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma) 
           & (IData)(__VdfgTmp_h3183dfc6__0));
    tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__bus_wr 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl) 
           & (IData)(__VdfgTmp_h3183dfc6__0));
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer) 
           & (IData)(__VdfgTmp_h3183dfc6__0));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_hc2d88e5c__0 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg) 
           & (IData)(__VdfgTmp_h3183dfc6__0));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos 
        = (0x3ffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win)
                      ? (((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                    >> 8U)) - (IData)(8U)) 
                         - (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw))
                      : (((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                    >> 8U)) - (IData)(8U)) 
                         + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__cmp_off_next 
        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
            >> 7U) & (((4U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)) 
                       & (0U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n))) 
                      | ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT____VdfgTmp_h905c5a62__0) 
                         & (0xcU > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)))));
    if ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))) {
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next 
            = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT____VdfgTmp_h905c5a62__0)
                ? 0U : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n));
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next 
            = ((~ (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__cmp_off_next)) 
               & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next) 
                  == (((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_hc2d88e5c__0) 
                       & (5U == (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))))
                       ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)
                       : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc))));
    } else {
        tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_r;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop 
        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count) 
                   - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok) 
           & ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard)) 
              & (0xa0U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr 
        = ((0xff0U & (((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                        ? ((0xfeU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                     >> 0x10U)) | (1U 
                                                   & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r) 
                                                      >> 3U)))
                        : (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                           >> 0x10U)) << 4U)) | (0xfU 
                                                 & VL_SHIFTL_III(4,4,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r), 1U)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_shade 
        = (3U & (((0U == (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal))
                   ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp)
                   : ((1U == (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal))
                       ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0)
                       : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1))) 
                 >> (6U & (((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj)
                             ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj
                             : (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color)) 
                           << 1U))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_next 
        = (((IData)(tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__bus_wr) 
            & (0xffffU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)
            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r));
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_write 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0) 
           & (1U == (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next 
        = (((IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0) 
            & (2U == (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))))
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)
            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next 
        = (7U & (((IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0) 
                  & (3U == (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))))
                  ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)
                  : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__div_write 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2d88e5c__0) 
           & (0U == (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_hc2d88e5c__0) 
           & (1U == (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__penalty 
        = (0xfU & ((IData)(6U) + (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid) 
                                   & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t) 
                                       == (0x7fU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos) 
                                            >> 3U))) 
                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win) 
                                         == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win))))
                                   ? 0U : ((0U == (0xffU 
                                                   & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                      >> 8U)))
                                            ? 5U : 
                                           ((5U <= 
                                             (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos)))
                                             ? 0U : 
                                            ((IData)(5U) 
                                             - (7U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos))))))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok 
        = ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode)) 
           & (((5U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate)) 
               | (6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) 
              & ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy)) 
                 & (0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel) 
           & ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win)) 
              & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                  >> 5U) & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                            & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond) 
                               & ((0xa6U >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx)) 
                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt) 
                                     == (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw))))))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__cnt_next 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__div_write)
            ? 0U : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie_n 
        = (1U & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr)
                  ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                     >> 6U) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__reg_rdata 
        = ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
            ? ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                ? 0xffU : ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                            ? ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy))
                            : ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0))))
            : ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                ? ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                    ? ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp)
                        : 0xffU) : ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc)
                                     : ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                         ? (((0x99U 
                                              == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n)) 
                                             & (4U 
                                                <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)))
                                             ? 0U : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n))
                                         : 0U))) : 
               ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                 ? ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx)
                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy))
                 : ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                     ? (0x80U | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie) 
                                  << 6U) | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie) 
                                             << 5U) 
                                            | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie) 
                                                << 4U) 
                                               | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie) 
                                                   << 3U) 
                                                  | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next) 
                                                      << 2U) 
                                                     | ((0x80U 
                                                         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                                         ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)
                                                         : 0U)))))))
                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc)))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0 
        = ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start)) 
           & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel));
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_next 
        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next) 
            >> 2U) & ([&]() {
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s 
                    = (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next));
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__cnt_next;
                vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__Vfuncout 
                    = (1U & ((2U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s))
                              ? ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s))
                                  ? ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt) 
                                     >> 7U) : ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt) 
                                               >> 5U))
                              : ((1U & (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s))
                                  ? ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt) 
                                     >> 3U) : ((IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt) 
                                               >> 9U))));
            }(), (IData)(vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__Vfuncout)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0) 
           & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
               >> 1U) & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr) 
                          < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count)) 
                         & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                      >> 8U)) <= (0x1ffU 
                                                  & ((IData)(8U) 
                                                     + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)))))));
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick 
        = ((~ (IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_next)) 
           & (IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_now));
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid 
        = ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode)) 
           & ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig)) 
              & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima;
    if (tb_gb_boot__DOT__dut__DOT__irq_timer) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next;
    } else {
        if ((1U & (~ (IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_write)))) {
            if (tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick) {
                if ((0xffU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next = 1U;
                }
            }
        }
        if (tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_write) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        } else if (tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next 
                = ((0xffU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima))
                    ? 0U : (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima))));
        }
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid) 
           & (0x9fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r;
    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        if ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))) {
            if ((0x1c7U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter))) {
                if ((0x99U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 2U;
                } else if ((0x8fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 1U;
                } else if ((0x8fU > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 2U;
                }
            } else if ((((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)) 
                         | ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r) 
                            & (0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)))) 
                        & (0x4fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter)))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 3U;
            } else if (((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)) 
                        & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 0U;
            }
        } else {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = 0U;
        }
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m1_next 
        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
            >> 7U) & (1U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m0_next 
        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
            >> 7U) & ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)) 
                      & ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n) 
                             & (0x50U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)))) 
                         & (0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb)
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3))))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_h2564491b__0 
        = ((((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr)
              ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                 >> 3U) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie)) 
            & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m0_next)) 
           | ((((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr)
                 ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                    >> 4U) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie)) 
               & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m1_next)) 
              | (((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr)
                   ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                      >> 5U) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie)) 
                 & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                     >> 7U) & (((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)) 
                                | (0x90U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n))) 
                               & (4U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n)))))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_n 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_h2564491b__0) 
           | ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie_n) 
              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r;
    if (((IData)(tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__bus_wr) 
         & (0xff0fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next 
            = (0x1fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out));
    }
    if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next 
            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next) 
               & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire)));
    }
    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next 
            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next) 
               | (((IData)(tb_gb_boot__DOT__dut__DOT__irq_timer) 
                   << 2U) | ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) 
                               << 1U) & (((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_r)) 
                                          << 1U) & 
                                         (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_n) 
                                           << 1U) | 
                                          (((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT____VdfgTmp_h2564491b__0) 
                                            << 1U) 
                                           | ((((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie_n) 
                                                & ((0x80U 
                                                    & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                                    ? 
                                                   ((~ (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__cmp_off_next)) 
                                                    & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__ly_cmp_next) 
                                                       == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc)))
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_r))) 
                                               << 1U) 
                                              | (0x3fffffeU 
                                                 & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                                                     >> 6U) 
                                                    & (((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_wr) 
                                                        & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m0_next) 
                                                           | ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__term_m1_next) 
                                                              | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next)))) 
                                                       << 1U)))))))) 
                             | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__irq_vblank))));
    }
    vlSelf->tb_gb_boot__DOT__din = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_blocked)
                                     ? 0xffU : (0xffU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom)
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cart_data_out)
                                                    : 
                                                   ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable)
                                                     ? 0xffU
                                                     : 
                                                    ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram)
                                                      ? 0xffU
                                                      : 
                                                     ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram)
                                                       ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__wram_data_out)
                                                       : 
                                                      ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram)
                                                        ? 
                                                       ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff)
                                                         ? 
                                                        ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                                                           >> 7U) 
                                                          & ((3U 
                                                              == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)) 
                                                             | ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n)) 
                                                                & (3U 
                                                                   == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)))))
                                                          ? 0xffU
                                                          : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__rdata))
                                                         : 0U)
                                                        : 
                                                       ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam)
                                                         ? 
                                                        ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam)
                                                          ? 
                                                         (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                                                             >> 7U) 
                                                            & ((3U 
                                                                == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)) 
                                                               | ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n)) 
                                                                  & ((2U 
                                                                      == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)) 
                                                                     | (3U 
                                                                        == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n)))))) 
                                                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run))
                                                           ? 0xffU
                                                           : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__rdata))
                                                          : 0U)
                                                         : 
                                                        ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad)
                                                          ? 
                                                         ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad)
                                                           ? 
                                                          (0xcfU 
                                                           | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_btn) 
                                                               << 5U) 
                                                              | ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_dir) 
                                                                 << 4U)))
                                                           : 0U)
                                                          : 
                                                         ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_serial)
                                                           ? 0xffU
                                                           : 
                                                          ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer)
                                                            ? 
                                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer)
                                                             ? 
                                                            ((2U 
                                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                                              ? 
                                                             ((1U 
                                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                                               ? 
                                                              (0xf8U 
                                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next))
                                                               : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next))
                                                              : 
                                                             ((1U 
                                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                                               ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next)
                                                               : 
                                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__div_write)
                                                                ? 0U
                                                                : 
                                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0) 
                                                                >> 8U))))
                                                             : 0U)
                                                            : 
                                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl)
                                                             ? 
                                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl)
                                                              ? 
                                                             ((0xffffU 
                                                               == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))
                                                               ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_next)
                                                               : 
                                                              (0xe0U 
                                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next)))
                                                              : 0U)
                                                             : 
                                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_apu)
                                                              ? 0xffU
                                                              : 
                                                             ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg)
                                                               ? 
                                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg)
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__reg_rdata)
                                                                : 0U)
                                                               : 
                                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma)
                                                                ? 
                                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma)
                                                                 ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__src_reg)
                                                                 : 0U)
                                                                : 
                                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram)
                                                                 ? 
                                                                ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram)
                                                                  ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__rdata)
                                                                  : 0U)
                                                                 : 0xffU))))))))))))))));
}

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_stl(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vtb_gb_boot___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_triggers__stl(Vtb_gb_boot___024root* vlSelf);

VL_ATTR_COLD bool Vtb_gb_boot___024root___eval_phase__stl(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtb_gb_boot___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vtb_gb_boot___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_gb_boot___024root___dump_triggers__act(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge tb_gb_boot.clk)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge tb_gb_boot.clk or posedge tb_gb_boot.rst)\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtb_gb_boot___024root___dump_triggers__nba(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge tb_gb_boot.clk)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge tb_gb_boot.clk or posedge tb_gb_boot.rst)\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtb_gb_boot___024root___ctor_var_reset(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->tb_gb_boot__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__rst = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__din = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__max_frames = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dump_every = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__after_boot = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__use_stub = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(1024, vlSelf->tb_gb_boot__DOT__cart_name);
    VL_RAND_RESET_W(1024, vlSelf->tb_gb_boot__DOT__boot_name);
    vlSelf->tb_gb_boot__DOT__n = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 23040; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__fb[__Vi0] = VL_RAND_RESET_I(2);
    }
    vlSelf->tb_gb_boot__DOT__frame = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__boot_frame = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__fd = 0;
    vlSelf->tb_gb_boot__DOT__x = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__y = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__boot_d = VL_RAND_RESET_I(1);
    VL_RAND_RESET_W(256, vlSelf->tb_gb_boot__DOT__fname);
    vlSelf->tb_gb_boot__DOT__mooneye = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__trace3 = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__m3_start = VL_RAND_RESET_I(9);
    vlSelf->tb_gb_boot__DOT__prev_mode = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__trace = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__sb = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__last6 = VL_RAND_RESET_Q(48);
    vlSelf->tb_gb_boot__DOT____Vlvbound_hcb4af1a2__0 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT____Vlvbound_hc55e2fae__0 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_serial = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_apu = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__cart_data_out = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__wram_data_out = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_blocked = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__irq_vblank = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_shade = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc_next = VL_RAND_RESET_Q(33);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = VL_RAND_RESET_I(6);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_c = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_a = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending = VL_RAND_RESET_I(5);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__src_reg = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__new_hi = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__wr_start = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vi0] = VL_RAND_RESET_I(8);
    }
    for (int __Vi0 = 0; __Vi0 < 32768; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_rom[__Vi0] = VL_RAND_RESET_I(8);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_q = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_q = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_sel_q = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 8192; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem[__Vi0] = VL_RAND_RESET_I(8);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata = VL_RAND_RESET_I(8);
    for (int __Vi0 = 0; __Vi0 < 127; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem[__Vi0] = VL_RAND_RESET_I(8);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__rdata = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_hca9c3d5e__0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_h93a773fe__0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter = VL_RAND_RESET_I(9);
    VL_RAND_RESET_W(320, vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d4 = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n = VL_RAND_RESET_I(9);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n = VL_RAND_RESET_I(2);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt = VL_RAND_RESET_I(7);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__diff = VL_RAND_RESET_I(9);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos = VL_RAND_RESET_I(4);
    VL_RAND_RESET_W(320, vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x = VL_RAND_RESET_I(5);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t = VL_RAND_RESET_I(7);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__data_lo = VL_RAND_RESET_I(13);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr = VL_RAND_RESET_I(13);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16 = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos = VL_RAND_RESET_I(10);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__penalty = VL_RAND_RESET_I(4);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sprow = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in = VL_RAND_RESET_I(5);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged = VL_RAND_RESET_I(32);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_r = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__reg_rdata = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_n = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_r = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 8192; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem[__Vi0] = VL_RAND_RESET_I(8);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__rdata = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q = VL_RAND_RESET_I(8);
    for (int __Vi0 = 0; __Vi0 < 160; ++__Vi0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem[__Vi0] = VL_RAND_RESET_I(8);
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__rdata = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h0c289f98__0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h5630b187__0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_ha0aefced__0 = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r = VL_RAND_RESET_I(5);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_next = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next = VL_RAND_RESET_I(5);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__div_write = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__cnt_next = VL_RAND_RESET_I(16);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next = VL_RAND_RESET_I(3);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next = VL_RAND_RESET_I(8);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0 = 0;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_btn = VL_RAND_RESET_I(1);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_dir = VL_RAND_RESET_I(1);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__Vfuncout = VL_RAND_RESET_I(8);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__23__reg_id = VL_RAND_RESET_I(3);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__Vfuncout = VL_RAND_RESET_I(1);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__cnt = VL_RAND_RESET_I(16);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__86__s = VL_RAND_RESET_I(2);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__Vfuncout = VL_RAND_RESET_I(1);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__cnt = VL_RAND_RESET_I(16);
    vlSelf->__Vfunc_tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sel_bit__87__s = VL_RAND_RESET_I(2);
    vlSelf->__Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q = VL_RAND_RESET_I(8);
    vlSelf->__Vtrigprevexpr___TOP__tb_gb_boot__DOT__clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__tb_gb_boot__DOT__rst__0 = VL_RAND_RESET_I(1);
}
