// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtb_gb_boot.h for the primary calling header

#include "Vtb_gb_boot__pch.h"
#include "Vtb_gb_boot__Syms.h"
#include "Vtb_gb_boot___024root.h"

void Vtb_gb_boot___024root___ctor_var_reset(Vtb_gb_boot___024root* vlSelf);

Vtb_gb_boot___024root::Vtb_gb_boot___024root(Vtb_gb_boot__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtb_gb_boot___024root___ctor_var_reset(this);
}

void Vtb_gb_boot___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vtb_gb_boot___024root::~Vtb_gb_boot___024root() {
}
