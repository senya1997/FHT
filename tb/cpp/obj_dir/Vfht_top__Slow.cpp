// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vfht_top.h for the primary calling header

#include "Vfht_top.h"
#include "Vfht_top__Syms.h"

//==========

Vfht_top::Vfht_top(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModule{_vcname__}
 {
    Vfht_top__Syms* __restrict vlSymsp = __VlSymsp = new Vfht_top__Syms(_vcontextp__, this, name());
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vfht_top::__Vconfigure(Vfht_top__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    vlSymsp->_vm_contextp__->timeunit(-9);
    vlSymsp->_vm_contextp__->timeprecision(-9);
}

Vfht_top::~Vfht_top() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = nullptr);
}

void Vfht_top::_settle__TOP__1(Vfht_top__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_settle__TOP__1\n"); );
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[0U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[1U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[2U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[3U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[0U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[1U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[2U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[3U] 
        = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0;
    vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
           == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
               - (IData)(1U)));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[1U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf;
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[0U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf;
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[3U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf;
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[2U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf;
    vlTOPp->fht_top__DOT__WE = ((0xeU & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                | (1U & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                          ? (IData)(vlTOPp->iWE)
                                          : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a))));
    vlTOPp->fht_top__DOT__WE = ((0xdU & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                | (2U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                           ? ((IData)(vlTOPp->iWE) 
                                              >> 1U)
                                           : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                         << 1U)));
    vlTOPp->fht_top__DOT__WE = ((0xbU & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                | (4U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                           ? ((IData)(vlTOPp->iWE) 
                                              >> 2U)
                                           : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                         << 2U)));
    vlTOPp->fht_top__DOT__WE = ((7U & (IData)(vlTOPp->fht_top__DOT__WE)) 
                                | (8U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont)
                                           ? ((IData)(vlTOPp->iWE) 
                                              >> 3U)
                                           : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a)) 
                                         << 3U)));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[2U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
        [2U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[1U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
        [1U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[0U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
        [0U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[2U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
        [2U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[1U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
        [1U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[0U] 
        = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
        [0U];
    vlTOPp->fht_top__DOT__ADDR_WR_CTRL[3U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias;
    vlTOPp->fht_top__DOT__ADDR_WR_CTRL[2U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d;
    vlTOPp->fht_top__DOT__ADDR_WR_CTRL[1U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias;
    vlTOPp->fht_top__DOT__ADDR_WR_CTRL[0U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d;
    vlTOPp->fht_top__DOT__DATA_BUT_RAM[3U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
        [3U];
    vlTOPp->fht_top__DOT__DATA_BUT_RAM[2U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
        [2U];
    vlTOPp->fht_top__DOT__DATA_BUT_RAM[1U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
        [1U];
    vlTOPp->fht_top__DOT__DATA_BUT_RAM[0U] = vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
        [0U];
    vlTOPp->oRDY = vlTOPp->fht_top__DOT__CONTROL__DOT__rdy;
    vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_STAGE = 
        (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time));
    vlTOPp->fht_top__DOT__CONTROL__DOT__INC_ADDR_RD 
        = (0x1ffU & ((IData)(1U) + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE 
        = ((0U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
           & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
           | (0x1ffU <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
           | (0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy) 
           | (0x200U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD 
        = ((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
           | ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
              == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                  - (IData)(2U))));
    vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD 
        = (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd) 
            == (0x3ffU & (- ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd) 
                             - (IData)(1U))))) & ((0xaU 
                                                   == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)) 
                                                  | (1U 
                                                     <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector))));
    vlTOPp->fht_top__DOT__CONTROL__DOT__N_CLK_2 = (1U 
                                                   & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS = (
                                                   (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)) 
                                                   & (1U 
                                                      < (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)));
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[3U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [3U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[2U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [2U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[1U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [1U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[0U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [0U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[3U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [3U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[2U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [2U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[1U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [1U];
    vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[0U] = vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
        [0U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[3U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [3U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[2U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [2U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[1U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [1U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[0U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [0U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[3U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [3U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[2U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [2U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[1U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [1U];
    vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[0U] = vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
        [0U];
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0 
        = (((QData)((IData)((7U & (- (IData)((1U & 
                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                               [0U] 
                                               >> 0x1aU))))))) 
            << 0x26U) | ((QData)((IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                         [0U])) << 0xbU));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0 
        = (((QData)((IData)((7U & (- (IData)((1U & 
                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                               [0U] 
                                               >> 0x1aU))))))) 
            << 0x26U) | ((QData)((IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                         [0U])) << 0xbU));
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[0U] 
        = vlTOPp->fht_top__DOT__ADDR_WR_CTRL[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[1U] 
        = vlTOPp->fht_top__DOT__ADDR_WR_CTRL[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[2U] 
        = vlTOPp->fht_top__DOT__ADDR_WR_CTRL[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[3U] 
        = vlTOPp->fht_top__DOT__ADDR_WR_CTRL[3U];
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont) {
        vlTOPp->fht_top__DOT__ADDR_WR[0U] = vlTOPp->iADDR_WR_0;
        vlTOPp->fht_top__DOT__ADDR_WR[1U] = vlTOPp->iADDR_WR_1;
        vlTOPp->fht_top__DOT__ADDR_WR[2U] = vlTOPp->iADDR_WR_2;
        vlTOPp->fht_top__DOT__ADDR_WR[3U] = vlTOPp->iADDR_WR_3;
    } else {
        vlTOPp->fht_top__DOT__ADDR_WR[0U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
            [0U];
        vlTOPp->fht_top__DOT__ADDR_WR[1U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
            [1U];
        vlTOPp->fht_top__DOT__ADDR_WR[2U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
            [2U];
        vlTOPp->fht_top__DOT__ADDR_WR[3U] = vlTOPp->fht_top__DOT__ADDR_WR_CTRL
            [3U];
    }
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[0U] 
        = vlTOPp->fht_top__DOT__DATA_BUT_RAM[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[1U] 
        = vlTOPp->fht_top__DOT__DATA_BUT_RAM[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[2U] 
        = vlTOPp->fht_top__DOT__DATA_BUT_RAM[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[3U] 
        = vlTOPp->fht_top__DOT__DATA_BUT_RAM[3U];
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont) {
        vlTOPp->fht_top__DOT__DATA_RAM_A[0U] = vlTOPp->iDATA_0;
        vlTOPp->fht_top__DOT__DATA_RAM_A[1U] = vlTOPp->iDATA_1;
        vlTOPp->fht_top__DOT__DATA_RAM_A[2U] = vlTOPp->iDATA_2;
        vlTOPp->fht_top__DOT__DATA_RAM_A[3U] = vlTOPp->iDATA_3;
    } else {
        vlTOPp->fht_top__DOT__DATA_RAM_A[0U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
            [0U];
        vlTOPp->fht_top__DOT__DATA_RAM_A[1U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
            [1U];
        vlTOPp->fht_top__DOT__DATA_RAM_A[2U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
            [2U];
        vlTOPp->fht_top__DOT__DATA_RAM_A[3U] = vlTOPp->fht_top__DOT__DATA_BUT_RAM
            [3U];
    }
    vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS) 
           & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector)));
    vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD 
        = ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS) 
           & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector));
    vlTOPp->oDATA_0 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [0U];
    vlTOPp->oDATA_1 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [1U];
    vlTOPp->oDATA_2 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [2U];
    vlTOPp->oDATA_3 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [3U];
    vlTOPp->oDATA_0 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [0U];
    vlTOPp->oDATA_1 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [1U];
    vlTOPp->oDATA_2 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [2U];
    vlTOPp->oDATA_3 = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
        [3U];
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_data) {
        vlTOPp->fht_top__DOT__DATA_BUT[0U] = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
            [0U];
        vlTOPp->fht_top__DOT__DATA_BUT[1U] = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
            [1U];
        vlTOPp->fht_top__DOT__DATA_BUT[2U] = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
            [2U];
        vlTOPp->fht_top__DOT__DATA_BUT[3U] = vlTOPp->fht_top__DOT__DATA_RAM_B_BUT
            [3U];
    } else {
        vlTOPp->fht_top__DOT__DATA_BUT[0U] = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
            [0U];
        vlTOPp->fht_top__DOT__DATA_BUT[1U] = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
            [1U];
        vlTOPp->fht_top__DOT__DATA_BUT[2U] = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
            [2U];
        vlTOPp->fht_top__DOT__DATA_BUT[3U] = vlTOPp->fht_top__DOT__DATA_RAM_A_BUT
            [3U];
    }
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
        = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0) 
                               + VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul)));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
        = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0) 
                               - VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul)));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
        = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0) 
                               + VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul)));
    vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
        = (0x3ffffffffffULL & (VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0) 
                               - VL_EXTENDS_QQ(42,41, vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul)));
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[0U] 
        = vlTOPp->fht_top__DOT__ADDR_WR[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[1U] 
        = vlTOPp->fht_top__DOT__ADDR_WR[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[2U] 
        = vlTOPp->fht_top__DOT__ADDR_WR[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[3U] 
        = vlTOPp->fht_top__DOT__ADDR_WR[3U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[0U] 
        = vlTOPp->fht_top__DOT__DATA_RAM_A[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[1U] 
        = vlTOPp->fht_top__DOT__DATA_RAM_A[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[2U] 
        = vlTOPp->fht_top__DOT__DATA_RAM_A[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[3U] 
        = vlTOPp->fht_top__DOT__DATA_RAM_A[3U];
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN) {
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
    } else {
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
    }
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD) {
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias;
    } else {
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
        vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1U] = vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
    }
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[0U] 
        = vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[1U] 
        = vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[2U] 
        = vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[3U] 
        = vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3U];
    if (vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont) {
        vlTOPp->fht_top__DOT__ADDR_RD[0U] = vlTOPp->iADDR_RD_0;
        vlTOPp->fht_top__DOT__ADDR_RD[1U] = vlTOPp->iADDR_RD_1;
        vlTOPp->fht_top__DOT__ADDR_RD[2U] = vlTOPp->iADDR_RD_2;
        vlTOPp->fht_top__DOT__ADDR_RD[3U] = vlTOPp->iADDR_RD_3;
    } else {
        vlTOPp->fht_top__DOT__ADDR_RD[0U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
            [0U];
        vlTOPp->fht_top__DOT__ADDR_RD[1U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
            [1U];
        vlTOPp->fht_top__DOT__ADDR_RD[2U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
            [2U];
        vlTOPp->fht_top__DOT__ADDR_RD[3U] = vlTOPp->fht_top__DOT__ADDR_RD_CTRL
            [3U];
    }
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[0U] 
        = vlTOPp->fht_top__DOT__ADDR_RD[0U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[1U] 
        = vlTOPp->fht_top__DOT__ADDR_RD[1U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[2U] 
        = vlTOPp->fht_top__DOT__ADDR_RD[2U];
    vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[3U] 
        = vlTOPp->fht_top__DOT__ADDR_RD[3U];
}

void Vfht_top::_eval_initial(Vfht_top__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_eval_initial\n"); );
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__iCLK = vlTOPp->iCLK;
    vlTOPp->__Vclklast__TOP__iRESET = vlTOPp->iRESET;
}

void Vfht_top::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::final\n"); );
    // Variables
    Vfht_top__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vfht_top::_eval_settle(Vfht_top__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_eval_settle\n"); );
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__1(vlSymsp);
    vlTOPp->__Vm_traceActivity[2U] = 1U;
    vlTOPp->__Vm_traceActivity[1U] = 1U;
    vlTOPp->__Vm_traceActivity[0U] = 1U;
}

void Vfht_top::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vfht_top::_ctor_var_reset\n"); );
    // Body
    iCLK = VL_RAND_RESET_I(1);
    iRESET = VL_RAND_RESET_I(1);
    iSTART = VL_RAND_RESET_I(1);
    iWE = VL_RAND_RESET_I(4);
    iDATA_0 = VL_RAND_RESET_I(27);
    iDATA_1 = VL_RAND_RESET_I(27);
    iDATA_2 = VL_RAND_RESET_I(27);
    iDATA_3 = VL_RAND_RESET_I(27);
    iADDR_WR_0 = VL_RAND_RESET_I(9);
    iADDR_WR_1 = VL_RAND_RESET_I(9);
    iADDR_WR_2 = VL_RAND_RESET_I(9);
    iADDR_WR_3 = VL_RAND_RESET_I(9);
    iADDR_RD_0 = VL_RAND_RESET_I(9);
    iADDR_RD_1 = VL_RAND_RESET_I(9);
    iADDR_RD_2 = VL_RAND_RESET_I(9);
    iADDR_RD_3 = VL_RAND_RESET_I(9);
    oDATA_0 = VL_RAND_RESET_I(27);
    oDATA_1 = VL_RAND_RESET_I(27);
    oDATA_2 = VL_RAND_RESET_I(27);
    oDATA_3 = VL_RAND_RESET_I(27);
    oRDY = VL_RAND_RESET_I(1);
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__DATA_RAM_A[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__DATA_BUT[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__ADDR_RD_CTRL[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__ADDR_WR_CTRL[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__ADDR_RD[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__ADDR_WR[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__DATA_RAM_A_BUT[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__DATA_RAM_B_BUT[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__DATA_BUT_RAM[__Vi0] = VL_RAND_RESET_I(27);
    }
    fht_top__DOT__WE = VL_RAND_RESET_I(4);
    fht_top__DOT__CONTROL__DOT__clk_2 = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__N_CLK_2 = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__cnt_stage = VL_RAND_RESET_I(4);
    fht_top__DOT__CONTROL__DOT__cnt_stage_time = VL_RAND_RESET_I(10);
    fht_top__DOT__CONTROL__DOT__div = VL_RAND_RESET_I(10);
    fht_top__DOT__CONTROL__DOT__div_2 = VL_RAND_RESET_I(4);
    fht_top__DOT__CONTROL__DOT__cnt_sector = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__cnt_sector_d = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__cnt_sector_time = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__size_bias_rd = VL_RAND_RESET_I(10);
    fht_top__DOT__CONTROL__DOT__cnt_bias_rd = VL_RAND_RESET_I(10);
    fht_top__DOT__CONTROL__DOT__addr_rd_cnt = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__addr_rd_bias = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__addr_wr_cnt = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__addr_wr_bias = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__addr_coef_cnt = VL_RAND_RESET_I(7);
    fht_top__DOT__CONTROL__DOT__addr_coef = VL_RAND_RESET_I(7);
    fht_top__DOT__CONTROL__DOT__sec_part_subsec_d = VL_RAND_RESET_I(4);
    fht_top__DOT__CONTROL__DOT__we_a = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__we_b = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__source_data = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__source_cont = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__rdy = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__ZERO_STAGE = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__EOF_STAGE = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__EOF_SECTOR = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__RESET_CNT_RD = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__RESET_CNT_WR = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__INC_ADDR_RD = VL_RAND_RESET_I(9);
    fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__EN_BIAS = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD = VL_RAND_RESET_I(1);
    fht_top__DOT__CONTROL__DOT____Vlvbound1 = VL_RAND_RESET_I(1);
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__sin[__Vi0] = VL_RAND_RESET_I(13);
    }
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__cos[__Vi0] = VL_RAND_RESET_I(13);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__mux_buf[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[__Vi0] = VL_RAND_RESET_I(27);
    }
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul = VL_RAND_RESET_Q(41);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf = VL_RAND_RESET_I(27);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf = VL_RAND_RESET_I(27);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0 = VL_RAND_RESET_Q(41);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM = VL_RAND_RESET_Q(42);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB = VL_RAND_RESET_Q(42);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul = VL_RAND_RESET_Q(41);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf = VL_RAND_RESET_I(27);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf = VL_RAND_RESET_I(27);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0 = VL_RAND_RESET_Q(41);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM = VL_RAND_RESET_Q(42);
    fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB = VL_RAND_RESET_Q(42);
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[__Vi0] = VL_RAND_RESET_I(27);
    }
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[__Vi0] = VL_RAND_RESET_I(27);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[__Vi0] = VL_RAND_RESET_I(9);
    }
    for (int __Vi0=0; __Vi0<4; ++__Vi0) {
        fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[__Vi0] = VL_RAND_RESET_I(27);
    }
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0 = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a = VL_RAND_RESET_I(27);
    fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0 = VL_RAND_RESET_I(13);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__q_b = VL_RAND_RESET_I(1);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0 = VL_RAND_RESET_I(13);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__q_b = VL_RAND_RESET_I(1);
    fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__eccstatus = VL_RAND_RESET_I(3);
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
