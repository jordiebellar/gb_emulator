// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_gb_boot.h for the primary calling header

#include "Vtb_gb_boot__pch.h"
#include "Vtb_gb_boot___024root.h"

VL_ATTR_COLD void Vtb_gb_boot___024root___eval_initial__TOP(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__0(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__1(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__2(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__3(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__4(Vtb_gb_boot___024root* vlSelf);
VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__5(Vtb_gb_boot___024root* vlSelf);

void Vtb_gb_boot___024root___eval_initial(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial\n"); );
    // Body
    Vtb_gb_boot___024root___eval_initial__TOP(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__2(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__3(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__4(vlSelf);
    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__5(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__tb_gb_boot__DOT__clk__0 
        = vlSelf->tb_gb_boot__DOT__clk;
    vlSelf->__Vtrigprevexpr___TOP__tb_gb_boot__DOT__rst__0 
        = vlSelf->tb_gb_boot__DOT__rst;
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__0(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Init
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__0__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__0__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__0__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__0__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__1__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__1__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__1__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__1__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__2__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__2__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__2__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__2__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__3__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__3__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__3__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__3__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__4__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__4__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__4__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__4__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__5__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__5__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__5__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__5__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__6__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__6__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__6__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__6__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__7__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__7__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__7__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__7__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__8__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__8__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__8__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__8__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__9__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__9__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__9__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__9__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__10__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__10__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__10__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__10__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__11__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__11__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__11__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__11__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__12__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__12__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__12__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__12__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__13__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__13__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__13__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__13__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__14__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__14__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__14__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__14__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__15__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__15__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__15__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__15__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__16__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__16__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__16__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__16__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__17__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__17__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__17__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__17__v = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__18__addr;
    __Vtask_tb_gb_boot__DOT__stub_byte__18__addr = 0;
    CData/*7:0*/ __Vtask_tb_gb_boot__DOT__stub_byte__18__v;
    __Vtask_tb_gb_boot__DOT__stub_byte__18__v = 0;
    VlWide<3>/*95:0*/ __Vtemp_2;
    // Body
    co_await vlSelf->__VdlySched.delay(0x3e8ULL, nullptr, 
                                       "tb/tb_gb_boot.v", 
                                       89);
    if (VL_UNLIKELY(VL_VALUEPLUSARGS_INW(1024, std::string{"cart=%s"}, 
                                         vlSelf->tb_gb_boot__DOT__cart_name))) {
        VL_READMEM_N(true, 8, 32768, 0, VL_CVT_PACK_STR_NW(32, vlSelf->tb_gb_boot__DOT__cart_name)
                     ,  &(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_rom)
                     , 0, ~0ULL);
    }
    if (VL_TESTPLUSARGS_I(std::string{"stub"})) {
        vlSelf->tb_gb_boot__DOT__use_stub = 1U;
        vlSelf->tb_gb_boot__DOT__n = 0U;
        while (VL_GTS_III(32, 0x100U, vlSelf->tb_gb_boot__DOT__n)) {
            __Vtask_tb_gb_boot__DOT__stub_byte__0__v = 0U;
            __Vtask_tb_gb_boot__DOT__stub_byte__0__addr 
                = (0xffU & vlSelf->tb_gb_boot__DOT__n);
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__0__addr] 
                = __Vtask_tb_gb_boot__DOT__stub_byte__0__v;
            vlSelf->tb_gb_boot__DOT__n = ((IData)(1U) 
                                          + vlSelf->tb_gb_boot__DOT__n);
        }
        __Vtask_tb_gb_boot__DOT__stub_byte__1__v = 0x31U;
        __Vtask_tb_gb_boot__DOT__stub_byte__1__addr = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__1__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__1__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__2__v = 0xfeU;
        __Vtask_tb_gb_boot__DOT__stub_byte__2__addr = 1U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__2__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__2__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__3__v = 0xffU;
        __Vtask_tb_gb_boot__DOT__stub_byte__3__addr = 2U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__3__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__3__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__4__v = 0x3eU;
        __Vtask_tb_gb_boot__DOT__stub_byte__4__addr = 3U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__4__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__4__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__5__v = 0xfcU;
        __Vtask_tb_gb_boot__DOT__stub_byte__5__addr = 4U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__5__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__5__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__6__v = 0xe0U;
        __Vtask_tb_gb_boot__DOT__stub_byte__6__addr = 5U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__6__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__6__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__7__v = 0x47U;
        __Vtask_tb_gb_boot__DOT__stub_byte__7__addr = 6U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__7__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__7__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__8__v = 0x3eU;
        __Vtask_tb_gb_boot__DOT__stub_byte__8__addr = 7U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__8__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__8__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__9__v = 0x91U;
        __Vtask_tb_gb_boot__DOT__stub_byte__9__addr = 8U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__9__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__9__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__10__v = 0xe0U;
        __Vtask_tb_gb_boot__DOT__stub_byte__10__addr = 9U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__10__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__10__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__11__v = 0x40U;
        __Vtask_tb_gb_boot__DOT__stub_byte__11__addr = 0xaU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__11__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__11__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__12__v = 0xc3U;
        __Vtask_tb_gb_boot__DOT__stub_byte__12__addr = 0xbU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__12__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__12__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__13__v = 0xfcU;
        __Vtask_tb_gb_boot__DOT__stub_byte__13__addr = 0xcU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__13__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__13__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__14__v = 0U;
        __Vtask_tb_gb_boot__DOT__stub_byte__14__addr = 0xdU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__14__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__14__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__15__v = 0x3eU;
        __Vtask_tb_gb_boot__DOT__stub_byte__15__addr = 0xfcU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__15__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__15__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__16__v = 1U;
        __Vtask_tb_gb_boot__DOT__stub_byte__16__addr = 0xfdU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__16__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__16__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__17__v = 0xe0U;
        __Vtask_tb_gb_boot__DOT__stub_byte__17__addr = 0xfeU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__17__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__17__v;
        __Vtask_tb_gb_boot__DOT__stub_byte__18__v = 0x50U;
        __Vtask_tb_gb_boot__DOT__stub_byte__18__addr = 0xffU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom[__Vtask_tb_gb_boot__DOT__stub_byte__18__addr] 
            = __Vtask_tb_gb_boot__DOT__stub_byte__18__v;
    } else if (VL_UNLIKELY(VL_VALUEPLUSARGS_INW(1024, 
                                                std::string{"boot=%s"}, 
                                                vlSelf->tb_gb_boot__DOT__boot_name))) {
        VL_READMEM_N(true, 8, 256, 0, VL_CVT_PACK_STR_NW(32, vlSelf->tb_gb_boot__DOT__boot_name)
                     ,  &(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom)
                     , 0, ~0ULL);
    }
    __Vtemp_2[0U] = 0x733d2564U;
    __Vtemp_2[1U] = 0x72616d65U;
    __Vtemp_2[2U] = 0x66U;
    if (VL_VALUEPLUSARGS_INI(32, VL_CVT_PACK_STR_NW(3, __Vtemp_2), 
                             vlSelf->tb_gb_boot__DOT__max_frames)) {
    }
    if (VL_VALUEPLUSARGS_INI(32, std::string{"every=%d"}, 
                             vlSelf->tb_gb_boot__DOT__dump_every)) {
    }
    if (VL_VALUEPLUSARGS_INI(32, std::string{"after=%d"}, 
                             vlSelf->tb_gb_boot__DOT__after_boot)) {
    }
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__1(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    co_await vlSelf->__VdlySched.delay(0x3e8ULL, nullptr, 
                                       "tb/tb_gb_boot.v", 
                                       146);
    if (VL_TESTPLUSARGS_I(std::string{"mooneye"})) {
        vlSelf->tb_gb_boot__DOT__mooneye = 1U;
    }
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__2(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__2\n"); );
    // Body
    co_await vlSelf->__VdlySched.delay(0x3e8ULL, nullptr, 
                                       "tb/tb_gb_boot.v", 
                                       167);
    if (VL_TESTPLUSARGS_I(std::string{"trace3"})) {
        vlSelf->tb_gb_boot__DOT__trace3 = 1U;
    }
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__3(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__3\n"); );
    // Body
    co_await vlSelf->__VdlySched.delay(0x3e8ULL, nullptr, 
                                       "tb/tb_gb_boot.v", 
                                       179);
    if (VL_TESTPLUSARGS_I(std::string{"trace"})) {
        vlSelf->tb_gb_boot__DOT__trace = 1U;
    }
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__4(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__4\n"); );
    // Body
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    co_await vlSelf->__VtrigSched_h1f51f8f2__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge tb_gb_boot.clk)", 
                                                       "tb/tb_gb_boot.v", 
                                                       226);
    vlSelf->tb_gb_boot__DOT__rst = 0U;
}

VL_INLINE_OPT VlCoroutine Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__5(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_initial__TOP__Vtiming__5\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0x1388ULL, 
                                           nullptr, 
                                           "tb/tb_gb_boot.v", 
                                           55);
        vlSelf->tb_gb_boot__DOT__clk = (1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__clk)));
    }
}

void Vtb_gb_boot___024root___eval_act(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___eval_act\n"); );
}

extern const VlWide<8>/*255:0*/ Vtb_gb_boot__ConstPool__CONST_hb095e1a3_0;

VL_INLINE_OPT void Vtb_gb_boot___024root___nba_sequent__TOP__0(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___nba_sequent__TOP__0\n"); );
    // Init
    VlWide<8>/*255:0*/ __Vtask_tb_gb_boot__DOT__dump__20__name;
    VL_ZERO_W(256, __Vtask_tb_gb_boot__DOT__dump__20__name);
    SData/*14:0*/ __Vdlyvdim0__tb_gb_boot__DOT__fb__v0;
    __Vdlyvdim0__tb_gb_boot__DOT__fb__v0 = 0;
    CData/*1:0*/ __Vdlyvval__tb_gb_boot__DOT__fb__v0;
    __Vdlyvval__tb_gb_boot__DOT__fb__v0 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__fb__v0;
    __Vdlyvset__tb_gb_boot__DOT__fb__v0 = 0;
    SData/*8:0*/ __Vdly__tb_gb_boot__DOT__m3_start;
    __Vdly__tb_gb_boot__DOT__m3_start = 0;
    QData/*47:0*/ __Vdly__tb_gb_boot__DOT__last6;
    __Vdly__tb_gb_boot__DOT__last6 = 0;
    SData/*12:0*/ __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0;
    __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0;
    __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 = 0;
    CData/*6:0*/ __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0;
    __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0;
    __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 = 0;
    SData/*12:0*/ __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0;
    __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0;
    __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0;
    __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0;
    __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 = 0;
    CData/*7:0*/ __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1;
    __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 = 0;
    CData/*7:0*/ __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1;
    __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 = 0;
    CData/*0:0*/ __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 = 0;
    // Body
    __Vdlyvset__tb_gb_boot__DOT__fb__v0 = 0U;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 = 0U;
    __Vdly__tb_gb_boot__DOT__m3_start = vlSelf->tb_gb_boot__DOT__m3_start;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 = 0U;
    __Vdly__tb_gb_boot__DOT__last6 = vlSelf->tb_gb_boot__DOT__last6;
    if (VL_UNLIKELY(((((IData)(vlSelf->tb_gb_boot__DOT__trace) 
                       & (~ (IData)(vlSelf->tb_gb_boot__DOT__rst))) 
                      & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m)) 
                     & ((((((0xff41U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                            | (0xff44U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) 
                           | (0xff0fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) 
                          | (0xff40U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) 
                         | (0xff45U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) 
                        | (0xff04U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))))) {
        VL_WRITEF("t=%0t %s %x addr=%x data=%x ly=%0# dot=%0# mode=%0#\n",
                  64,VL_TIME_UNITED_Q(1000),-9,8,((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)
                                                   ? 0x57U
                                                   : 0x52U),
                  8,((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)
                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)
                      : (IData)(vlSelf->tb_gb_boot__DOT__din)),
                  16,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr),
                  8,vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out,
                  8,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y),
                  9,vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter,
                  2,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode));
    }
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 = 0U;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 = 0U;
    __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 = 0U;
    vlSelf->__Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
    if (VL_UNLIKELY(((((IData)(vlSelf->tb_gb_boot__DOT__mooneye) 
                       & (~ (IData)(vlSelf->tb_gb_boot__DOT__rst))) 
                      & (0x40U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                     & (2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))))) {
        if (VL_UNLIKELY((0x305080d1522ULL == (((QData)((IData)(
                                                               (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                                 << 0x18U) 
                                                                | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c) 
                                                                    << 0x10U) 
                                                                   | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                                       << 8U) 
                                                                      | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)))))) 
                                               << 0x10U) 
                                              | (QData)((IData)(
                                                                (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                                  << 8U) 
                                                                 | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)))))))) {
            VL_WRITEF("MOONEYE PASS at frame %0d\n",
                      32,vlSelf->tb_gb_boot__DOT__frame);
        } else if ((0x424242424242ULL == (((QData)((IData)(
                                                           (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                             << 0x18U) 
                                                            | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c) 
                                                                << 0x10U) 
                                                               | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                                   << 8U) 
                                                                  | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)))))) 
                                           << 0x10U) 
                                          | (QData)((IData)(
                                                            (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                              << 8U) 
                                                             | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l))))))) {
            VL_WRITEF("MOONEYE FAIL at frame %0d\n",
                      32,vlSelf->tb_gb_boot__DOT__frame);
        } else {
            VL_WRITEF("MOONEYE ODD regs %x %x %x %x %x %x at frame %0d\n",
                      8,vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b,
                      8,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c),
                      8,vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d,
                      8,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e),
                      8,vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h,
                      8,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l),
                      32,vlSelf->tb_gb_boot__DOT__frame);
        }
        vlSelf->tb_gb_boot__DOT__fd = VL_FOPEN_NN(VL_CVT_PACK_STR_NW(8, Vtb_gb_boot__ConstPool__CONST_hb095e1a3_0)
                                                  , 
                                                  std::string{"w"});
        ;
        VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"P2\n160 144\n3\n");
        vlSelf->tb_gb_boot__DOT__y = 0U;
        while (VL_GTS_III(32, 0x90U, vlSelf->tb_gb_boot__DOT__y)) {
            vlSelf->tb_gb_boot__DOT__x = 0U;
            while (VL_GTS_III(32, 0xa0U, vlSelf->tb_gb_boot__DOT__x)) {
                VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"%0# ",
                           32,((IData)(3U) - ((0x59ffU 
                                               >= (0x7fffU 
                                                   & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                      + vlSelf->tb_gb_boot__DOT__x)))
                                               ? vlSelf->tb_gb_boot__DOT__fb
                                              [(0x7fffU 
                                                & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                   + vlSelf->tb_gb_boot__DOT__x))]
                                               : 0U)));
                vlSelf->tb_gb_boot__DOT__x = ((IData)(1U) 
                                              + vlSelf->tb_gb_boot__DOT__x);
            }
            VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"\n");
            vlSelf->tb_gb_boot__DOT__y = ((IData)(1U) 
                                          + vlSelf->tb_gb_boot__DOT__y);
        }
        VL_FCLOSE_I(vlSelf->tb_gb_boot__DOT__fd); VL_FINISH_MT("tb/tb_gb_boot.v", 160, "");
    }
    if (VL_UNLIKELY((((~ (IData)(vlSelf->tb_gb_boot__DOT__rst)) 
                      & (IData)(vlSelf->tb_gb_boot__DOT__boot_d)) 
                     & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active))))) {
        vlSelf->tb_gb_boot__DOT__boot_frame = vlSelf->tb_gb_boot__DOT__frame;
        VL_WRITEF("boot rom unmapped at frame %0d, time %0t, sys_cnt %x\n",
                  32,vlSelf->tb_gb_boot__DOT__frame,
                  64,VL_TIME_UNITED_Q(1000),-9,16,(IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt));
    }
    if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__irq_vblank) 
         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb))) {
        vlSelf->tb_gb_boot__DOT__frame = ((IData)(1U) 
                                          + vlSelf->tb_gb_boot__DOT__frame);
        if (VL_UNLIKELY((0U == VL_MODDIVS_III(32, vlSelf->tb_gb_boot__DOT__frame, vlSelf->tb_gb_boot__DOT__dump_every)))) {
            VL_SFORMAT_X(256,vlSelf->tb_gb_boot__DOT__fname
                         ,"frames/frame_%0d.pgm",32,
                         vlSelf->tb_gb_boot__DOT__frame);
            __Vtask_tb_gb_boot__DOT__dump__20__name[0U] 
                = vlSelf->tb_gb_boot__DOT__fname[0U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[1U] 
                = vlSelf->tb_gb_boot__DOT__fname[1U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[2U] 
                = vlSelf->tb_gb_boot__DOT__fname[2U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[3U] 
                = vlSelf->tb_gb_boot__DOT__fname[3U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[4U] 
                = vlSelf->tb_gb_boot__DOT__fname[4U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[5U] 
                = vlSelf->tb_gb_boot__DOT__fname[5U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[6U] 
                = vlSelf->tb_gb_boot__DOT__fname[6U];
            __Vtask_tb_gb_boot__DOT__dump__20__name[7U] 
                = vlSelf->tb_gb_boot__DOT__fname[7U];
            vlSelf->tb_gb_boot__DOT__fd = VL_FOPEN_NN(
                                                      VL_CVT_PACK_STR_NW(8, __Vtask_tb_gb_boot__DOT__dump__20__name)
                                                      , 
                                                      std::string{"w"});
            ;
            VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"P2\n160 144\n3\n");
            vlSelf->tb_gb_boot__DOT__y = 0U;
            while (VL_GTS_III(32, 0x90U, vlSelf->tb_gb_boot__DOT__y)) {
                vlSelf->tb_gb_boot__DOT__x = 0U;
                while (VL_GTS_III(32, 0xa0U, vlSelf->tb_gb_boot__DOT__x)) {
                    VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"%0# ",
                               32,((IData)(3U) - ((0x59ffU 
                                                   >= 
                                                   (0x7fffU 
                                                    & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                       + vlSelf->tb_gb_boot__DOT__x)))
                                                   ? 
                                                  vlSelf->tb_gb_boot__DOT__fb
                                                  [
                                                  (0x7fffU 
                                                   & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                      + vlSelf->tb_gb_boot__DOT__x))]
                                                   : 0U)));
                    vlSelf->tb_gb_boot__DOT__x = ((IData)(1U) 
                                                  + vlSelf->tb_gb_boot__DOT__x);
                }
                VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"\n");
                vlSelf->tb_gb_boot__DOT__y = ((IData)(1U) 
                                              + vlSelf->tb_gb_boot__DOT__y);
            }
            VL_FCLOSE_I(vlSelf->tb_gb_boot__DOT__fd); }
        if (VL_UNLIKELY((VL_GTES_III(32, vlSelf->tb_gb_boot__DOT__frame, vlSelf->tb_gb_boot__DOT__max_frames) 
                         | (((~ (IData)(vlSelf->tb_gb_boot__DOT__use_stub)) 
                             & VL_LTES_III(32, 0U, vlSelf->tb_gb_boot__DOT__boot_frame)) 
                            & VL_GTES_III(32, vlSelf->tb_gb_boot__DOT__frame, 
                                          (vlSelf->tb_gb_boot__DOT__boot_frame 
                                           + vlSelf->tb_gb_boot__DOT__after_boot)))))) {
            vlSelf->tb_gb_boot__DOT__fd = VL_FOPEN_NN(
                                                      VL_CVT_PACK_STR_NW(8, Vtb_gb_boot__ConstPool__CONST_hb095e1a3_0)
                                                      , 
                                                      std::string{"w"});
            ;
            VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"P2\n160 144\n3\n");
            vlSelf->tb_gb_boot__DOT__y = 0U;
            while (VL_GTS_III(32, 0x90U, vlSelf->tb_gb_boot__DOT__y)) {
                vlSelf->tb_gb_boot__DOT__x = 0U;
                while (VL_GTS_III(32, 0xa0U, vlSelf->tb_gb_boot__DOT__x)) {
                    VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"%0# ",
                               32,((IData)(3U) - ((0x59ffU 
                                                   >= 
                                                   (0x7fffU 
                                                    & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                       + vlSelf->tb_gb_boot__DOT__x)))
                                                   ? 
                                                  vlSelf->tb_gb_boot__DOT__fb
                                                  [
                                                  (0x7fffU 
                                                   & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                      + vlSelf->tb_gb_boot__DOT__x))]
                                                   : 0U)));
                    vlSelf->tb_gb_boot__DOT__x = ((IData)(1U) 
                                                  + vlSelf->tb_gb_boot__DOT__x);
                }
                VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"\n");
                vlSelf->tb_gb_boot__DOT__y = ((IData)(1U) 
                                              + vlSelf->tb_gb_boot__DOT__y);
            }
            VL_FCLOSE_I(vlSelf->tb_gb_boot__DOT__fd); VL_WRITEF("stopping at frame %0d, boot handoff frame %0d, cpu at %x\n",
                                                                32,
                                                                vlSelf->tb_gb_boot__DOT__frame,
                                                                32,
                                                                vlSelf->tb_gb_boot__DOT__boot_frame,
                                                                16,
                                                                (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr));
            VL_FINISH_MT("tb/tb_gb_boot.v", 199, "");
        }
    }
    if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid) 
          & (0xa0U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt))) 
         & (0x90U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y)))) {
        vlSelf->tb_gb_boot__DOT____Vlvbound_hc55e2fae__0 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_shade;
        if ((0x59ffU >= (0x7fffU & (((IData)(0xa0U) 
                                     * (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y)) 
                                    + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt))))) {
            __Vdlyvval__tb_gb_boot__DOT__fb__v0 = vlSelf->tb_gb_boot__DOT____Vlvbound_hc55e2fae__0;
            __Vdlyvset__tb_gb_boot__DOT__fb__v0 = 1U;
            __Vdlyvdim0__tb_gb_boot__DOT__fb__v0 = 
                (0x7fffU & (((IData)(0xa0U) * (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y)) 
                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)));
        }
    }
    if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff) 
          & ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)) 
             & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we))) 
         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m))) {
        __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 = 1U;
        __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0 
            = (0x1fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr));
    }
    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        if (((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode)) 
             & (3U != (IData)(vlSelf->tb_gb_boot__DOT__prev_mode)))) {
            __Vdly__tb_gb_boot__DOT__m3_start = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter;
        }
        if (VL_UNLIKELY((((IData)(vlSelf->tb_gb_boot__DOT__trace3) 
                          & (3U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode))) 
                         & (3U == (IData)(vlSelf->tb_gb_boot__DOT__prev_mode))))) {
            VL_WRITEF("m3 ly=%0# start=%0# end=%0# len=%0#\n",
                      8,vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y,
                      9,(IData)(vlSelf->tb_gb_boot__DOT__m3_start),
                      9,vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter,
                      9,(0x1ffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter) 
                                   - (IData)(vlSelf->tb_gb_boot__DOT__m3_start))));
        }
        vlSelf->tb_gb_boot__DOT__prev_mode = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode;
    }
    if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram) 
          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_h93a773fe__0 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        if ((0x7eU >= (0x7fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
            __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT____Vlvbound_h93a773fe__0;
            __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 = 1U;
            __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0 
                = (0x7fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr));
        }
    }
    if ((((~ (IData)(vlSelf->tb_gb_boot__DOT__rst)) 
          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m)) 
         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we))) {
        if (VL_UNLIKELY(((0xff02U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                         & (0x81U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out))))) {
            VL_WRITEF("%c",8,vlSelf->tb_gb_boot__DOT__sb);
            Verilated::runFlushCallbacks();
            __Vdly__tb_gb_boot__DOT__last6 = ((0xffffffffff00ULL 
                                               & (vlSelf->tb_gb_boot__DOT__last6 
                                                  << 8U)) 
                                              | (QData)((IData)(vlSelf->tb_gb_boot__DOT__sb)));
            if (VL_UNLIKELY(((0x506173736564ULL == 
                              ((0xffffffffff00ULL & 
                                (vlSelf->tb_gb_boot__DOT__last6 
                                 << 8U)) | (QData)((IData)(vlSelf->tb_gb_boot__DOT__sb)))) 
                             | (0x4661696c6564ULL == 
                                ((0xffffffffff00ULL 
                                  & (vlSelf->tb_gb_boot__DOT__last6 
                                     << 8U)) | (QData)((IData)(vlSelf->tb_gb_boot__DOT__sb))))))) {
                VL_WRITEF("\nBLARGG done at frame %0d\n",
                          32,vlSelf->tb_gb_boot__DOT__frame);
                vlSelf->tb_gb_boot__DOT__fd = VL_FOPEN_NN(
                                                          VL_CVT_PACK_STR_NW(8, Vtb_gb_boot__ConstPool__CONST_hb095e1a3_0)
                                                          , 
                                                          std::string{"w"});
                ;
                VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"P2\n160 144\n3\n");
                vlSelf->tb_gb_boot__DOT__y = 0U;
                while (VL_GTS_III(32, 0x90U, vlSelf->tb_gb_boot__DOT__y)) {
                    vlSelf->tb_gb_boot__DOT__x = 0U;
                    while (VL_GTS_III(32, 0xa0U, vlSelf->tb_gb_boot__DOT__x)) {
                        VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"%0# ",
                                   32,((IData)(3U) 
                                       - ((0x59ffU 
                                           >= (0x7fffU 
                                               & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                                  + vlSelf->tb_gb_boot__DOT__x)))
                                           ? vlSelf->tb_gb_boot__DOT__fb
                                          [(0x7fffU 
                                            & (VL_MULS_III(32, (IData)(0xa0U), vlSelf->tb_gb_boot__DOT__y) 
                                               + vlSelf->tb_gb_boot__DOT__x))]
                                           : 0U)));
                        vlSelf->tb_gb_boot__DOT__x 
                            = ((IData)(1U) + vlSelf->tb_gb_boot__DOT__x);
                    }
                    VL_FWRITEF(vlSelf->tb_gb_boot__DOT__fd,"\n");
                    vlSelf->tb_gb_boot__DOT__y = ((IData)(1U) 
                                                  + vlSelf->tb_gb_boot__DOT__y);
                }
                VL_FCLOSE_I(vlSelf->tb_gb_boot__DOT__fd); VL_FINISH_MT("tb/tb_gb_boot.v", 219, "");
            }
        }
        if ((0xff01U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
            vlSelf->tb_gb_boot__DOT__sb = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        }
    }
    if (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff) 
           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m)) 
         & (~ (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                >> 7U) & (3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)))))) {
        __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 = 1U;
        __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0 
            = (0x1fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr));
    }
    if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)) 
         & (0xa0U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx)))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h5630b187__0 
            = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi))
                ? ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                                 >> 5U))) ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__wram_data_out)
                    : 0xffU) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cart_data_out));
        if ((0x9fU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx))) {
            __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_h5630b187__0;
            __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 = 1U;
            __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx;
        }
    } else if (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam) 
                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m)) 
                & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run) 
                      | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                          >> 7U) & ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)) 
                                    | ((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__stat_mode_n)) 
                                       & (2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n))))))))) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_ha0aefced__0 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
        if ((0x9fU >= (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
            __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT____Vlvbound_ha0aefced__0;
            __Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 = 1U;
            __Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1 
                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr));
        }
    }
    vlSelf->__Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem
        [(0x1fffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling)
                      ? ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt))
                          ? ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr))
                          : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr))
                      : ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))
                          ? ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__data_lo))
                          : ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))
                              ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__data_lo)
                              : (((1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win)
                                          ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                                             >> 6U)
                                          : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                                             >> 3U)))
                                   ? 0x1c00U : 0x1800U) 
                                 + ((0x3e0U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row) 
                                               << 2U)) 
                                    + (0x1fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win)
                                                 ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x)
                                                 : 
                                                (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx) 
                                                  >> 3U) 
                                                 + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x))))))))))];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem
        [(0x1fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr))];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_q 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_rom
        [(0x7fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr))];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_q 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_rom
        [(0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr))];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__rdata 
        = ((0x7eU >= (0x7fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))
            ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem
           [(0x7fU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))]
            : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__rdata 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem
        [(0x1fffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__rdata 
        = ((0x9fU >= (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))
            ? vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem
           [(0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))]
            : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_sel_q 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active) 
           & (0U == (0xff00U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr))));
    vlSelf->tb_gb_boot__DOT__m3_start = __Vdly__tb_gb_boot__DOT__m3_start;
    vlSelf->tb_gb_boot__DOT__last6 = __Vdly__tb_gb_boot__DOT__last6;
    if (__Vdlyvset__tb_gb_boot__DOT__fb__v0) {
        vlSelf->tb_gb_boot__DOT__fb[__Vdlyvdim0__tb_gb_boot__DOT__fb__v0] 
            = __Vdlyvval__tb_gb_boot__DOT__fb__v0;
    }
    if (__Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem[__Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0] 
            = __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_wram__DOT__mem__v0;
    }
    if (__Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem[__Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0] 
            = __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_hram__DOT__mem__v0;
    }
    if (__Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem[__Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0] 
            = __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__mem__v0;
    }
    if (__Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem[__Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0] 
            = __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v0;
    }
    if (__Vdlyvset__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem[__Vdlyvdim0__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1] 
            = __Vdlyvval__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_oam__DOT__mem__v1;
    }
    vlSelf->tb_gb_boot__DOT__boot_d = ((IData)(vlSelf->tb_gb_boot__DOT__rst) 
                                       | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active));
}

