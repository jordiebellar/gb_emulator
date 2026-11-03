// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VTB_GB_BOOT__SYMS_H_
#define VERILATED_VTB_GB_BOOT__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vtb_gb_boot.h"

// INCLUDE MODULE CLASSES
#include "Vtb_gb_boot___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vtb_gb_boot__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vtb_gb_boot* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vtb_gb_boot___024root          TOP;

    // CONSTRUCTORS
    Vtb_gb_boot__Syms(VerilatedContext* contextp, const char* namep, Vtb_gb_boot* modelp);
    ~Vtb_gb_boot__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
