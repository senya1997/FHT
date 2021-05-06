// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfht_top.h for the primary calling header

#include "Vfht_top.h"
#include "Vfht_top__Syms.h"

//==========

VerilatedContext* Vfht_top::contextp() {
    return __VlSymsp->_vm_contextp__;
}

void Vfht_top::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vfht_top::eval\n"); );
    Vfht_top__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        vlSymsp->__Vm_activity = true;
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("fht_top.v", 3, "",
                "Verilated model didn't converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
            } else {
                __Vchange = _change_request(vlSymsp);
            }
        } while (VL_UNLIKELY(__Vchange));
    }
    
    void Vfht_top::_eval_initial_loop(Vfht_top__Syms* __restrict vlSymsp) {
        vlSymsp->__Vm_didInit = true;
        _eval_initial(vlSymsp);
        vlSymsp->__Vm_activity = true;
        // Evaluate till stable
        int __VclockLoop = 0;
        QData __Vchange = 1;
        do {
            _eval_settle(vlSymsp);
            _eval(vlSymsp);
            if (VL_UNLIKELY(++__VclockLoop > 100)) {
                // About to fail, so enable debug to see what's not settling.
                // Note you must run make with OPT=-DVL_DEBUG for debug prints.
                int __Vsaved_debug = Verilated::debug();
                Verilated::debug(1);
                __Vchange = _change_request(vlSymsp);
                Verilated::debug(__Vsaved_debug);
                VL_FATAL_MT("fht_top.v", 3, "",
                    "Verilated model didn't DC converge\n"
                    "- See https://verilator.org/warn/DIDNOTCONVERGE");
                } else {
                    __Vchange = _change_request(vlSymsp);
                }
            } while (VL_UNLIKELY(__Vchange));
        }
        
        VL_INLINE_OPT void Vfht_top::_sequent__TOP__2(Vfht_top__Syms* __restrict vlSymsp) {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_sequent__TOP__2\n"); );
            Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
            // Variables
            CData/*6:0*/ __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout;
            CData/*6:0*/ __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA;
            CData/*3:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage;
            CData/*3:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__div_2;
            CData/*3:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__sec_part_subsec_d;
            CData/*6:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt;
            CData/*0:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__source_data;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v0;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v2;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v0;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v2;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v12;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v15;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12;
            CData/*0:0*/ __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v15;
            SData/*9:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time;
            SData/*9:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__div;
            SData/*8:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector;
            SData/*8:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time;
            SData/*9:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd;
            SData/*9:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd;
            SData/*8:0*/ __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt;
            SData/*12:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v0;
            SData/*12:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v1;
            SData/*12:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v0;
            SData/*12:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v1;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v1;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v2;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v3;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v5;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v6;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v7;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v9;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v10;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v11;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v1;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v4;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v5;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v7;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v8;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v10;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v11;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v13;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v14;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v1;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v4;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v5;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v7;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v8;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v10;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v11;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v13;
            IData/*26:0*/ __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v14;
            // Body
            __Vdly__fht_top__DOT__CONTROL__DOT__sec_part_subsec_d 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v0 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v2 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v0 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v2 = 0U;
            __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt;
            __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time;
            __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt;
            __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd;
            __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd;
            __Vdly__fht_top__DOT__CONTROL__DOT__div_2 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__div_2;
            __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time;
            __Vdly__fht_top__DOT__CONTROL__DOT__div 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__div;
            __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage;
            __Vdly__fht_top__DOT__CONTROL__DOT__source_data 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__source_data;
            __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v15 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v15 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8 = 0U;
            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v12 = 0U;
            if (vlTOPp->iRESET) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf 
                    = (0x7ffffffU & ((1U & ((IData)(
                                                    (0x800ULL 
                                                     == 
                                                     (0x4000000800ULL 
                                                      & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB))) 
                                            | ((IData)(
                                                       (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                        >> 0x26U)) 
                                               & (0x800U 
                                                  < 
                                                  (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB))))))
                                      ? ((IData)(1U) 
                                         + (IData)(
                                                   (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                    >> 0xcU)))
                                      : (IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                 >> 0xcU))));
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf 
                    = (0x7ffffffU & ((1U & ((IData)(
                                                    (0x800ULL 
                                                     == 
                                                     (0x4000000800ULL 
                                                      & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM))) 
                                            | ((IData)(
                                                       (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                        >> 0x26U)) 
                                               & (0x800U 
                                                  < 
                                                  (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM))))))
                                      ? ((IData)(1U) 
                                         + (IData)(
                                                   (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                    >> 0xcU)))
                                      : (IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                 >> 0xcU))));
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf 
                    = (0x7ffffffU & ((1U & ((IData)(
                                                    (0x800ULL 
                                                     == 
                                                     (0x4000000800ULL 
                                                      & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB))) 
                                            | ((IData)(
                                                       (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                        >> 0x26U)) 
                                               & (0x800U 
                                                  < 
                                                  (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB))))))
                                      ? ((IData)(1U) 
                                         + (IData)(
                                                   (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                    >> 0xcU)))
                                      : (IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                 >> 0xcU))));
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf 
                    = (0x7ffffffU & ((1U & ((IData)(
                                                    (0x800ULL 
                                                     == 
                                                     (0x4000000800ULL 
                                                      & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM))) 
                                            | ((IData)(
                                                       (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                        >> 0x26U)) 
                                               & (0x800U 
                                                  < 
                                                  (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM))))))
                                      ? ((IData)(1U) 
                                         + (IData)(
                                                   (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                    >> 0xcU)))
                                      : (IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                 >> 0xcU))));
                __Vdly__fht_top__DOT__CONTROL__DOT__sec_part_subsec_d 
                    = ((0xeU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                << 1U)) | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                                           >= (0x3ffU 
                                               & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                  >> 1U))));
            } else {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf = 0U;
                __Vdly__fht_top__DOT__CONTROL__DOT__sec_part_subsec_d = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef = 0U;
                } else {
                    if (((1U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         | (0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)))) {
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA 
                            = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt;
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x3fU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 6U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 1U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x5fU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 5U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 2U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x6fU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 4U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 3U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x77U & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 3U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 4U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x7bU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 2U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 5U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x7dU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1) 
                                  << 1U));
                        vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1 
                            = (1U & ((IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__iDATA) 
                                     >> 6U));
                        __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout 
                            = ((0x7eU & (IData)(__Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout)) 
                               | (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT____Vlvbound1));
                        vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef 
                            = __Vfunc_fht_top__DOT__CONTROL__DOT__F_BIT_REV__0__Vfuncout;
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef = 0U;
            }
            if (vlTOPp->iRESET) {
                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v0 
                    = vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0;
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v0 = 1U;
                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v1 
                    = (0x1fffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                                   ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0)
                                   : ((IData)(1U) + 
                                      (~ (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)))));
            } else {
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v2 = 1U;
            }
            if (vlTOPp->iRESET) {
                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v0 
                    = vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0;
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v0 = 1U;
                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v1 
                    = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                        ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)
                        : (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0));
            } else {
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v2 = 1U;
            }
            if (vlTOPp->iRESET) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul 
                    = (0x1ffffffffffULL & (VL_MULS_QQQ(41,41,41, 
                                                       (0x1ffffffffffULL 
                                                        & VL_EXTENDS_QI(41,27, 
                                                                        vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                                                        [1U])), 
                                                       (0x1ffffffffffULL 
                                                        & VL_EXTENDS_QI(41,13, 
                                                                        vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                                                        [1U]))) 
                                           + VL_MULS_QQQ(41,41,41, 
                                                         (0x1ffffffffffULL 
                                                          & VL_EXTENDS_QI(41,27, 
                                                                          vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                                                          [2U])), 
                                                         (0x1ffffffffffULL 
                                                          & VL_EXTENDS_QI(41,13, 
                                                                          vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                                                          [1U])))));
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul 
                    = (0x1ffffffffffULL & (VL_MULS_QQQ(41,41,41, 
                                                       (0x1ffffffffffULL 
                                                        & VL_EXTENDS_QI(41,27, 
                                                                        vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                                                        [1U])), 
                                                       (0x1ffffffffffULL 
                                                        & VL_EXTENDS_QI(41,13, 
                                                                        vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                                                        [0U]))) 
                                           + VL_MULS_QQQ(41,41,41, 
                                                         (0x1ffffffffffULL 
                                                          & VL_EXTENDS_QI(41,27, 
                                                                          vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                                                          [2U])), 
                                                         (0x1ffffffffffULL 
                                                          & VL_EXTENDS_QI(41,13, 
                                                                          vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                                                          [0U])))));
                vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont 
                    = (((~ (IData)(vlTOPp->iSTART)) 
                        & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy)) 
                       & 1U);
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt;
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias 
                    = ((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))
                        ? (0x1ffU & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE) 
                                      | (0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)))
                                      ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt)
                                      : (0x3ffU & (
                                                   (8U 
                                                    & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d))
                                                    ? 
                                                   ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt) 
                                                    - 
                                                    ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                     >> 1U))
                                                    : 
                                                   ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt) 
                                                    + 
                                                    ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                     >> 1U))))))
                        : 0U);
            } else {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul = 0ULL;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul = 0ULL;
                vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont = 0U;
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d = 0U;
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias = 0U;
            }
            if (vlTOPp->iRESET) {
                if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt = 0U;
                } else {
                    if (((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt 
                            = (0x1ffU & ((IData)(1U) 
                                         + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt = 0U;
            }
            if (vlTOPp->iRESET) {
                if ((((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD) 
                      | (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR)) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time = 0U;
                } else {
                    if (vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time 
                            = (0x1ffU & ((IData)(1U) 
                                         + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time = 0U;
            }
            if (vlTOPp->iRESET) {
                if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR) 
                     | (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__we_b = 0U;
                } else {
                    if (((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)))) {
                        vlTOPp->fht_top__DOT__CONTROL__DOT__we_b = 1U;
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__we_b = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt = 0U;
                } else {
                    if (((((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                           == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                               - (IData)(2U))) & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)) 
                         | ((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                            & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt 
                            = (0x7fU & ((IData)(1U) 
                                        + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt = 0U;
            }
            if (vlTOPp->iRESET) {
                if ((0x201U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd = 1U;
                } else {
                    if ((((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD) 
                          & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD)) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd 
                            = (0x3ffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd) 
                                         << 1U));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd = 0U;
            }
            if (vlTOPp->iRESET) {
                if ((0x201U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd = 2U;
                } else {
                    if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd 
                            = (0x3ffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD)
                                          ? ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd) 
                                             - (IData)(1U))
                                          : (VL_EXTENDS_II(10,10, (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd)) 
                                             - (IData)(2U))));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd = 0U;
            }
            if (vlTOPp->iRESET) {
                if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR) 
                     | (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__we_a = 0U;
                } else {
                    if (((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))) {
                        vlTOPp->fht_top__DOT__CONTROL__DOT__we_a = 1U;
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__we_a = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__div_2 = 9U;
                } else {
                    if ((((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                          & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE))) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__div_2 
                            = (0xfU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2) 
                                       - (IData)(1U)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__div_2 = 9U;
            }
            if (vlTOPp->iRESET) {
                if ((((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
                      | (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_STAGE)) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time = 0U;
                } else {
                    if (vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time 
                            = (0x3ffU & ((IData)(1U) 
                                         + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__div = 0x200U;
                } else {
                    if ((((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                          & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE))) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__div 
                            = (0x3ffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                         >> 1U));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__div = 0x200U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage = 0U;
                } else {
                    if (((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage 
                            = (0xfU & ((IData)(1U) 
                                       + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__source_data = 0U;
                } else {
                    if (((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__source_data 
                            = (1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_data)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__source_data = 0U;
            }
            if (vlTOPp->iRESET) {
                if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias = 0U;
                } else {
                    if (vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2) {
                        vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias 
                            = (0x1ffU & ((IData)(1U) 
                                         + ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt) 
                                            + (0x7ffU 
                                               & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd) 
                                                  << (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2))))));
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias = 0U;
            }
            if (vlTOPp->iRESET) {
                if ((((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD) 
                      | (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector = 0U;
                } else {
                    if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR) 
                         & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                        __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector 
                            = (0x1ffU & ((IData)(1U) 
                                         + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)));
                    }
                }
            } else {
                __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector = 0U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE) {
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0 
                        = vlTOPp->fht_top__DOT__DATA_BUT
                        [2U];
                    __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0 = 1U;
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v1 
                        = vlTOPp->fht_top__DOT__DATA_BUT
                        [3U];
                } else {
                    if ((0U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [2U];
                        __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3 = 1U;
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v4 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [3U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v5 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [3U];
                    } else {
                        if ((1U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [3U];
                            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6 = 1U;
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v7 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [2U];
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v8 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [0U];
                        } else {
                            if ((1U & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [3U];
                                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9 = 1U;
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v10 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [2U];
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v11 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [1U];
                            } else {
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [2U];
                                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12 = 1U;
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v13 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [3U];
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v14 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [0U];
                            }
                        }
                    }
                }
            } else {
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v15 = 1U;
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE) {
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0 
                        = vlTOPp->fht_top__DOT__DATA_BUT
                        [0U];
                    __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0 = 1U;
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v1 
                        = vlTOPp->fht_top__DOT__DATA_BUT
                        [1U];
                } else {
                    if ((0U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [0U];
                        __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3 = 1U;
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v4 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [1U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v5 
                            = vlTOPp->fht_top__DOT__DATA_BUT
                            [1U];
                    } else {
                        if ((1U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [1U];
                            __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6 = 1U;
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v7 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [0U];
                            __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v8 
                                = vlTOPp->fht_top__DOT__DATA_BUT
                                [2U];
                        } else {
                            if ((1U & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d))) {
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [1U];
                                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9 = 1U;
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v10 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [0U];
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v11 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [3U];
                            } else {
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [0U];
                                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12 = 1U;
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v13 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [1U];
                                __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v14 
                                    = vlTOPp->fht_top__DOT__DATA_BUT
                                    [2U];
                            }
                        }
                    }
                }
            } else {
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v15 = 1U;
            }
            if (vlTOPp->iRESET) {
                if ((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))) {
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0 
                        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                        [0U];
                    __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0 = 1U;
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v1 
                        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                        [1U];
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v2 
                        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                        [2U];
                    __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v3 
                        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                        [3U];
                } else {
                    if ((1U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                >> 3U) & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE))))) {
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [2U];
                        __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4 = 1U;
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v5 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [0U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v6 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [3U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v7 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [1U];
                    } else {
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [0U];
                        __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8 = 1U;
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v9 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [2U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v10 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [1U];
                        __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v11 
                            = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [3U];
                    }
                }
            } else {
                __Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v12 = 1U;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v0) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v0;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__cos__v1;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__cos__v2) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                            [0U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                            [1U] = 0U;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v0) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v0;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__sin__v1;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__sin__v2) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                            [0U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                            [1U] = 0U;
            }
            vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt 
                = __Vdly__fht_top__DOT__CONTROL__DOT__addr_wr_cnt;
            vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt 
                = __Vdly__fht_top__DOT__CONTROL__DOT__addr_coef_cnt;
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time 
                = __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector_time;
            vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd 
                = __Vdly__fht_top__DOT__CONTROL__DOT__size_bias_rd;
            vlTOPp->fht_top__DOT__CONTROL__DOT__div 
                = __Vdly__fht_top__DOT__CONTROL__DOT__div;
            vlTOPp->fht_top__DOT__CONTROL__DOT__source_data 
                = __Vdly__fht_top__DOT__CONTROL__DOT__source_data;
            vlTOPp->fht_top__DOT__CONTROL__DOT__div_2 
                = __Vdly__fht_top__DOT__CONTROL__DOT__div_2;
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd 
                = __Vdly__fht_top__DOT__CONTROL__DOT__cnt_bias_rd;
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v0;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v1;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = 0U;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v3;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v4;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v5;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v6;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v7;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v8;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v9;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v10;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v11;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v12;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v13;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v14;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf__v15) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [0U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [1U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                            [2U] = 0U;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v0;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v1;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = 0U;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v3;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v4;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v5;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v6;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v7;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v8;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v9;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v10;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v11;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v12;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v13;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v14;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf__v15) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [0U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [1U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                            [2U] = 0U;
            }
            vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d 
                = __Vdly__fht_top__DOT__CONTROL__DOT__sec_part_subsec_d;
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v0;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v1;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v2;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [3U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v3;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v4;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v5;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v6;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [3U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v7;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [0U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v8;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [1U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v9;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [2U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v10;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [3U] = __Vdlyvval__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v11;
            }
            if (__Vdlyvset__fht_top__DOT__BUT_BLOCK__DOT__mux_buf__v12) {
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [0U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [1U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [2U] = 0U;
                vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                            [3U] = 0U;
            }
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [3U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf;
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [2U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf;
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [1U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf;
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX
                            [0U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf;
            vlTOPp->fht_top__DOT__ADDR_WR_CTRL[2U] 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d;
            vlTOPp->fht_top__DOT__ADDR_WR_CTRL[0U] 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d;
            vlTOPp->fht_top__DOT__ADDR_WR_CTRL[3U] 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias;
            vlTOPp->fht_top__DOT__ADDR_WR_CTRL[1U] 
                = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias;
            vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                   == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                       - (IData)(1U)));
            if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_data) {
                vlTOPp->fht_top__DOT__DATA_BUT[0U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
                    [0U];
                vlTOPp->fht_top__DOT__DATA_BUT[1U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
                    [1U];
                vlTOPp->fht_top__DOT__DATA_BUT[2U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
                    [2U];
                vlTOPp->fht_top__DOT__DATA_BUT[3U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
                    [3U];
            } else {
                vlTOPp->fht_top__DOT__DATA_BUT[0U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
                    [0U];
                vlTOPp->fht_top__DOT__DATA_BUT[1U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
                    [1U];
                vlTOPp->fht_top__DOT__DATA_BUT[2U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
                    [2U];
                vlTOPp->fht_top__DOT__DATA_BUT[3U] 
                    = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
                    [3U];
            }
            if (vlTOPp->iRESET) {
                if (vlTOPp->iSTART) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__rdy = 0U;
                } else {
                    if (((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                         & (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)))) {
                        vlTOPp->fht_top__DOT__CONTROL__DOT__rdy = 1U;
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__rdy = 1U;
            }
            if (vlTOPp->iRESET) {
                if (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD) 
                     & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2))) {
                    vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt = 0U;
                } else {
                    if (vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2) {
                        vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt 
                            = vlTOPp->fht_top__DOT__CONTROL__DOT__INC_ADDR_RD;
                    }
                }
            } else {
                vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt = 0U;
            }
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                            [2U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                [2U];
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                            [1U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                [1U];
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                            [0U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                [0U];
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                            [2U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                [2U];
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                            [1U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                [1U];
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                            [0U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                [0U];
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d 
                = ((IData)(vlTOPp->iRESET) ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)
                    : 0U);
            vlTOPp->fht_top__DOT__DATA_BUT_RAM[3U] 
                = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                [3U];
            vlTOPp->fht_top__DOT__DATA_BUT_RAM[2U] 
                = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                [2U];
            vlTOPp->fht_top__DOT__DATA_BUT_RAM[1U] 
                = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                [1U];
            vlTOPp->fht_top__DOT__DATA_BUT_RAM[0U] 
                = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                            [0U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                            [1U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                            [2U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                            [3U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                [3U];
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage 
                = __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage;
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time 
                = __Vdly__fht_top__DOT__CONTROL__DOT__cnt_stage_time;
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0 
                = (((QData)((IData)((7U & (- (IData)(
                                                     (1U 
                                                      & (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                                         [0U] 
                                                         >> 0x1aU))))))) 
                    << 0x26U) | ((QData)((IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                                 [0U])) 
                                 << 0xbU));
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0 
                = (((QData)((IData)((7U & (- (IData)(
                                                     (1U 
                                                      & (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                                         [0U] 
                                                         >> 0x1aU))))))) 
                    << 0x26U) | ((QData)((IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                                 [0U])) 
                                 << 0xbU));
            vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector 
                = __Vdly__fht_top__DOT__CONTROL__DOT__cnt_sector;
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                            [0U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                            [1U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                            [2U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                            [3U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                [3U];
            vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD 
                = ((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                   | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                      == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                          - (IData)(2U))));
            vlTOPp->oRDY = vlTOPp->fht_top__DOT__CONTROL__DOT__rdy;
            vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE 
                = ((0U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                   & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_STAGE 
                = (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time));
            vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
                   | (0x1ffU <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
                   | (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
                   | (0x200U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__INC_ADDR_RD 
                = (0x1ffU & ((IData)(1U) + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2 
                = ((IData)(vlTOPp->iRESET) & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__N_CLK_2));
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0) 
                                       + VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul)));
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0) 
                                       - VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul)));
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0) 
                                       + VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul)));
            vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0) 
                                       - VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD 
                = (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd) 
                    == (0x3ffU & (- ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd) 
                                     - (IData)(1U))))) 
                   & ((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                      | (1U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector))));
            vlTOPp->fht_top__DOT__CONTROL__DOT__N_CLK_2 
                = (1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS 
                = ((~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)) 
                   & (1U < (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS) 
                   & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)));
            vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD 
                = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS) 
                   & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector));
            if (vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN) {
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
            } else {
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
            }
            if (vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD) {
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
            } else {
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
                vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1U] 
                    = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
            }
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                            [0U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                            [1U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                            [2U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                            [3U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                [3U];
        }
        
        VL_INLINE_OPT void Vfht_top::_combo__TOP__3(Vfht_top__Syms* __restrict vlSymsp) {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_combo__TOP__3\n"); );
            Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
            // Body
            vlTOPp->fht_top__DOT__WE = ((0xcU & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                        | ((2U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                                    ? 
                                                   ((IData)(vlTOPp->iWE) 
                                                    >> 1U)
                                                    : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                                  << 1U)) 
                                           | (1U & 
                                              ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                                ? (IData)(vlTOPp->iWE)
                                                : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)))));
            vlTOPp->fht_top__DOT__WE = ((3U & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                        | ((8U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                                    ? 
                                                   ((IData)(vlTOPp->iWE) 
                                                    >> 3U)
                                                    : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                                  << 3U)) 
                                           | (4U & 
                                              (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                                 ? 
                                                ((IData)(vlTOPp->iWE) 
                                                 >> 2U)
                                                 : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                               << 2U))));
            if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont) {
                vlTOPp->fht_top__DOT__ADDR_WR[0U] = vlTOPp->iADDR_WR_0;
                vlTOPp->fht_top__DOT__ADDR_WR[1U] = vlTOPp->iADDR_WR_1;
                vlTOPp->fht_top__DOT__ADDR_WR[2U] = vlTOPp->iADDR_WR_2;
                vlTOPp->fht_top__DOT__ADDR_WR[3U] = vlTOPp->iADDR_WR_3;
                vlTOPp->fht_top__DOT__DATA_RAM_A[0U] 
                    = vlTOPp->iDATA_0;
                vlTOPp->fht_top__DOT__DATA_RAM_A[1U] 
                    = vlTOPp->iDATA_1;
                vlTOPp->fht_top__DOT__DATA_RAM_A[2U] 
                    = vlTOPp->iDATA_2;
                vlTOPp->fht_top__DOT__DATA_RAM_A[3U] 
                    = vlTOPp->iDATA_3;
                vlTOPp->fht_top__DOT__ADDR_RD[0U] = vlTOPp->iADDR_RD_0;
                vlTOPp->fht_top__DOT__ADDR_RD[1U] = vlTOPp->iADDR_RD_1;
                vlTOPp->fht_top__DOT__ADDR_RD[2U] = vlTOPp->iADDR_RD_2;
                vlTOPp->fht_top__DOT__ADDR_RD[3U] = vlTOPp->iADDR_RD_3;
            } else {
                vlTOPp->fht_top__DOT__ADDR_WR[0U] = 
                    vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                    [0U];
                vlTOPp->fht_top__DOT__ADDR_WR[1U] = 
                    vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                    [1U];
                vlTOPp->fht_top__DOT__ADDR_WR[2U] = 
                    vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                    [2U];
                vlTOPp->fht_top__DOT__ADDR_WR[3U] = 
                    vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                    [3U];
                vlTOPp->fht_top__DOT__DATA_RAM_A[0U] 
                    = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                    [0U];
                vlTOPp->fht_top__DOT__DATA_RAM_A[1U] 
                    = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                    [1U];
                vlTOPp->fht_top__DOT__DATA_RAM_A[2U] 
                    = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                    [2U];
                vlTOPp->fht_top__DOT__DATA_RAM_A[3U] 
                    = vlTOPp->fht_top__DOT__DATA_BUT_RAM
                    [3U];
                vlTOPp->fht_top__DOT__ADDR_RD[0U] = 
                    vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                    [0U];
                vlTOPp->fht_top__DOT__ADDR_RD[1U] = 
                    vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                    [1U];
                vlTOPp->fht_top__DOT__ADDR_RD[2U] = 
                    vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                    [2U];
                vlTOPp->fht_top__DOT__ADDR_RD[3U] = 
                    vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                    [3U];
            }
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                            [0U] = vlTOPp->fht_top__DOT__ADDR_WR
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                            [1U] = vlTOPp->fht_top__DOT__ADDR_WR
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                            [2U] = vlTOPp->fht_top__DOT__ADDR_WR
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                            [3U] = vlTOPp->fht_top__DOT__ADDR_WR
                [3U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                            [0U] = vlTOPp->fht_top__DOT__DATA_RAM_A
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                            [1U] = vlTOPp->fht_top__DOT__DATA_RAM_A
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                            [2U] = vlTOPp->fht_top__DOT__DATA_RAM_A
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                            [3U] = vlTOPp->fht_top__DOT__DATA_RAM_A
                [3U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                            [0U] = vlTOPp->fht_top__DOT__ADDR_RD
                [0U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                            [1U] = vlTOPp->fht_top__DOT__ADDR_RD
                [1U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                            [2U] = vlTOPp->fht_top__DOT__ADDR_RD
                [2U];
            vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                            [3U] = vlTOPp->fht_top__DOT__ADDR_RD
                [3U];
        }
        
        void Vfht_top::_eval(Vfht_top__Syms* __restrict vlSymsp) {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_eval\n"); );
            Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
            // Body
            if ((((IData)(vlTOPp->iCLK) & (~ (IData)(vlTOPp->__Vclklast__TOP__iCLK))) 
                 | ((~ (IData)(vlTOPp->iRESET)) & (IData)(vlTOPp->__Vclklast__TOP__iRESET)))) {
                vlTOPp->_sequent__TOP__2(vlSymsp);
                vlTOPp->__Vm_traceActivity[1U] = 1U;
            }
            vlTOPp->_combo__TOP__3(vlSymsp);
            vlTOPp->__Vm_traceActivity[2U] = 1U;
            // Final
            vlTOPp->__Vclklast__TOP__iCLK = vlTOPp->iCLK;
            vlTOPp->__Vclklast__TOP__iRESET = vlTOPp->iRESET;
        }
        
        VL_INLINE_OPT QData Vfht_top::_change_request(Vfht_top__Syms* __restrict vlSymsp) {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_change_request\n"); );
            Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
            // Body
            return (vlTOPp->_change_request_1(vlSymsp));
        }
        
        VL_INLINE_OPT QData Vfht_top::_change_request_1(Vfht_top__Syms* __restrict vlSymsp) {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_change_request_1\n"); );
            Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
            // Body
            // Change detection
            QData __req = false;  // Logically a bool
            return __req;
        }
        
#ifdef VL_DEBUG
        void Vfht_top::_eval_debug_assertions() {
            VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_eval_debug_assertions\n"); );
            // Body
            if (VL_UNLIKELY((iCLK & 0xfeU))) {
                Verilated::overWidthError("iCLK");}
            if (VL_UNLIKELY((iRESET & 0xfeU))) {
                Verilated::overWidthError("iRESET");}
            if (VL_UNLIKELY((iSTART & 0xfeU))) {
                Verilated::overWidthError("iSTART");}
            if (VL_UNLIKELY((iWE & 0xf0U))) {
                Verilated::overWidthError("iWE");}
            if (VL_UNLIKELY((iDATA_0 & 0xf8000000U))) {
                Verilated::overWidthError("iDATA_0");}
            if (VL_UNLIKELY((iDATA_1 & 0xf8000000U))) {
                Verilated::overWidthError("iDATA_1");}
            if (VL_UNLIKELY((iDATA_2 & 0xf8000000U))) {
                Verilated::overWidthError("iDATA_2");}
            if (VL_UNLIKELY((iDATA_3 & 0xf8000000U))) {
                Verilated::overWidthError("iDATA_3");}
            if (VL_UNLIKELY((iADDR_WR_0 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_WR_0");}
            if (VL_UNLIKELY((iADDR_WR_1 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_WR_1");}
            if (VL_UNLIKELY((iADDR_WR_2 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_WR_2");}
            if (VL_UNLIKELY((iADDR_WR_3 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_WR_3");}
            if (VL_UNLIKELY((iADDR_RD_0 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_RD_0");}
            if (VL_UNLIKELY((iADDR_RD_1 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_RD_1");}
            if (VL_UNLIKELY((iADDR_RD_2 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_RD_2");}
            if (VL_UNLIKELY((iADDR_RD_3 & 0xfe00U))) {
                Verilated::overWidthError("iADDR_RD_3");}
        }
#endif  // VL_DEBUG
