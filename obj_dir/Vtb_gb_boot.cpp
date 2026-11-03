// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vtb_gb_boot__pch.h"

//============================================================
// Constructors

Vtb_gb_boot::Vtb_gb_boot(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vtb_gb_boot__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vtb_gb_boot::Vtb_gb_boot(const char* _vcname__)
    : Vtb_gb_boot(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vtb_gb_boot::~Vtb_gb_boot() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vtb_gb_boot___024root___eval_debug_assertions(Vtb_gb_boot___024root* vlSelf);
#endif  // VL_DEBUG
void Vtb_gb_boot___024root___eval_static(Vtb_gb_boot___024root* vlSelf);
void Vtb_gb_boot___024root___eval_initial(Vtb_gb_boot___024root* vlSelf);
void Vtb_gb_boot___024root___eval_settle(Vtb_gb_boot___024root* vlSelf);
void Vtb_gb_boot___024root___eval(Vtb_gb_boot___024root* vlSelf);

void Vtb_gb_boot::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vtb_gb_boot::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vtb_gb_boot___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vtb_gb_boot___024root___eval_static(&(vlSymsp->TOP));
        Vtb_gb_boot___024root___eval_initial(&(vlSymsp->TOP));
        Vtb_gb_boot___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vtb_gb_boot___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vtb_gb_boot::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vtb_gb_boot::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vtb_gb_boot::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vtb_gb_boot___024root___eval_final(Vtb_gb_boot___024root* vlSelf);

VL_ATTR_COLD void Vtb_gb_boot::final() {
    Vtb_gb_boot___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vtb_gb_boot::hierName() const { return vlSymsp->name(); }
const char* Vtb_gb_boot::modelName() const { return "Vtb_gb_boot"; }
unsigned Vtb_gb_boot::threads() const { return 1; }
void Vtb_gb_boot::prepareClone() const { contextp()->prepareClone(); }
void Vtb_gb_boot::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vtb_gb_boot::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vtb_gb_boot::trace()' called on model that was Verilated without --trace option");
}
