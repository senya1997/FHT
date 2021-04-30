// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vfht_top__Syms.h"


void Vfht_top::traceChgTop0(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        vlTOPp->traceChgSub0(userp, tracep);
    }
}

void Vfht_top::traceChgSub0(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[0U])) {
            tracep->chgIData(oldp+0,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[0]),27);
            tracep->chgIData(oldp+1,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[1]),27);
            tracep->chgIData(oldp+2,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[2]),27);
            tracep->chgIData(oldp+3,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[3]),27);
            tracep->chgIData(oldp+4,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[0]),27);
            tracep->chgIData(oldp+5,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[1]),27);
            tracep->chgIData(oldp+6,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[2]),27);
            tracep->chgIData(oldp+7,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[3]),27);
            tracep->chgIData(oldp+8,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                     [0U]),27);
            tracep->chgIData(oldp+9,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                     [1U]),27);
            tracep->chgIData(oldp+10,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                      [2U]),27);
            tracep->chgIData(oldp+11,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                      [3U]),27);
            tracep->chgIData(oldp+12,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[0]),27);
            tracep->chgIData(oldp+13,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[1]),27);
            tracep->chgIData(oldp+14,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[2]),27);
            tracep->chgIData(oldp+15,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[3]),27);
            tracep->chgIData(oldp+16,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                      [0U]),27);
            tracep->chgIData(oldp+17,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                      [1U]),27);
            tracep->chgIData(oldp+18,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                      [2U]),27);
            tracep->chgIData(oldp+19,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                      [3U]),27);
            tracep->chgIData(oldp+20,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[0]),27);
            tracep->chgIData(oldp+21,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[1]),27);
            tracep->chgIData(oldp+22,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[2]),27);
            tracep->chgIData(oldp+23,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[3]),27);
        }
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[1U])) {
            tracep->chgBit(oldp+24,(vlTOPp->fht_top__DOT__CONTROL__DOT__source_data));
            tracep->chgBit(oldp+25,(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont));
            tracep->chgBit(oldp+26,(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy));
            tracep->chgIData(oldp+27,(vlTOPp->fht_top__DOT__DATA_BUT[0]),27);
            tracep->chgIData(oldp+28,(vlTOPp->fht_top__DOT__DATA_BUT[1]),27);
            tracep->chgIData(oldp+29,(vlTOPp->fht_top__DOT__DATA_BUT[2]),27);
            tracep->chgIData(oldp+30,(vlTOPp->fht_top__DOT__DATA_BUT[3]),27);
            tracep->chgSData(oldp+31,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0]),9);
            tracep->chgSData(oldp+32,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1]),9);
            tracep->chgSData(oldp+33,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2]),9);
            tracep->chgSData(oldp+34,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3]),9);
            tracep->chgSData(oldp+35,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[0]),9);
            tracep->chgSData(oldp+36,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[1]),9);
            tracep->chgSData(oldp+37,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[2]),9);
            tracep->chgSData(oldp+38,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[3]),9);
            tracep->chgIData(oldp+39,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[0]),27);
            tracep->chgIData(oldp+40,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[1]),27);
            tracep->chgIData(oldp+41,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[2]),27);
            tracep->chgIData(oldp+42,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[3]),27);
            tracep->chgBit(oldp+43,(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a));
            tracep->chgBit(oldp+44,(vlTOPp->fht_top__DOT__CONTROL__DOT__we_b));
            tracep->chgBit(oldp+45,(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE));
            tracep->chgBit(oldp+46,((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))));
            tracep->chgBit(oldp+47,((1U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                            >> 3U) 
                                           & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE))))));
            tracep->chgSData(oldp+48,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d),9);
            tracep->chgCData(oldp+49,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef),7);
            tracep->chgSData(oldp+50,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                                        ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)
                                        : (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0))),13);
            tracep->chgSData(oldp+51,((0x1fffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                                                   ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0)
                                                   : 
                                                  ((IData)(1U) 
                                                   + 
                                                   (~ (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)))))),13);
            tracep->chgSData(oldp+52,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN)
                                        ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias)
                                        : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))),9);
            tracep->chgSData(oldp+53,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD)
                                        ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias)
                                        : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))),9);
            tracep->chgSData(oldp+54,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d),9);
            tracep->chgSData(oldp+55,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias),9);
            tracep->chgBit(oldp+56,(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2));
            tracep->chgBit(oldp+57,((1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)))));
            tracep->chgCData(oldp+58,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage),4);
            tracep->chgSData(oldp+59,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time),10);
            tracep->chgSData(oldp+60,(vlTOPp->fht_top__DOT__CONTROL__DOT__div),10);
            tracep->chgCData(oldp+61,(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2),4);
            tracep->chgSData(oldp+62,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector),9);
            tracep->chgSData(oldp+63,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time),9);
            tracep->chgSData(oldp+64,(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd),10);
            tracep->chgSData(oldp+65,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd),10);
            tracep->chgSData(oldp+66,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt),9);
            tracep->chgSData(oldp+67,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias),9);
            tracep->chgSData(oldp+68,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt),9);
            tracep->chgCData(oldp+69,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt),7);
            tracep->chgCData(oldp+70,(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d),4);
            tracep->chgBit(oldp+71,((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+72,((1U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+73,((0x1ffU <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+74,((0x200U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+75,((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+76,((0x201U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
            tracep->chgBit(oldp+77,(vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR));
            tracep->chgBit(oldp+78,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                                     == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                         - (IData)(2U)))));
            tracep->chgBit(oldp+79,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                                     >= (0x3ffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                   >> 1U)))));
            tracep->chgBit(oldp+80,((1U & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                           >> 3U))));
            tracep->chgBit(oldp+81,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD));
            tracep->chgBit(oldp+82,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR));
            tracep->chgBit(oldp+83,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF));
            tracep->chgBit(oldp+84,((1U & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))));
            tracep->chgBit(oldp+85,((1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)))));
            tracep->chgSData(oldp+86,((0x1ffU & ((IData)(1U) 
                                                 + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt)))),9);
            tracep->chgSData(oldp+87,((0x7ffU & ((0x1ffU 
                                                  & ((IData)(1U) 
                                                     + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))) 
                                                 + 
                                                 ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd) 
                                                  << (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2))))),11);
            tracep->chgSData(oldp+88,((0x1ffU & ((8U 
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
                                                   >> 1U))))),9);
            tracep->chgBit(oldp+89,(vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD));
            tracep->chgBit(oldp+90,(vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD));
            tracep->chgBit(oldp+91,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS));
            tracep->chgBit(oldp+92,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN));
            tracep->chgBit(oldp+93,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD));
            tracep->chgIData(oldp+94,(vlTOPp->fht_top__DOT__DATA_BUT
                                      [0U]),27);
            tracep->chgIData(oldp+95,(vlTOPp->fht_top__DOT__DATA_BUT
                                      [1U]),27);
            tracep->chgIData(oldp+96,(vlTOPp->fht_top__DOT__DATA_BUT
                                      [2U]),27);
            tracep->chgIData(oldp+97,(vlTOPp->fht_top__DOT__DATA_BUT
                                      [3U]),27);
            tracep->chgIData(oldp+98,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                      [0U]),27);
            tracep->chgIData(oldp+99,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                      [1U]),27);
            tracep->chgIData(oldp+100,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                       [2U]),27);
            tracep->chgIData(oldp+101,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                       [3U]),27);
            tracep->chgSData(oldp+102,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin[0]),13);
            tracep->chgSData(oldp+103,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin[1]),13);
            tracep->chgSData(oldp+104,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos[0]),13);
            tracep->chgSData(oldp+105,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos[1]),13);
            tracep->chgIData(oldp+106,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[0]),27);
            tracep->chgIData(oldp+107,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[1]),27);
            tracep->chgIData(oldp+108,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[2]),27);
            tracep->chgIData(oldp+109,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[3]),27);
            tracep->chgIData(oldp+110,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[0]),27);
            tracep->chgIData(oldp+111,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[1]),27);
            tracep->chgIData(oldp+112,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[2]),27);
            tracep->chgIData(oldp+113,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[0]),27);
            tracep->chgIData(oldp+114,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[1]),27);
            tracep->chgIData(oldp+115,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[2]),27);
            tracep->chgIData(oldp+116,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[0]),27);
            tracep->chgIData(oldp+117,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[1]),27);
            tracep->chgIData(oldp+118,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[2]),27);
            tracep->chgIData(oldp+119,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[3]),27);
            tracep->chgIData(oldp+120,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                       [0U]),27);
            tracep->chgIData(oldp+121,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                       [1U]),27);
            tracep->chgIData(oldp+122,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                       [2U]),27);
            tracep->chgIData(oldp+123,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[0]),27);
            tracep->chgIData(oldp+124,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[1]),27);
            tracep->chgIData(oldp+125,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[2]),27);
            tracep->chgIData(oldp+126,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                       [0U]),27);
            tracep->chgIData(oldp+127,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                       [1U]),27);
            tracep->chgIData(oldp+128,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                       [2U]),27);
            tracep->chgIData(oldp+129,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[0]),27);
            tracep->chgIData(oldp+130,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[1]),27);
            tracep->chgIData(oldp+131,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[2]),27);
            tracep->chgIData(oldp+132,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                       [0U]),27);
            tracep->chgIData(oldp+133,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                       [1U]),27);
            tracep->chgIData(oldp+134,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                       [2U]),27);
            tracep->chgSData(oldp+135,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                       [0U]),13);
            tracep->chgSData(oldp+136,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                       [0U]),13);
            tracep->chgIData(oldp+137,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf),27);
            tracep->chgIData(oldp+138,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf),27);
            tracep->chgQData(oldp+139,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul),41);
            tracep->chgQData(oldp+141,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0),41);
            tracep->chgQData(oldp+143,((0x1ffffffffffULL 
                                        & (VL_MULS_QQQ(41,41,41, 
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
                                                                          [0U])))))),41);
            tracep->chgQData(oldp+145,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM),42);
            tracep->chgQData(oldp+147,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB),42);
            tracep->chgBit(oldp+149,((IData)((0x800ULL 
                                              == (0x4000000800ULL 
                                                  & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM)))));
            tracep->chgBit(oldp+150,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                               >> 0x26U)) 
                                      & (0x800U < (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM))))));
            tracep->chgBit(oldp+151,((IData)((0x800ULL 
                                              == (0x4000000800ULL 
                                                  & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB)))));
            tracep->chgBit(oldp+152,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                               >> 0x26U)) 
                                      & (0x800U < (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB))))));
            tracep->chgIData(oldp+153,((0x7ffffffU 
                                        & ((1U & ((IData)(
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
                                            : (IData)(
                                                      (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                       >> 0xcU))))),27);
            tracep->chgIData(oldp+154,((0x7ffffffU 
                                        & ((1U & ((IData)(
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
                                            : (IData)(
                                                      (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                       >> 0xcU))))),27);
            tracep->chgIData(oldp+155,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                       [0U]),27);
            tracep->chgIData(oldp+156,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                       [1U]),27);
            tracep->chgIData(oldp+157,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                       [2U]),27);
            tracep->chgSData(oldp+158,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                       [1U]),13);
            tracep->chgSData(oldp+159,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                       [1U]),13);
            tracep->chgIData(oldp+160,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf),27);
            tracep->chgIData(oldp+161,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf),27);
            tracep->chgQData(oldp+162,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul),41);
            tracep->chgQData(oldp+164,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0),41);
            tracep->chgQData(oldp+166,((0x1ffffffffffULL 
                                        & (VL_MULS_QQQ(41,41,41, 
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
                                                                          [1U])))))),41);
            tracep->chgQData(oldp+168,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM),42);
            tracep->chgQData(oldp+170,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB),42);
            tracep->chgBit(oldp+172,((IData)((0x800ULL 
                                              == (0x4000000800ULL 
                                                  & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM)))));
            tracep->chgBit(oldp+173,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                               >> 0x26U)) 
                                      & (0x800U < (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM))))));
            tracep->chgBit(oldp+174,((IData)((0x800ULL 
                                              == (0x4000000800ULL 
                                                  & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB)))));
            tracep->chgBit(oldp+175,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                               >> 0x26U)) 
                                      & (0x800U < (0xfffU 
                                                   & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB))))));
            tracep->chgIData(oldp+176,((0x7ffffffU 
                                        & ((1U & ((IData)(
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
                                            : (IData)(
                                                      (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                       >> 0xcU))))),27);
            tracep->chgIData(oldp+177,((0x7ffffffU 
                                        & ((1U & ((IData)(
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
                                            : (IData)(
                                                      (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                       >> 0xcU))))),27);
            tracep->chgIData(oldp+178,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                       [0U]),27);
            tracep->chgIData(oldp+179,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                       [1U]),27);
            tracep->chgIData(oldp+180,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                       [2U]),27);
            tracep->chgIData(oldp+181,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                       [3U]),27);
            tracep->chgSData(oldp+182,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                       [0U]),9);
            tracep->chgSData(oldp+183,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                       [1U]),9);
            tracep->chgSData(oldp+184,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                       [2U]),9);
            tracep->chgSData(oldp+185,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                       [3U]),9);
            tracep->chgSData(oldp+186,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                       [0U]),9);
            tracep->chgSData(oldp+187,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                       [1U]),9);
            tracep->chgSData(oldp+188,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                       [2U]),9);
            tracep->chgSData(oldp+189,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                       [3U]),9);
            tracep->chgIData(oldp+190,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[0]),27);
            tracep->chgIData(oldp+191,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[1]),27);
            tracep->chgIData(oldp+192,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[2]),27);
            tracep->chgIData(oldp+193,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[3]),27);
            tracep->chgSData(oldp+194,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[0]),9);
            tracep->chgSData(oldp+195,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[1]),9);
            tracep->chgSData(oldp+196,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[2]),9);
            tracep->chgSData(oldp+197,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[3]),9);
            tracep->chgSData(oldp+198,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[0]),9);
            tracep->chgSData(oldp+199,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[1]),9);
            tracep->chgSData(oldp+200,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[2]),9);
            tracep->chgSData(oldp+201,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[3]),9);
            tracep->chgCData(oldp+202,((0xfU & (- (IData)((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_b))))),4);
            tracep->chgIData(oldp+203,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                       [0U]),27);
            tracep->chgSData(oldp+204,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                       [0U]),9);
            tracep->chgSData(oldp+205,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                       [0U]),9);
            tracep->chgIData(oldp+206,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                       [1U]),27);
            tracep->chgSData(oldp+207,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                       [1U]),9);
            tracep->chgSData(oldp+208,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                       [1U]),9);
            tracep->chgIData(oldp+209,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                       [2U]),27);
            tracep->chgSData(oldp+210,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                       [2U]),9);
            tracep->chgSData(oldp+211,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                       [2U]),9);
            tracep->chgIData(oldp+212,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                       [3U]),27);
            tracep->chgSData(oldp+213,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                       [3U]),9);
            tracep->chgSData(oldp+214,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                       [3U]),9);
        }
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[2U])) {
            tracep->chgIData(oldp+215,(vlTOPp->fht_top__DOT__DATA_RAM_A[0]),27);
            tracep->chgIData(oldp+216,(vlTOPp->fht_top__DOT__DATA_RAM_A[1]),27);
            tracep->chgIData(oldp+217,(vlTOPp->fht_top__DOT__DATA_RAM_A[2]),27);
            tracep->chgIData(oldp+218,(vlTOPp->fht_top__DOT__DATA_RAM_A[3]),27);
            tracep->chgSData(oldp+219,(vlTOPp->fht_top__DOT__ADDR_RD[0]),9);
            tracep->chgSData(oldp+220,(vlTOPp->fht_top__DOT__ADDR_RD[1]),9);
            tracep->chgSData(oldp+221,(vlTOPp->fht_top__DOT__ADDR_RD[2]),9);
            tracep->chgSData(oldp+222,(vlTOPp->fht_top__DOT__ADDR_RD[3]),9);
            tracep->chgSData(oldp+223,(vlTOPp->fht_top__DOT__ADDR_WR[0]),9);
            tracep->chgSData(oldp+224,(vlTOPp->fht_top__DOT__ADDR_WR[1]),9);
            tracep->chgSData(oldp+225,(vlTOPp->fht_top__DOT__ADDR_WR[2]),9);
            tracep->chgSData(oldp+226,(vlTOPp->fht_top__DOT__ADDR_WR[3]),9);
            tracep->chgCData(oldp+227,(vlTOPp->fht_top__DOT__WE),4);
            tracep->chgIData(oldp+228,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                       [0U]),27);
            tracep->chgIData(oldp+229,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                       [1U]),27);
            tracep->chgIData(oldp+230,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                       [2U]),27);
            tracep->chgIData(oldp+231,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                       [3U]),27);
            tracep->chgSData(oldp+232,(vlTOPp->fht_top__DOT__ADDR_RD
                                       [0U]),9);
            tracep->chgSData(oldp+233,(vlTOPp->fht_top__DOT__ADDR_RD
                                       [1U]),9);
            tracep->chgSData(oldp+234,(vlTOPp->fht_top__DOT__ADDR_RD
                                       [2U]),9);
            tracep->chgSData(oldp+235,(vlTOPp->fht_top__DOT__ADDR_RD
                                       [3U]),9);
            tracep->chgSData(oldp+236,(vlTOPp->fht_top__DOT__ADDR_WR
                                       [0U]),9);
            tracep->chgSData(oldp+237,(vlTOPp->fht_top__DOT__ADDR_WR
                                       [1U]),9);
            tracep->chgSData(oldp+238,(vlTOPp->fht_top__DOT__ADDR_WR
                                       [2U]),9);
            tracep->chgSData(oldp+239,(vlTOPp->fht_top__DOT__ADDR_WR
                                       [3U]),9);
            tracep->chgBit(oldp+240,((1U & (IData)(vlTOPp->fht_top__DOT__WE))));
            tracep->chgBit(oldp+241,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                            >> 1U))));
            tracep->chgBit(oldp+242,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                            >> 2U))));
            tracep->chgBit(oldp+243,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                            >> 3U))));
            tracep->chgIData(oldp+244,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[0]),27);
            tracep->chgIData(oldp+245,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[1]),27);
            tracep->chgIData(oldp+246,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[2]),27);
            tracep->chgIData(oldp+247,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[3]),27);
            tracep->chgSData(oldp+248,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[0]),9);
            tracep->chgSData(oldp+249,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[1]),9);
            tracep->chgSData(oldp+250,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[2]),9);
            tracep->chgSData(oldp+251,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[3]),9);
            tracep->chgSData(oldp+252,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[0]),9);
            tracep->chgSData(oldp+253,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[1]),9);
            tracep->chgSData(oldp+254,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[2]),9);
            tracep->chgSData(oldp+255,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[3]),9);
            tracep->chgIData(oldp+256,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                       [0U]),27);
            tracep->chgSData(oldp+257,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                       [0U]),9);
            tracep->chgSData(oldp+258,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                       [0U]),9);
            tracep->chgIData(oldp+259,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                       [1U]),27);
            tracep->chgSData(oldp+260,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                       [1U]),9);
            tracep->chgSData(oldp+261,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                       [1U]),9);
            tracep->chgIData(oldp+262,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                       [2U]),27);
            tracep->chgSData(oldp+263,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                       [2U]),9);
            tracep->chgSData(oldp+264,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                       [2U]),9);
            tracep->chgIData(oldp+265,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                       [3U]),27);
            tracep->chgSData(oldp+266,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                       [3U]),9);
            tracep->chgSData(oldp+267,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                       [3U]),9);
        }
        tracep->chgBit(oldp+268,(vlTOPp->iCLK));
        tracep->chgBit(oldp+269,(vlTOPp->iRESET));
        tracep->chgBit(oldp+270,(vlTOPp->iSTART));
        tracep->chgCData(oldp+271,(vlTOPp->iWE),4);
        tracep->chgIData(oldp+272,(vlTOPp->iDATA_0),27);
        tracep->chgIData(oldp+273,(vlTOPp->iDATA_1),27);
        tracep->chgIData(oldp+274,(vlTOPp->iDATA_2),27);
        tracep->chgIData(oldp+275,(vlTOPp->iDATA_3),27);
        tracep->chgSData(oldp+276,(vlTOPp->iADDR_WR_0),9);
        tracep->chgSData(oldp+277,(vlTOPp->iADDR_WR_1),9);
        tracep->chgSData(oldp+278,(vlTOPp->iADDR_WR_2),9);
        tracep->chgSData(oldp+279,(vlTOPp->iADDR_WR_3),9);
        tracep->chgSData(oldp+280,(vlTOPp->iADDR_RD_0),9);
        tracep->chgSData(oldp+281,(vlTOPp->iADDR_RD_1),9);
        tracep->chgSData(oldp+282,(vlTOPp->iADDR_RD_2),9);
        tracep->chgSData(oldp+283,(vlTOPp->iADDR_RD_3),9);
        tracep->chgIData(oldp+284,(vlTOPp->oDATA_0),27);
        tracep->chgIData(oldp+285,(vlTOPp->oDATA_1),27);
        tracep->chgIData(oldp+286,(vlTOPp->oDATA_2),27);
        tracep->chgIData(oldp+287,(vlTOPp->oDATA_3),27);
        tracep->chgBit(oldp+288,(vlTOPp->oRDY));
    }
}

void Vfht_top::traceCleanup(void* userp, VerilatedVcd* /*unused*/) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
        vlTOPp->__Vm_traceActivity[2U] = 0U;
    }
}