extern const VlWide<10>/*319:0*/ Vtb_gb_boot__ConstPool__CONST_hab76c978_0;

VL_INLINE_OPT void Vtb_gb_boot___024root___nba_sequent__TOP__1(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___nba_sequent__TOP__1\n"); );
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
    CData/*0:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel = 0;
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
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id = 0;
    SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id = 0;
    SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id = 0;
    SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id = 0;
    SData/*15:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id = 0;
    CData/*0:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc = 0;
    CData/*0:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id = 0;
    CData/*0:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__Vfuncout;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__Vfuncout = 0;
    CData/*7:0*/ __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v;
    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v = 0;
    CData/*1:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 0;
    CData/*2:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = 0;
    CData/*2:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 0;
    CData/*5:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = 0;
    CData/*1:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir = 0;
    CData/*1:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt = 0;
    CData/*6:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count = 0;
    VlWide<10>/*319:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list;
    VL_ZERO_W(320, __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list);
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc = 0;
    CData/*2:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0;
    CData/*4:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x = 0;
    SData/*15:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy = 0;
    CData/*2:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard = 0;
    CData/*7:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr = 0;
    CData/*0:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = 0;
    CData/*3:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt = 0;
    IData/*31:0*/ __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj = 0;
    // Body
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U] 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U];
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt;
    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending 
        = ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__rst))) 
           && (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_next));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_r 
        = ((IData)(vlSelf->tb_gb_boot__DOT__rst) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__coincidence_next));
    if (vlSelf->tb_gb_boot__DOT__rst) {
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[0U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[1U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[2U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[3U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[4U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[5U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[6U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[7U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[8U];
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U] 
            = Vtb_gb_boot__ConstPool__CONST_hab76c978_0[9U];
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__src_reg = 0xffU;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_r = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_dir = 1U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_btn = 1U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0 = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1 = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d4 = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt = 0U;
    } else {
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count 
                = (3U & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count)));
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count = 0U;
            } else if ((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt 
                    = (0x7fU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt)));
                if ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt)))) {
                    if ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count = 0U;
                    } else {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
                    }
                    if ((((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)) 
                          & ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__diff) 
                                 >> 8U)) & ((0xffU 
                                             & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__diff)) 
                                            < ((4U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                                ? 0x10U
                                                : 8U)))) 
                         & (0xaU > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos = 0U;
                        if (((0U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((1U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((2U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((3U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((4U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((5U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((6U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((7U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((8U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        if (((9U < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)) 
                             & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U] 
                                          >> 8U)) <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__ob_x)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos 
                                = (0xfU & ((IData)(1U) 
                                           + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos)));
                        }
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[0U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[1U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[2U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[3U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[4U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[5U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[6U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[7U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[8U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U];
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[9U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U];
                        if ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[0U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        }
                        if ((1U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[1U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((1U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[1U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[2U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((2U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[2U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[3U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((3U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[3U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((4U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[4U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((4U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[4U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((5U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[5U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((5U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[5U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[6U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((6U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[6U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((7U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[7U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((7U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[7U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((8U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[8U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((8U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[8U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        if ((9U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__oam_entry_data;
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[9U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__0;
                        } else if ((9U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__pos))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U];
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[9U] 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT____Vlvbound_h1965e287__1;
                        }
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[0U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[1U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[2U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[3U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[4U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[5U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[6U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[7U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[8U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U] 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__nl[9U];
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count 
                            = (0xfU & ((IData)(1U) 
                                       + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__base_cnt)));
                    }
                }
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt = 0U;
            }
            if ((1U & ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                           >> 7U)) | (0x90U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y))))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond = 0U;
            } else {
                if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done) 
                     & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc 
                        = (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc)));
                }
                if (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
                       >> 7U) & ((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r)) 
                                 | ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r) 
                                    & (0x50U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter))))) 
                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y) 
                        == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy)))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__ycond = 1U;
                }
            }
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_r 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__stat_line_n;
            if ((3U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat 
                    = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx));
            }
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d4 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3;
        }
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_scan__DOT__cnt;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc 
            = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_next;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tma_next;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tac_next;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n;
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run) {
                if ((0x9fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx = 0U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx 
                        = (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx)));
                }
            }
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend) {
                if ((1U >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx = 0U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__new_hi;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend = 0U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt 
                        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt) 
                                   - (IData)(1U)));
                }
            }
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__wr_start) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__src_reg 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt = 1U;
            }
        }
        if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad)) 
             & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_dir 
                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                         >> 4U));
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_joypad__DOT__sel_btn 
                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                         >> 5U));
        }
        if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg) 
              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
             & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m))) {
            if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                          >> 3U)))) {
                if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__bgp 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                    if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                                  >> 1U)))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                }
                if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                              >> 2U)))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                        if ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                    if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                                  >> 1U)))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lyc_ie 
                                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                                         >> 6U));
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode0_ie 
                                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                                         >> 3U));
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode1_ie 
                                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                                         >> 4U));
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__mode2_ie 
                                = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out) 
                                         >> 5U));
                        }
                    }
                }
            }
            if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                              >> 2U)))) {
                    if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                                  >> 1U)))) {
                        if ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp0 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__obp1 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                }
            }
        }
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__cnt_next;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pend;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__pcnt;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r 
        = ((IData)(vlSelf->tb_gb_boot__DOT__rst) || (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n));
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active = 1U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy = 1U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3 = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter = 4U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc = 0U;
    } else {
        if (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable)) 
              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
             & (0U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out)))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_active = 0U;
        }
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
            if ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling) {
                    if ((1U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
                    }
                    if ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr 
                            = (0xfU & ((IData)(1U) 
                                       + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj_merged;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = 0U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt 
                            = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt) 
                                       - (IData)(1U)));
                    }
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo = 0U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x = 0U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard 
                        = ((7U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx))
                            ? (7U & ((IData)(7U) - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx)))
                            : 0U);
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt 
                        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__penalty) 
                                   - (IData)(2U)));
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid = 1U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t 
                        = ((0U == (0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                            >> 8U)))
                            ? 0x7fU : (0x7fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos) 
                                                >> 3U)));
                    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win 
                        = ((0U != (0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                            >> 8U))) 
                           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win));
                } else {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo 
                            = (0xffffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__row16));
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count = 8U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo 
                            = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok)
                                           ? VL_SHIFTR_III(16,16,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo), 2U)
                                           : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo)));
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop;
                    }
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok) {
                        if ((0U != (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard 
                                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard) 
                                         - (IData)(1U)));
                        } else if ((0xa0U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt 
                                = (0xffU & ((IData)(1U) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
                                = (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
                                   >> 4U);
                        }
                    }
                    if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
                            } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x 
                                    = (0x1fU & ((IData)(1U) 
                                                + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x)));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
                            }
                        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy = 0U;
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
                            } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__push_ok) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x 
                                    = (0x1fU & ((IData)(1U) 
                                                + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x)));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
                            } else {
                                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r 
                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 6U;
                            }
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 5U;
                        }
                    } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 4U;
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 3U;
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 2U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 1U;
                    }
                }
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__tile_idx = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__lo_r = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard 
                    = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_valid = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_t = 0U;
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__last_win = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj = 0U;
            }
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d3 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2;
        }
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n;
        if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg) 
              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
             & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m))) {
            if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                              >> 2U)))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                        if ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wy 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                }
            }
            if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                          >> 3U)))) {
                if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                              >> 2U)))) {
                    if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                                  >> 1U)))) {
                        if ((1U & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                        }
                    }
                }
            }
        }
    }
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fetch_x;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__dummy;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stall_cnt;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__stalling;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color 
        = ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
            ? (3U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fifo))
            : 0U);
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__new_hi = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head = 0U;
    } else {
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__wr_start) {
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__Vfuncout 
                    = ((7U == (7U & ((IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v) 
                                     >> 5U))) ? (0xc0U 
                                                 | (0x1fU 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v)))
                        : (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__v));
                vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__new_hi 
                    = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__map_hi__85__Vfuncout;
            }
        }
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                = ((0x13fU >= (0x1ffU & VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U)))
                    ? (((0U == (0x1fU & VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U)))
                         ? 0U : (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[
                                 (((IData)(0x1fU) + 
                                   (0x1ffU & VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U))) 
                                  >> 5U)] << ((IData)(0x20U) 
                                              - (0x1fU 
                                                 & VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U))))) 
                       | (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[
                          (0xfU & (VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U) 
                                   >> 5U))] >> (0x1fU 
                                                & VL_SHIFTL_III(9,32,32, (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr_nx), 5U))))
                    : 0U);
        }
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[0U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[1U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[2U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[3U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[4U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[5U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[6U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[7U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[8U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U] 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_list[9U];
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y = ((0x80U 
                                                   & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                                                   ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r)
                                                   : 0U);
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__y_row 
        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win)
                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__wlc)
                     : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y) 
                        + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scy))));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj 
        = ((~ ((vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj 
                >> 3U) & (0U != (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__bg_color)))) 
           & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
               >> 1U) & (0U != (3U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__shift_in 
        = ((8U > (0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                           >> 8U))) ? (0x1fU & ((IData)(8U) 
                                                - (7U 
                                                   & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                      >> 8U))))
            : 0U);
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0 
        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_y) 
                   - (0xffU & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)));
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx = 0U;
    } else if ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg) 
                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we)) 
                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m))) {
        if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                      >> 3U)))) {
            if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__scx 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                    }
                }
            }
        }
        if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
            if ((1U & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr) 
                          >> 2U)))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out;
                    }
                }
            }
        }
    }
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw 
        = ((7U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx))
            ? 0U : (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__wx) 
                             - (IData)(7U))));
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2 = 0U;
    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d2 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1;
    }
    if (vlSelf->tb_gb_boot__DOT__rst) {
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp = 0xfffeU;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
    } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
        if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
        } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                    if ((1U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt 
                            = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt) 
                                     - (IData)(1U)));
                    }
                }
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                    = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                    = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op 
                    = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))
                        ? ((0x40U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))
                            ? 0x30U : 0x2fU) : ((0x40U 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))
                                                 ? 0x2eU
                                                 : 0x2dU));
                if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir)))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                }
            }
        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir 
                        = vlSelf->tb_gb_boot__DOT__din;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xaU;
                }
            } else {
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
            }
        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp) 
                     & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done)))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                    >> 8U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            }
        } else {
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out 
                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data));
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
        }
    } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                        if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data 
                                = vlSelf->tb_gb_boot__DOT__din;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                        } else {
                            if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                            = vlSelf->tb_gb_boot__DOT__din;
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                        = vlSelf->tb_gb_boot__DOT__din;
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                        = vlSelf->tb_gb_boot__DOT__din;
                                }
                            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                        = vlSelf->tb_gb_boot__DOT__din;
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                        = vlSelf->tb_gb_boot__DOT__din;
                                }
                            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                    = vlSelf->tb_gb_boot__DOT__din;
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                    = vlSelf->tb_gb_boot__DOT__din;
                            }
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        }
                    }
                } else {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
                }
            } else if ((0U != ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r) 
                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
            }
        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                            = (0xffffU & ((IData)(1U) 
                                          + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                            = ((0xffU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr)) 
                               | ((IData)(vlSelf->tb_gb_boot__DOT__din) 
                                  << 8U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                    }
                } else {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
                }
            } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                        = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                        = ((0xff00U & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr)) 
                           | (IData)(vlSelf->tb_gb_boot__DOT__din));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 1U;
                }
            } else {
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
            }
        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                    = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                  - (IData)(1U)));
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 0U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch = 1U;
                }
            }
        } else {
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                              - (IData)(1U)));
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_data_out 
                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch)
                             ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr)
                             : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr) 
                                >> 8U)));
            vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
            if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch) 
                 & (0x10U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op)))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0x40U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 1U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 1U;
                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0x48U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 2U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 1U;
                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0x50U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 4U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 1U;
                } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0x58U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 8U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 1U;
                } else if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0x60U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_wire = 0x10U;
                    vlSelf->tb_gb_boot__DOT__dut__DOT__if_clear_we_wire = 1U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr = 0U;
                }
            }
        }
    } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = (0xffffU & ((IData)(1U) 
                                          + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
                        if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (((IData)(vlSelf->tb_gb_boot__DOT__din) 
                                    << 8U) | (0xffU 
                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                                = (0xffffU & ((IData)(1U) 
                                              + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 4U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (((IData)(vlSelf->tb_gb_boot__DOT__din) 
                                    << 8U) | (0xffU 
                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
                        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (((IData)(vlSelf->tb_gb_boot__DOT__din) 
                                    << 8U) | (0xffU 
                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                = VL_EXTEND_II(16,8, 
                                               ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__24__Vfuncout)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                        }
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn 
                            = ((0xffU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn)) 
                               | ((IData)(vlSelf->tb_gb_boot__DOT__din) 
                                  << 8U));
                    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = (0xffffU & ((IData)(1U) 
                                          + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn 
                            = ((0xff00U & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn)) 
                               | (IData)(vlSelf->tb_gb_boot__DOT__din));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = (0xffffU & ((IData)(1U) 
                                          + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n 
                            = vlSelf->tb_gb_boot__DOT__din;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
                        if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (0xffffU & ((IData)(0xff00U) 
                                              + (IData)(vlSelf->tb_gb_boot__DOT__din)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
                        } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                = VL_EXTEND_II(16,8, 
                                               ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__25__Vfuncout)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (0xffffU & ((IData)(0xff00U) 
                                              + (IData)(vlSelf->tb_gb_boot__DOT__din)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
                        }
                    }
                }
            } else {
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
                vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
            }
        } else if ((0x20U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    } else if (((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime)) 
                                & (0U != ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r) 
                                          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r))))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 6U;
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                        = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                      | ((IData)(1U) 
                                         << (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                   >> 3U)))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                } else {
                    if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                    = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                | ((IData)(1U) 
                                                   << 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))));
                            }
                        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            | ((IData)(1U) 
                                               << (7U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                      >> 3U)))));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            | ((IData)(1U) 
                                               << (7U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                      >> 3U)))));
                        }
                    } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            | ((IData)(1U) 
                                               << (7U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                      >> 3U)))));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            | ((IData)(1U) 
                                               << (7U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                      >> 3U)))));
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                            = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                        | ((IData)(1U) 
                                           << (7U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                >> 3U)))));
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                            = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                        | ((IData)(1U) 
                                           << (7U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                >> 3U)))));
                    }
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                       & (~ ((IData)(1U) 
                                             << (7U 
                                                 & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                    >> 3U)))));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                            } else {
                                if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   & (~ 
                                                      ((IData)(1U) 
                                                       << 
                                                       (7U 
                                                        & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                           >> 3U)))));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               & (~ 
                                                  ((IData)(1U) 
                                                   << 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               & (~ 
                                                  ((IData)(1U) 
                                                   << 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))));
                                    }
                                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               & (~ 
                                                  ((IData)(1U) 
                                                   << 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               & (~ 
                                                  ((IData)(1U) 
                                                   << 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                           & (~ ((IData)(1U) 
                                                 << 
                                                 (7U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                     >> 3U)))));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                           & (~ ((IData)(1U) 
                                                 << 
                                                 (7U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                     >> 3U)))));
                                }
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                            }
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                   | (0x80U & ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 
                                                   (7U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir) 
                                                       >> 3U)))) 
                                               << 7U)));
                            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                            }
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = (0x20U | (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)));
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        if ((0x20U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                            if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                                if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                           | (0x10U 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 4U)));
                                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                << 8U) 
                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                            = (0x7fU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  >> 1U));
                                    } else if ((4U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            if ((1U 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                    = 
                                                    (0x7fU 
                                                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                        >> 1U));
                                            }
                                        } else if (
                                                   (1U 
                                                    & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                                = (0x7fU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      >> 1U));
                                        } else {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                                = (0x7fU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      >> 1U));
                                        }
                                    } else if ((2U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                                = (0x7fU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      >> 1U));
                                        } else {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                                = (0x7fU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      >> 1U));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                            = (0x7fU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  >> 1U));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                            = (0x7fU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  >> 1U));
                                    }
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = ((0x3fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                           | ((0U == 
                                               (0x7fU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 1U))) 
                                              << 7U));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = (0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = (0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                << 8U) 
                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                            = ((0xf0U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 4U)) 
                                               | (0xfU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 4U)));
                                    } else if ((4U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            if ((1U 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                    = 
                                                    ((0xf0U 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         << 4U)) 
                                                     | (0xfU 
                                                        & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                           >> 4U)));
                                            }
                                        } else if (
                                                   (1U 
                                                    & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                                = (
                                                   (0xf0U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                       << 4U)) 
                                                   | (0xfU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 4U)));
                                        } else {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                                = (
                                                   (0xf0U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                       << 4U)) 
                                                   | (0xfU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 4U)));
                                        }
                                    } else if ((2U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                                = (
                                                   (0xf0U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                       << 4U)) 
                                                   | (0xfU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 4U)));
                                        } else {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                                = (
                                                   (0xf0U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                       << 4U)) 
                                                   | (0xfU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 4U)));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                            = ((0xf0U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 4U)) 
                                               | (0xfU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 4U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                            = ((0xf0U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 4U)) 
                                               | (0xfU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 4U)));
                                    }
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                           | ((0U == 
                                               ((0xf0U 
                                                 & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                    << 4U)) 
                                                | (0xfU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      >> 4U)))) 
                                              << 7U));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                        = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                                }
                            } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 4U)));
                                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                            << 8U) 
                                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                        = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                = (
                                                   (0x80U 
                                                    & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                                   | (0x7fU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 1U)));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                            = ((0x80U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                            = ((0x80U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    }
                                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                            = ((0x80U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                            = ((0x80U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                        = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                        = ((0x80U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                }
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | ((0U == ((0x80U 
                                                   & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand)) 
                                                  | (0x7fU 
                                                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                        >> 1U)))) 
                                          << 7U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 3U)));
                                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                            << 8U) 
                                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                        = (0xfeU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            << 1U));
                                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                = (0xfeU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      << 1U));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                            = (0xfeU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 1U));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                            = (0xfeU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 1U));
                                    }
                                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                            = (0xfeU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 1U));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                            = (0xfeU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 1U));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                        = (0xfeU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            << 1U));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                        = (0xfeU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                            << 1U));
                                }
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | ((0U == (0xfeU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     << 1U))) 
                                          << 7U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                            }
                        } else if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                            if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 4U)));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | ((0U == ((0x80U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                      << 3U)) 
                                                  | (0x7fU 
                                                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                        >> 1U)))) 
                                          << 7U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                            << 8U) 
                                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                             << 3U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                = (
                                                   (0x80U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       << 3U)) 
                                                   | (0x7fU 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                         >> 1U)));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                            = ((0x80U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   << 3U)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                            = ((0x80U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   << 3U)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    }
                                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                            = ((0x80U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   << 3U)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                            = ((0x80U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   << 3U)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                             << 3U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                             << 3U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                }
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 3U)));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                       | ((0U == ((0xfeU 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                      << 1U)) 
                                                  | (1U 
                                                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                        >> 4U)))) 
                                          << 7U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                    = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                            << 8U) 
                                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                               >> 4U)));
                                } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                                = (
                                                   (0xfeU 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                       << 1U)) 
                                                   | (1U 
                                                      & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                         >> 4U)));
                                        }
                                    } else if ((1U 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                            = ((0xfeU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 1U)) 
                                               | (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                     >> 4U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                            = ((0xfeU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 1U)) 
                                               | (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                     >> 4U)));
                                    }
                                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                            = ((0xfeU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 1U)) 
                                               | (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                     >> 4U)));
                                    } else {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                            = ((0xfeU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 1U)) 
                                               | (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                     >> 4U)));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                               >> 4U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                               >> 4U)));
                                }
                            }
                        } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                   | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               << 4U)));
                            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                    = ((0x80U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 7U)) 
                                       | (0x7fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 1U)));
                            } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                            = ((0x80U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 7U)) 
                                               | (0x7fU 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 1U)));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 7U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 7U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                }
                            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 7U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                        = ((0x80U & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 7U)) 
                                           | (0x7fU 
                                              & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 >> 1U)));
                                }
                            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                    = ((0x80U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 7U)) 
                                       | (0x7fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 1U)));
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                    = ((0x80U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 7U)) 
                                       | (0x7fU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   >> 1U)));
                            }
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                   | ((0U == ((0x80U 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 7U)) 
                                              | (0x7fU 
                                                 & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                    >> 1U)))) 
                                      << 7U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                   | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               >> 3U)));
                            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                    = ((0xfeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 1U)) 
                                       | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                >> 7U)));
                            } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                            = ((0xfeU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                   << 1U)) 
                                               | (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                     >> 7U)));
                                    }
                                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               >> 7U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               >> 7U)));
                                }
                            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               >> 7U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                        = ((0xfeU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                             << 1U)) 
                                           | (1U & 
                                              ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                               >> 7U)));
                                }
                            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                    = ((0xfeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 1U)) 
                                       | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                >> 7U)));
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                    = ((0xfeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                 << 1U)) 
                                       | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                >> 7U)));
                            }
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                                   | ((0U == ((0xfeU 
                                               & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                  << 1U)) 
                                              | (1U 
                                                 & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_operand) 
                                                    >> 7U)))) 
                                      << 7U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                        }
                        if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        }
                    } else {
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction = 0U;
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_c 
                            = (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                     >> 4U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        if ((1U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                    >> 5U) | ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 6U)) 
                                              & (9U 
                                                 < 
                                                 (0xfU 
                                                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a))))))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction 
                                = (0xffU & ((IData)(6U) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction)));
                        }
                        if ((1U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                    >> 4U) | ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 6U)) 
                                              & (0x99U 
                                                 < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)))))) {
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction 
                                = (0xffU & ((IData)(0x60U) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction)));
                            vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_c = 1U;
                        }
                        vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_a 
                            = (0xffU & ((0x40U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f))
                                         ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                            - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction))
                                         : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__correction))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_a;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_a)) 
                                  << 7U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xcfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__new_c) 
                                  << 4U));
                    }
                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 6U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x3fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 2U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0xfU < (0x1fU & 
                                           ((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)) 
                                            + (0xfU 
                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))))) 
                                  << 5U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0xffU < (0x1ffU 
                                            & ((0xffU 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)) 
                                               + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)))) 
                                  << 4U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                            = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                          + ((0xff00U 
                                              & ((- (IData)(
                                                            (1U 
                                                             & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n) 
                                                                >> 7U)))) 
                                                 << 8U)) 
                                             | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))));
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x10U & ((~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                               >> 4U)) 
                                           << 4U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x10U | (0x8fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & (~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x60U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                       << 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((0x80U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                     << 3U)) | (0x7fU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                   >> 1U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x1fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                }
            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                       >> 3U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((0xfeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                     << 1U)) | (1U 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   >> 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x1fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                       << 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((0x80U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                     << 7U)) | (0x7fU 
                                                & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                   >> 1U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x1fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                }
            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                       | (0x10U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                   >> 3U)));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                    = ((0xfeU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                 << 1U)) | (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                  >> 7U)));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = (0x1fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = (0x3fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                       | ((0xfU < (0x1fU & ((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)) 
                                            + (0xfU 
                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))))) 
                          << 5U));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                       | ((0xffU < (0x1ffU & ((0xffU 
                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)) 
                                              + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)))) 
                          << 4U));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                    = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                 + ((0xff00U & ((- (IData)(
                                                           (1U 
                                                            & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n) 
                                                               >> 7U)))) 
                                                << 8U)) 
                                    | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                                >> 8U));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                    = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)));
            }
        } else if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                            VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                            (0xfffU 
                                             < (0x1ffffU 
                                                & ((0xfffU 
                                                    & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                        << 8U) 
                                                       | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l))) 
                                                   + 
                                                   (0xfffU 
                                                    & VL_EXTEND_II(17,16, 
                                                                   ([&]() {
                                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id 
                                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
                                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__Vfuncout 
                                                                = 
                                                                ((2U 
                                                                  & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id))
                                                                  ? 
                                                                 ((1U 
                                                                   & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id))
                                                                   ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)
                                                                   : 
                                                                  (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                                    << 8U) 
                                                                   | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)))
                                                                  : 
                                                                 ((1U 
                                                                   & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__rp_id))
                                                                   ? 
                                                                  (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                                    << 8U) 
                                                                   | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))
                                                                   : 
                                                                  (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                                    << 8U) 
                                                                   | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c))));
                                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__26__Vfuncout))))))));
                            VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                            (1U & (
                                                   ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                      << 8U) 
                                                     | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)) 
                                                    + 
                                                    VL_EXTEND_II(17,16, 
                                                                 ([&]() {
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id 
                                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__Vfuncout 
                                                            = 
                                                            ((2U 
                                                              & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id))
                                                              ? 
                                                             ((1U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id))
                                                               ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)
                                                               : 
                                                              (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                                << 8U) 
                                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)))
                                                              : 
                                                             ((1U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__rp_id))
                                                               ? 
                                                              (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                                << 8U) 
                                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))
                                                               : 
                                                              (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                                << 8U) 
                                                               | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c))));
                                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__27__Vfuncout)))) 
                                                   >> 0x10U)));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                               << 8U) 
                                              | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)) 
                                             + ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__Vfuncout 
                                                    = 
                                                    ((2U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id))
                                                       ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)
                                                       : 
                                                      (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                        << 8U) 
                                                       | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)))
                                                      : 
                                                     ((1U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__rp_id))
                                                       ? 
                                                      (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                        << 8U) 
                                                       | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))
                                                       : 
                                                      (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                        << 8U) 
                                                       | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__28__Vfuncout))) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l) 
                                            + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__Vfuncout 
                                                = (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)
                                                     : 
                                                    (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                      << 8U) 
                                                     | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__rp_id))
                                                     ? 
                                                    (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                      << 8U) 
                                                     | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))
                                                     : 
                                                    (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                      << 8U) 
                                                     | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_rp__29__Vfuncout))));
                        } else {
                            if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                                        = (0xffffU 
                                           & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp) 
                                              - (IData)(1U)));
                                } else {
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                        = (0xffU & 
                                           (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                               << 8U) 
                                              | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)) 
                                             - (IData)(1U)) 
                                            >> 8U));
                                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                        = (0xffU & 
                                           ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l) 
                                            - (IData)(1U)));
                                }
                            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                    = (0xffU & (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                   << 8U) 
                                                  | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)) 
                                                 - (IData)(1U)) 
                                                >> 8U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                    = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e) 
                                                - (IData)(1U)));
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                    = (0xffU & (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                   << 8U) 
                                                  | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)) 
                                                 - (IData)(1U)) 
                                                >> 8U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                    = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c) 
                                                - (IData)(1U)));
                            }
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                                    = (0xffffU & ((IData)(1U) 
                                                  + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp)));
                            } else {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                    = (0xffU & (((IData)(1U) 
                                                 + 
                                                 (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                                   << 8U) 
                                                  | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l))) 
                                                >> 8U));
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                    = (0xffU & ((IData)(1U) 
                                                + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)));
                            }
                        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & (((IData)(1U) 
                                             + (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                                                 << 8U) 
                                                | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & ((IData)(1U) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                = (0xffU & (((IData)(1U) 
                                             + (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                                                 << 8U) 
                                                | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c))) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                = (0xffU & ((IData)(1U) 
                                            + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)));
                        }
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                    } else {
                        if ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn));
                        } else if ((1U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn));
                        } else if ((2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn));
                        }
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    }
                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x10U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                            - (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))) 
                                           >> 4U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                        - (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0U == (0xffU & (
                                                   ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                                   - 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))) 
                                  << 7U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                   < (0x1ffU & ((0xfU 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                                + (1U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                      >> 4U))))) 
                                  << 5U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x10U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                            - (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))) 
                                           >> 4U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                        - (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0U == (0xffU & (
                                                   ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                                   - 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))) 
                                  << 7U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                   < (0x1ffU & ((0xfU 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                                + (1U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                      >> 4U))))) 
                                  << 5U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    } else {
                        VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (1U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                 - 
                                                 VL_EXTEND_II(9,8, 
                                                              ([&]() {
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id 
                                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__Vfuncout 
                                                            = 
                                                            ((4U 
                                                              & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                              ? 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                                : 0U)
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                              : 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__30__Vfuncout)))) 
                                                - (1U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                      >> 4U))) 
                                               >> 8U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         - ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__31__Vfuncout))) 
                                        - (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (0U == (0xffU 
                                                & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    - 
                                                    ([&]() {
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id 
                                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__Vfuncout 
                                                        = 
                                                        ((4U 
                                                          & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                          ? 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                            : 0U)
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                          : 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__32__Vfuncout))) 
                                                   - 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))));
                        VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        ((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                         < (0x1ffU 
                                            & (VL_EXTEND_II(9,8, 
                                                            (0xfU 
                                                             & ([&]() {
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id 
                                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__Vfuncout 
                                                            = 
                                                            ((4U 
                                                              & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                              ? 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                                : 0U)
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                              : 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__33__Vfuncout)))) 
                                               + (1U 
                                                  & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                     >> 4U))))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x10U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                            + (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))) 
                                           >> 4U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                        + (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0U == (0xffU & (
                                                   ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                                   + 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))) 
                                  << 7U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0xfU < (0x1ffU & 
                                           (((0xfU 
                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                             + (0xfU 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                                            + (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))))) 
                                  << 5U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x10U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                            + (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))) 
                                           >> 4U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                        + (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0U == (0xffU & (
                                                   ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                                   + 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))) 
                                  << 7U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | ((0xfU < (0x1ffU & 
                                           (((0xfU 
                                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                             + (0xfU 
                                                & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                                            + (1U & 
                                               ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U))))) 
                                  << 5U));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    } else {
                        VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (1U & ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                 + 
                                                 VL_EXTEND_II(9,8, 
                                                              ([&]() {
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id 
                                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__Vfuncout 
                                                            = 
                                                            ((4U 
                                                              & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                              ? 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                                : 0U)
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                              : 
                                                             ((2U 
                                                               & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                               ? 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                               : 
                                                              ((1U 
                                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__reg_id))
                                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__34__Vfuncout)))) 
                                                + (1U 
                                                   & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                      >> 4U))) 
                                               >> 8U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = (0xffU & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                         + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__35__Vfuncout))) 
                                        + (1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U))));
                        VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (0U == (0xffU 
                                                & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                    + 
                                                    ([&]() {
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id 
                                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__Vfuncout 
                                                        = 
                                                        ((4U 
                                                          & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                          ? 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                            : 0U)
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                          : 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__36__Vfuncout))) 
                                                   + 
                                                   (1U 
                                                    & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                       >> 4U))))));
                        VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (0xfU < (0x1ffU 
                                                 & (((0xfU 
                                                      & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                                     + 
                                                     VL_EXTEND_II(9,8, 
                                                                  (0xfU 
                                                                   & ([&]() {
                                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id 
                                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__Vfuncout 
                                                                = 
                                                                ((4U 
                                                                  & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                  ? 
                                                                 ((2U 
                                                                   & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                   ? 
                                                                  ((1U 
                                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                                    : 0U)
                                                                   : 
                                                                  ((1U 
                                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                                  : 
                                                                 ((2U 
                                                                   & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                   ? 
                                                                  ((1U 
                                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                                   : 
                                                                  ((1U 
                                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__reg_id))
                                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__37__Vfuncout))))) 
                                                    + 
                                                    (1U 
                                                     & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                        >> 4U))))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    }
                } else if (([&]() {
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc 
                                = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                         >> 3U));
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__Vfuncout 
                                = (1U & ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc))
                                          ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc))
                                              ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 4U)
                                              : (~ 
                                                 ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 4U)))
                                          : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__cc))
                                              ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                 >> 7U)
                                              : (~ 
                                                 ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 7U)))));
                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__38__Vfuncout))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        if ((0U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                          >> 3U)))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr));
                        } else if ((2U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                                 >> 3U)))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr));
                        } else if ((4U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                                 >> 3U)))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr));
                        } else if ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                                 >> 3U)))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr) 
                                            >> 8U));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                                = (0xf0U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr));
                        }
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                }
            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
            }
        } else if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if (([&]() {
                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc 
                                    = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                             >> 3U));
                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__Vfuncout 
                                    = (1U & ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc))
                                              ? ((1U 
                                                  & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc))
                                                  ? 
                                                 ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 4U)
                                                  : 
                                                 (~ 
                                                  ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   >> 4U)))
                                              : ((1U 
                                                  & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__cc))
                                                  ? 
                                                 ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                  >> 7U)
                                                  : 
                                                 (~ 
                                                  ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                   >> 7U)))));
                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__39__Vfuncout))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                            = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc) 
                                          + ((0xff00U 
                                              & ((- (IData)(
                                                            (1U 
                                                             & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n) 
                                                                >> 7U)))) 
                                                 << 8U)) 
                                             | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    }
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc) 
                                      + ((0xff00U & 
                                          ((- (IData)(
                                                      (1U 
                                                       & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n) 
                                                          >> 7U)))) 
                                           << 8U)) 
                                         | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                }
            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                               < (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                               < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                              << 4U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                               < (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                               < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                              << 4U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                } else {
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xffU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             - ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__40__Vfuncout))))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    ((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                     < VL_EXTEND_II(9,8, 
                                                    (0xfU 
                                                     & ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__41__Vfuncout))))));
                    VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                     < VL_EXTEND_II(9,8, 
                                                    ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__42__Vfuncout)))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                }
            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                      | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                      | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                           | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n));
                } else {
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                            | ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__43__Vfuncout)))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x8fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                           | ([&]() {
                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id 
                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__Vfuncout 
                                    = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                        ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                            ? ((1U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                : 0U)
                                            : ((1U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                        : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                            ? ((1U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                            : ((1U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__reg_id))
                                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__44__Vfuncout)));
                }
            } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                       | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                  ^ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                          << 7U));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                       ^ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
            } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                       | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                  ^ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                          << 7U));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                       ^ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n));
            } else {
                VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                (0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                        ^ ([&]() {
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id 
                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__Vfuncout 
                                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                            ? ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                    : 0U)
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                            : ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__45__Vfuncout)))));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                    = (0x8fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                       ^ ([&]() {
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__Vfuncout 
                                = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                    ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                        ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                            : 0U) : 
                                       ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                         ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                         : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                    : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                        ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                        : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__46__Vfuncout)));
            }
        } else if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x20U | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                   & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                                           << 7U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = ((0xfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                               | (0x20U | ((0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                   & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                                           << 7U)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n));
                    } else {
                        VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                        (0U == ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                                & ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__47__Vfuncout)))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                            = (0x20U | (0x8fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                               & ([&]() {
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id 
                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__Vfuncout 
                                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                            ? ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                    : 0U)
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                            : ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__48__Vfuncout)));
                    }
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                        - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                       >> 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                               < (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                        - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                       >> 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                               < (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                } else {
                    VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (1U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                            - VL_EXTEND_II(9,8, 
                                                           ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__49__Vfuncout)))) 
                                           >> 8U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    - ([&]() {
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id 
                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__Vfuncout 
                                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                            ? ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                    : 0U)
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                            : ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__50__Vfuncout))));
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xffU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             - ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__51__Vfuncout))))));
                    VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    ((0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                     < VL_EXTEND_II(9,8, 
                                                    (0xfU 
                                                     & ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__52__Vfuncout))))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                }
            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                        + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)) 
                                       >> 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0xfU < (0x1ffU & ((0xfU 
                                                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                                 + 
                                                 (0xfU 
                                                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xefU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x10U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                        + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)) 
                                       >> 4U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                               + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0xfU < (0x1ffU & ((0xfU 
                                                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                                 + 
                                                 (0xfU 
                                                  & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n))))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                } else {
                    VL_ASSIGNBIT_II(4U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (1U & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                            + VL_EXTEND_II(9,8, 
                                                           ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__53__Vfuncout)))) 
                                           >> 8U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                    + ([&]() {
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id 
                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__Vfuncout 
                                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                            ? ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                    : 0U)
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                            : ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__54__Vfuncout))));
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xffU & 
                                            ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                                             + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__55__Vfuncout))))));
                    VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0xfU < (0x1ffU 
                                             & ((0xfU 
                                                 & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)) 
                                                + VL_EXTEND_II(9,8, 
                                                               (0xfU 
                                                                & ([&]() {
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id 
                                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__Vfuncout 
                                                        = 
                                                        ((4U 
                                                          & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                          ? 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                            : 0U)
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                          : 
                                                         ((2U 
                                                           & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                           ? 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                           : 
                                                          ((1U 
                                                            & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__reg_id))
                                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__56__Vfuncout))))))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                }
            } else {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data) 
                                               - (IData)(1U)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x9fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | (0x40U | ((0U == (0xfU 
                                               & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data))) 
                                       << 5U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                        = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data) 
                                      - (IData)(1U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else {
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xffU & 
                                            (VL_EXTEND_II(32,8, 
                                                          ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__57__Vfuncout))) 
                                             - (IData)(1U)))));
                    VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xfU & 
                                            ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__58__Vfuncout)))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0x40U | (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                    = (0xffU & (([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__59__Vfuncout)) 
                                                - (IData)(1U)));
                            }
                        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & (([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__60__Vfuncout)) 
                                            - (IData)(1U)));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & (([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__61__Vfuncout)) 
                                            - (IData)(1U)));
                        }
                    } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & (([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__62__Vfuncout)) 
                                            - (IData)(1U)));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & (([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__63__Vfuncout)) 
                                            - (IData)(1U)));
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                            = (0xffU & (([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__64__Vfuncout)) 
                                        - (IData)(1U)));
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                            = (0xffU & (([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__65__Vfuncout)) 
                                        - (IData)(1U)));
                    }
                }
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read)
                        ? 8U : 0U);
            }
        } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
                if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0x7fU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0U == (0xffU & ((IData)(1U) 
                                               + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)))) 
                              << 7U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 0U;
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = ((0xdfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f)) 
                           | ((0xfU < ((IData)(1U) 
                                       + (0xfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)))) 
                              << 5U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                        = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data = 0U;
                } else {
                    VL_ASSIGNBIT_II(7U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0U == (0xffU & 
                                            ((IData)(1U) 
                                             + VL_EXTEND_II(32,8, 
                                                            ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__66__Vfuncout)))))));
                    VL_ASSIGNBIT_II(5U, __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f, 
                                    (0xfU < ((IData)(1U) 
                                             + (0xfU 
                                                & VL_EXTEND_II(32,8, 
                                                               ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__67__Vfuncout)))))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
                        = (0xbfU & (IData)(__Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
                    if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                    = (0xffU & ((IData)(1U) 
                                                + ([&]() {
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id 
                                                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__Vfuncout 
                                                    = 
                                                    ((4U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                        : 0U)
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                      : 
                                                     ((2U 
                                                       & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                       : 
                                                      ((1U 
                                                        & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__reg_id))
                                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                            }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__68__Vfuncout))));
                            }
                        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                                = (0xffU & ((IData)(1U) 
                                            + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__69__Vfuncout))));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                                = (0xffU & ((IData)(1U) 
                                            + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__70__Vfuncout))));
                        }
                    } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                                = (0xffU & ((IData)(1U) 
                                            + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__71__Vfuncout))));
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                                = (0xffU & ((IData)(1U) 
                                            + ([&]() {
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id 
                                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__Vfuncout 
                                                = (
                                                   (4U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                    ? 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                      : 0U)
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                    : 
                                                   ((2U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                     ? 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                     : 
                                                    ((1U 
                                                      & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__reg_id))
                                                      ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                      : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__72__Vfuncout))));
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                            = (0xffU & ((IData)(1U) 
                                        + ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__73__Vfuncout))));
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                            = (0xffU & ((IData)(1U) 
                                        + ([&]() {
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id 
                                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
                                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__Vfuncout 
                                            = ((4U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                ? (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                     : 0U)
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                                : (
                                                   (2U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                    ? 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                    : 
                                                   ((1U 
                                                     & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__reg_id))
                                                     ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                     : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__74__Vfuncout))));
                    }
                }
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
                    = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read)
                        ? 8U : 0U);
            } else {
                if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                        } else {
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                                = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                    << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                        }
                    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                    }
                } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
                }
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
                    = ((6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))
                        ? 8U : 0U);
            }
        } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op))) {
            if ((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id 
                            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__Vfuncout 
                            = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                    ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                        : 0U) : ((1U 
                                                  & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                                  ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                  : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                    ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                    : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__reg_id))
                                        ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                        : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
                            = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__75__Vfuncout;
                    } else {
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                            = VL_EXTEND_II(16,8, ([&]() {
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id 
                                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__Vfuncout 
                                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                            ? ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                                    : 0U)
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                            : ((2U 
                                                & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                ? (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                                : (
                                                   (1U 
                                                    & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__reg_id))
                                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                                }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__76__Vfuncout)));
                    }
                } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__Vfuncout 
                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                            ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                    : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                              ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                              : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                            : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                        = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__77__Vfuncout;
                } else {
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__Vfuncout 
                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                            ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                    : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                              ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                              : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                            : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                        = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__78__Vfuncout;
                }
            } else if ((2U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__Vfuncout 
                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                            ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                    : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                              ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                              : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                            : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
                        = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__79__Vfuncout;
                } else {
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id 
                        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                    __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__Vfuncout 
                        = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                            ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                    : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                              ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                              : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                            : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__reg_id))
                                    ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                    : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
                        = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__80__Vfuncout;
                }
            } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))) {
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__Vfuncout 
                    = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                        ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                            ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                                          ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                          : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                        : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                            ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                            : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
                    = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__81__Vfuncout;
            } else {
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
                __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__Vfuncout 
                    = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                        ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                            ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                : 0U) : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                                          ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                          : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                        : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                            ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                            : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__reg_id))
                                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
                    = __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__82__Vfuncout;
            }
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
                = ((6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst))
                    ? 8U : 0U);
        } else {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
        }
    } else if ((1U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state))) {
        if ((0xc6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 5U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xceU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x19U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xd6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 6U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xdeU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1aU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xe6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xeeU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 8U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xf6U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 9U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xfeU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xaU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xf3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x11U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((0xfbU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x12U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((0xd9U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x13U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 5U;
        } else if ((0x76U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x32U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x31U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((0x31U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x14U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xfaU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xeaU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xf0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xe0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xf9U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1bU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((8U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xf8U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x20U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xe2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                = (0xffffU & ((IData)(0xff00U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
        } else if ((0xf2U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                = (0xffffU & ((IData)(0xff00U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
        } else if ((0xe8U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x2aU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0x10U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x2bU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((0xcbU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 9U;
        } else if ((0xe9U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x33U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((1U == (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                 >> 6U)))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 3U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else if ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                    = VL_EXTEND_II(16,8, ([&]() {
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id 
                                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
                            __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__Vfuncout 
                                = ((4U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                    ? ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                        ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a)
                                            : 0U) : 
                                       ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                         ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)
                                         : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h)))
                                    : ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                        ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e)
                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d))
                                        : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__reg_id))
                                            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)
                                            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b))));
                        }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__get_reg__83__Vfuncout)));
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((6U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 3U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 2U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
        } else if ((IData)((4U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 3U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 3U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            if ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                              >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((5U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 4U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 3U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            if ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                              >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0x80U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 5U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0x90U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 6U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0xa0U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 7U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0xa8U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 8U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0xb0U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 9U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0xb8U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xaU;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0xc3U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xbU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((0x18U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xcU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)(((0U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                            & (4U <= (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                            >> 3U)))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xdU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((0xcdU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xeU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((0xc4U == (0xe7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            if (((((IData)(((0U == (0x18U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                            & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                  >> 7U)))) | (IData)(
                                                      ((8U 
                                                        == 
                                                        (0x18U 
                                                         & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                                                       & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                          >> 7U)))) 
                  | (IData)(((0x10U == (0x18U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                             & (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                   >> 4U))))) | (IData)(
                                                        ((0x18U 
                                                          == 
                                                          (0x18U 
                                                           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) 
                                                         & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                            >> 4U))))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xeU;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm = 1U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x31U;
            }
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((0xc9U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0xfU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 5U;
        } else if (((IData)((0xc5U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) 
                    & (1U != (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                    >> 3U))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
                = (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 3U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x15U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 4U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
            if ((0U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                              >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c));
            } else if ((2U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e));
            } else if ((4U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
            } else if ((6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f));
            }
        } else if (((IData)((0xc1U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) 
                    & (1U != (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                    >> 3U))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x17U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 5U;
        } else if ((IData)((0xc2U == (0xe7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x18U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((2U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src = 7U;
            if ((0x20U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
                if ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                        = (0xffU & (((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                       << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)) 
                                     - (IData)(1U)) 
                                    >> 8U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                        = (0xffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l) 
                                    - (IData)(1U)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                } else {
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
                        = (0xffU & (((IData)(1U) + 
                                     (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                                       << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l))) 
                                    >> 8U));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
                        = (0xffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l)));
                    __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                        = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                }
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))
                        ? (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e))
                        : (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b) 
                            << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c)));
            }
            if ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
                    = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 8U;
            }
        } else if ((IData)((0x88U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x19U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((0x98U == (0xf8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1aU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
                = (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst = 7U;
            if ((6U == (7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
                    = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h) 
                        << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l));
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 7U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
            }
        } else if ((IData)((1U == (0xcfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
                = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 4U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1cU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 3U;
        } else if ((IData)((3U == (0xcfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
                = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 4U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1dU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((IData)((0xbU == (0xcfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
                = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 4U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1eU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((IData)((9U == (0xcfU & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
                = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                         >> 4U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x1fU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((IData)((7U == (0xe7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op 
                = ((0x10U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))
                    ? ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))
                        ? 0x24U : 0x23U) : ((8U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))
                                             ? 0x22U
                                             : 0x21U));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if (((IData)((0x27U == (0xe7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) 
                    & (0U != (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                    >> 3U))))) {
            if ((1U == (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                              >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x25U;
            } else if ((2U == (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x26U;
            } else if ((3U == (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U)))) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x27U;
            }
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else if ((IData)((0xc7U == (0xc7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
                = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr 
                = (0x38U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir));
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x28U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 4U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
        } else if ((IData)((0xc0U == (0xe7U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir))))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x29U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 1U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next 
                = (([&]() {
                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc 
                            = (3U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir) 
                                     >> 3U));
                        __Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__Vfuncout 
                            = (1U & ((2U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc))
                                      ? ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc))
                                          ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                             >> 4U)
                                          : (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 4U)))
                                      : ((1U & (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__cc))
                                          ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                             >> 7U)
                                          : (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f) 
                                                >> 7U)))));
                    }(), (IData)(__Vfunc_tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cond_met__84__Vfuncout))
                    ? 5U : 0U);
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
        } else if ((IData)((0x27U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir)))) {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x2cU;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 2U;
        } else {
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0U;
        }
    } else if (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime) 
                & (0U != ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r) 
                          & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r))))) {
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op = 0x10U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt = 2U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next = 4U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 0xbU;
    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready) {
        if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) {
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug = 0U;
            } else {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
                    = (0xffffU & ((IData)(1U) + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc)));
            }
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir 
                = vlSelf->tb_gb_boot__DOT__din;
            if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending) {
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime = 1U;
                __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending = 0U;
            }
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 0U;
            __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state = 1U;
        }
    } else {
        vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
        vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we = 0U;
        __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready = 1U;
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
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__pixel_pal 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__use_obj)
            ? ((4U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__obj)
                ? 2U : 1U) : 0U);
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r 
        = (0xfU & ((0x40000000U & vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head)
                    ? (((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                         ? 0xfU : 7U) - (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0))
                    : (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_ha2431af8__0)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__in_win) 
           & VL_GTES_III(10, (0x3ffU & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                                  >> 8U)) 
                                        - (IData)(8U))), (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__pc;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__f;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__fetch_ready;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_fetch;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__imm16;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_read_after_imm;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_after_imm;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__src;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_op;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__n;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__nn;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ret_addr;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__second_stack_fetch;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__push_after_imm;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__rp_sel;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_write_sp;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__sp_write_low_done;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__iv_addr;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime_pending;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_addr;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_data;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__alu_imm;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ime;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__halt_bug;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__cb_ir;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_cnt;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__idle_next;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__state;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__ir;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__a;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__dst;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_read;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__mem_alu_data;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__h;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__l;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__e;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__d;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__c;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b 
        = __Vdly__tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__b;
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_lo_addr 
        = ((0xff0U & (((4U & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc))
                        ? ((0xfeU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                     >> 0x10U)) | (1U 
                                                   & ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r) 
                                                      >> 3U)))
                        : (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                           >> 0x10U)) << 4U)) | (0xfU 
                                                 & VL_SHIFTL_III(4,4,32, (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__r), 1U)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__p_pos 
        = (0x3ffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_in_win)
                      ? (((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                    >> 8U)) - (IData)(8U)) 
                         - (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__xw))
                      : (((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                    >> 8U)) - (IData)(8U)) 
                         + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__scx_lat))));
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1 = 0U;
    } else if (vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__m_d1 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r;
    }
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
    if (vlSelf->tb_gb_boot__DOT__rst) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r = 0U;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r = 0U;
    } else {
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_next;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_next;
        vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_r 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__mode_n;
    }
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_hram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_oam = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_joypad = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_serial = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_apu = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_oam_dma = 0U;
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_interrupt_ctrl = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_timer = 0U;
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_reg = 0U;
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
                                                            if (
                                                                (0xff50U 
                                                                 == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr))) {
                                                                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable = 1U;
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
                if (((0xc000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                     & (0xdfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = 1U;
                } else if (((0xe000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                            & (0xfdffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram = 1U;
                }
            }
            if (((0xa000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
                 & (0xbfffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
                vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_ram = 1U;
            }
        }
        if (((0x8000U <= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)) 
             & (0x9fffU >= (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr)))) {
            vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram = 1U;
        }
    }
    if (vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run) {
        vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr 
            = (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                << 8U) | (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__idx));
        vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff 
            = (6U == (7U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                            >> 5U)));
    } else {
        vlSelf->tb_gb_boot__DOT__dut__DOT__mem_addr 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_addr;
        vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff 
            = vlSelf->tb_gb_boot__DOT__dut__DOT__sel_wram;
    }
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb = ((1U 
                                                 & (~ (IData)(vlSelf->tb_gb_boot__DOT__rst))) 
                                                && (1U 
                                                    & (IData)(
                                                              (1ULL 
                                                               & ((0xabcc771ULL 
                                                                   + (QData)((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc))) 
                                                                  >> 0x20U)))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc 
        = ((IData)(vlSelf->tb_gb_boot__DOT__rst) ? 0U
            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc_next));
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram_eff 
        = ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_blocked)) 
           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_ppu_vram));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_cpu__DOT__int_pending 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__ie_r) 
           & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_interrupt_ctrl__DOT__if_r));
    vlSelf->tb_gb_boot__DOT__dut__DOT__irq_vblank = 
        ((((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) 
           & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
              >> 7U)) & (0x1c7U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter))) 
         & (0x8fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT____VdfgTmp_hc2a89326__0 
        = (0xffffU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__sys_cnt) 
                      + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__first_line_r;
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__dot_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__dot_counter;
    vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_gb) 
                                               & (3U 
                                                  == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__t_cycle_count)));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_n 
        = vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fsm__DOT__ly_r;
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
    tb_gb_boot__DOT__dut__DOT__irq_timer = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
                                            & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_timer__DOT__ovf_pending));
    __VdfgTmp_h3183dfc6__0 = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__ce_m) 
                              & (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__cpu_we));
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count_after_pop 
        = (0xfU & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__count) 
                   - (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok)));
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__pop_ok) 
           & ((0U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__discard)) 
              & (0xa0U > (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt))));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc_next 
        = (0x1ffffffffULL & (0xabcc771ULL + (QData)((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_clk_div__DOT__gb_acc))));
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
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0 
        = ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__win_start)) 
           & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__at_pixel));
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig 
        = ((IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0) 
           & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_reg__DOT__lcdc) 
               >> 1U) & (((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_ptr) 
                          < (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__spr_count)) 
                         & ((0xffU & (vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__sp_head 
                                      >> 8U)) <= (0x1ffU 
                                                  & ((IData)(8U) 
                                                     + (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)))))));
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid 
        = ((3U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__mode)) 
           & ((~ (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__spr_trig)) 
              & (IData)(tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT____VdfgTmp_h634d98a6__0)));
    tb_gb_boot__DOT__dut__DOT__u_timer__DOT__tima_tick 
        = ((~ (IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_next)) 
           & (IData)(tb_gb_boot__DOT__dut__DOT__u_timer__DOT__timer_in_now));
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__fifo_done 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__pixel_valid) 
           & (0x9fU == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__x_cnt)));
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
}

VL_INLINE_OPT void Vtb_gb_boot___024root___nba_comb__TOP__0(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___nba_comb__TOP__0\n"); );
    // Init
    CData/*7:0*/ __VdfgTmp_hf5649b4a__0;
    __VdfgTmp_hf5649b4a__0 = 0;
    CData/*7:0*/ __VdfgTmp_hfbf07a09__0;
    __VdfgTmp_hfbf07a09__0 = 0;
    // Body
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
    vlSelf->tb_gb_boot__DOT__dut__DOT__cart_data_out 
        = ((1U & ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run)
                   ? (~ ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_oam_dma__DOT__run_hi) 
                         >> 7U)) : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_cart_rom)))
            ? ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_sel_q)
                ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__boot_q)
                : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_cartridge__DOT__cart_q))
            : ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__sel_boot_disable)
                ? 0xffU : 0U));
    vlSelf->tb_gb_boot__DOT__dut__DOT__wram_data_out 
        = ((IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__wram_sel_eff)
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_wram__DOT__rdata)
            : 0U);
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

VL_INLINE_OPT void Vtb_gb_boot___024root___nba_sequent__TOP__2(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___nba_sequent__TOP__2\n"); );
    // Body
    vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q 
        = vlSelf->__Vdly__tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q;
}

VL_INLINE_OPT void Vtb_gb_boot___024root___nba_comb__TOP__1(Vtb_gb_boot___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtb_gb_boot__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtb_gb_boot___024root___nba_comb__TOP__1\n"); );
    // Init
    CData/*7:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now = 0;
    CData/*4:0*/ tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src;
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__src = 0;
    // Body
    tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_now 
        = ((5U == (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__fstate))
            ? (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_vram__DOT__render_q)
            : (IData)(vlSelf->tb_gb_boot__DOT__dut__DOT__u_ppu__DOT__u_fetcher__DOT__hi_r));
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
}
