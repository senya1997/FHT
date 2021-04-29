// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vfht_top__Syms.h"


//======================

void Vfht_top::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, __VlSymsp);
    traceRegister(tfp->spTrace());
}

void Vfht_top::traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vfht_top::traceInitTop(vlSymsp, tracep);
    tracep->scopeEscape('.');
}

//======================


void Vfht_top::traceInitTop(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceInitSub0(userp, tracep);
    }
}

void Vfht_top::traceInitSub0(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+269,"iCLK", false,-1);
        tracep->declBit(c+270,"iRESET", false,-1);
        tracep->declBit(c+271,"iSTART", false,-1);
        tracep->declBus(c+272,"iWE", false,-1, 3,0);
        tracep->declBus(c+273,"iDATA_0", false,-1, 26,0);
        tracep->declBus(c+274,"iDATA_1", false,-1, 26,0);
        tracep->declBus(c+275,"iDATA_2", false,-1, 26,0);
        tracep->declBus(c+276,"iDATA_3", false,-1, 26,0);
        tracep->declBus(c+277,"iADDR_WR_0", false,-1, 8,0);
        tracep->declBus(c+278,"iADDR_WR_1", false,-1, 8,0);
        tracep->declBus(c+279,"iADDR_WR_2", false,-1, 8,0);
        tracep->declBus(c+280,"iADDR_WR_3", false,-1, 8,0);
        tracep->declBus(c+281,"iADDR_RD_0", false,-1, 8,0);
        tracep->declBus(c+282,"iADDR_RD_1", false,-1, 8,0);
        tracep->declBus(c+283,"iADDR_RD_2", false,-1, 8,0);
        tracep->declBus(c+284,"iADDR_RD_3", false,-1, 8,0);
        tracep->declBus(c+285,"oDATA_0", false,-1, 26,0);
        tracep->declBus(c+286,"oDATA_1", false,-1, 26,0);
        tracep->declBus(c+287,"oDATA_2", false,-1, 26,0);
        tracep->declBus(c+288,"oDATA_3", false,-1, 26,0);
        tracep->declBit(c+289,"oRDY", false,-1);
        tracep->declBus(c+290,"fht_top D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top A_BIT", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top W_BIT", false,-1, 31,0);
        tracep->declArray(c+293,"fht_top MIF_SIN", false,-1, 71,0);
        tracep->declArray(c+296,"fht_top MIF_COS", false,-1, 71,0);
        tracep->declBit(c+269,"fht_top iCLK", false,-1);
        tracep->declBit(c+270,"fht_top iRESET", false,-1);
        tracep->declBit(c+271,"fht_top iSTART", false,-1);
        tracep->declBus(c+272,"fht_top iWE", false,-1, 3,0);
        tracep->declBus(c+273,"fht_top iDATA_0", false,-1, 26,0);
        tracep->declBus(c+274,"fht_top iDATA_1", false,-1, 26,0);
        tracep->declBus(c+275,"fht_top iDATA_2", false,-1, 26,0);
        tracep->declBus(c+276,"fht_top iDATA_3", false,-1, 26,0);
        tracep->declBus(c+277,"fht_top iADDR_WR_0", false,-1, 8,0);
        tracep->declBus(c+278,"fht_top iADDR_WR_1", false,-1, 8,0);
        tracep->declBus(c+279,"fht_top iADDR_WR_2", false,-1, 8,0);
        tracep->declBus(c+280,"fht_top iADDR_WR_3", false,-1, 8,0);
        tracep->declBus(c+281,"fht_top iADDR_RD_0", false,-1, 8,0);
        tracep->declBus(c+282,"fht_top iADDR_RD_1", false,-1, 8,0);
        tracep->declBus(c+283,"fht_top iADDR_RD_2", false,-1, 8,0);
        tracep->declBus(c+284,"fht_top iADDR_RD_3", false,-1, 8,0);
        tracep->declBus(c+285,"fht_top oDATA_0", false,-1, 26,0);
        tracep->declBus(c+286,"fht_top oDATA_1", false,-1, 26,0);
        tracep->declBus(c+287,"fht_top oDATA_2", false,-1, 26,0);
        tracep->declBus(c+288,"fht_top oDATA_3", false,-1, 26,0);
        tracep->declBit(c+289,"fht_top oRDY", false,-1);
        tracep->declBit(c+25,"fht_top SOURCE_DATA", false,-1);
        tracep->declBit(c+26,"fht_top SOURCE_CONT", false,-1);
        tracep->declBit(c+27,"fht_top RDY", false,-1);
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+216+i*1,"fht_top DATA_RAM_A", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+28+i*1,"fht_top DATA_BUT", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+32+i*1,"fht_top ADDR_RD_CTRL", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+36+i*1,"fht_top ADDR_WR_CTRL", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+220+i*1,"fht_top ADDR_RD", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+224+i*1,"fht_top ADDR_WR", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+1+i*1,"fht_top DATA_RAM_A_BUT", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+5+i*1,"fht_top DATA_RAM_B_BUT", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+40+i*1,"fht_top DATA_BUT_RAM", true,(i+0), 26,0);}}
        tracep->declBit(c+44,"fht_top WE_A", false,-1);
        tracep->declBit(c+45,"fht_top WE_B", false,-1);
        tracep->declBus(c+228,"fht_top WE", false,-1, 3,0);
        tracep->declBit(c+46,"fht_top ST_ZERO", false,-1);
        tracep->declBit(c+47,"fht_top ST_LAST", false,-1);
        tracep->declBit(c+48,"fht_top SEC_PART_SUBSEC", false,-1);
        tracep->declBus(c+49,"fht_top SECTOR", false,-1, 8,0);
        tracep->declBus(c+50,"fht_top ADDR_COEF", false,-1, 6,0);
        tracep->declBus(c+299,"fht_top SIN_0", false,-1, 12,0);
        tracep->declBus(c+300,"fht_top COS_0", false,-1, 12,0);
        tracep->declBus(c+51,"fht_top SIN_1", false,-1, 12,0);
        tracep->declBus(c+52,"fht_top COS_1", false,-1, 12,0);
        tracep->declBus(c+291,"fht_top CONTROL A_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top CONTROL iCLK", false,-1);
        tracep->declBit(c+270,"fht_top CONTROL iRESET", false,-1);
        tracep->declBit(c+271,"fht_top CONTROL iSTART", false,-1);
        tracep->declBit(c+46,"fht_top CONTROL oST_ZERO", false,-1);
        tracep->declBit(c+47,"fht_top CONTROL oST_LAST", false,-1);
        tracep->declBit(c+48,"fht_top CONTROL o2ND_PART_SUBSEC", false,-1);
        tracep->declBus(c+49,"fht_top CONTROL oSECTOR", false,-1, 8,0);
        tracep->declBus(c+53,"fht_top CONTROL oADDR_RD_0", false,-1, 8,0);
        tracep->declBus(c+54,"fht_top CONTROL oADDR_RD_1", false,-1, 8,0);
        tracep->declBus(c+53,"fht_top CONTROL oADDR_RD_2", false,-1, 8,0);
        tracep->declBus(c+54,"fht_top CONTROL oADDR_RD_3", false,-1, 8,0);
        tracep->declBus(c+55,"fht_top CONTROL oADDR_WR_0", false,-1, 8,0);
        tracep->declBus(c+56,"fht_top CONTROL oADDR_WR_1", false,-1, 8,0);
        tracep->declBus(c+55,"fht_top CONTROL oADDR_WR_2", false,-1, 8,0);
        tracep->declBus(c+56,"fht_top CONTROL oADDR_WR_3", false,-1, 8,0);
        tracep->declBus(c+50,"fht_top CONTROL oADDR_COEF", false,-1, 6,0);
        tracep->declBit(c+44,"fht_top CONTROL oWE_A", false,-1);
        tracep->declBit(c+45,"fht_top CONTROL oWE_B", false,-1);
        tracep->declBit(c+25,"fht_top CONTROL oSOURCE_DATA", false,-1);
        tracep->declBit(c+26,"fht_top CONTROL oSOURCE_CONT", false,-1);
        tracep->declBit(c+27,"fht_top CONTROL oRDY", false,-1);
        tracep->declBit(c+57,"fht_top CONTROL clk_2", false,-1);
        tracep->declBit(c+58,"fht_top CONTROL N_CLK_2", false,-1);
        tracep->declBus(c+59,"fht_top CONTROL cnt_stage", false,-1, 3,0);
        tracep->declBus(c+60,"fht_top CONTROL cnt_stage_time", false,-1, 9,0);
        tracep->declBus(c+61,"fht_top CONTROL div", false,-1, 9,0);
        tracep->declBus(c+62,"fht_top CONTROL div_2", false,-1, 3,0);
        tracep->declBus(c+63,"fht_top CONTROL cnt_sector", false,-1, 8,0);
        tracep->declBus(c+49,"fht_top CONTROL cnt_sector_d", false,-1, 8,0);
        tracep->declBus(c+64,"fht_top CONTROL cnt_sector_time", false,-1, 8,0);
        tracep->declBus(c+65,"fht_top CONTROL size_bias_rd", false,-1, 9,0);
        tracep->declBus(c+66,"fht_top CONTROL cnt_bias_rd", false,-1, 9,0);
        tracep->declBus(c+67,"fht_top CONTROL addr_rd_cnt", false,-1, 8,0);
        tracep->declBus(c+68,"fht_top CONTROL addr_rd_bias", false,-1, 8,0);
        tracep->declBus(c+69,"fht_top CONTROL addr_wr_cnt", false,-1, 8,0);
        tracep->declBus(c+55,"fht_top CONTROL addr_wr_cnt_d", false,-1, 8,0);
        tracep->declBus(c+56,"fht_top CONTROL addr_wr_bias", false,-1, 8,0);
        tracep->declBus(c+70,"fht_top CONTROL addr_coef_cnt", false,-1, 6,0);
        tracep->declBus(c+50,"fht_top CONTROL addr_coef", false,-1, 6,0);
        tracep->declBus(c+71,"fht_top CONTROL sec_part_subsec_d", false,-1, 3,0);
        tracep->declBit(c+44,"fht_top CONTROL we_a", false,-1);
        tracep->declBit(c+45,"fht_top CONTROL we_b", false,-1);
        tracep->declBit(c+25,"fht_top CONTROL source_data", false,-1);
        tracep->declBit(c+26,"fht_top CONTROL source_cont", false,-1);
        tracep->declBit(c+27,"fht_top CONTROL rdy", false,-1);
        tracep->declBit(c+46,"fht_top CONTROL ZERO_STAGE", false,-1);
        tracep->declBit(c+47,"fht_top CONTROL LAST_STAGE", false,-1);
        tracep->declBit(c+72,"fht_top CONTROL WE_EN", false,-1);
        tracep->declBit(c+73,"fht_top CONTROL COEF_EN", false,-1);
        tracep->declBit(c+74,"fht_top CONTROL EOF_READ", false,-1);
        tracep->declBit(c+75,"fht_top CONTROL EOF_COEF", false,-1);
        tracep->declBit(c+76,"fht_top CONTROL EOF_STAGE", false,-1);
        tracep->declBit(c+77,"fht_top CONTROL EOF_STAGE_1", false,-1);
        tracep->declBit(c+78,"fht_top CONTROL EOF_SECTOR", false,-1);
        tracep->declBit(c+79,"fht_top CONTROL EOF_SECTOR_1", false,-1);
        tracep->declBit(c+80,"fht_top CONTROL SEC_PART_SUBSEC", false,-1);
        tracep->declBit(c+81,"fht_top CONTROL SEC_PART_SUBSEC_D", false,-1);
        tracep->declBit(c+82,"fht_top CONTROL RESET_CNT_RD", false,-1);
        tracep->declBit(c+83,"fht_top CONTROL RESET_CNT_WR", false,-1);
        tracep->declBit(c+84,"fht_top CONTROL RESET_CNT_COEF", false,-1);
        tracep->declBit(c+85,"fht_top CONTROL STAGE_ODD", false,-1);
        tracep->declBit(c+86,"fht_top CONTROL STAGE_EVEN", false,-1);
        tracep->declBus(c+87,"fht_top CONTROL INC_ADDR_RD", false,-1, 8,0);
        tracep->declBus(c+88,"fht_top CONTROL BIAS_RD", false,-1, 10,0);
        tracep->declBus(c+89,"fht_top CONTROL BIAS_WR", false,-1, 8,0);
        tracep->declBit(c+90,"fht_top CONTROL NEW_BIAS_RD", false,-1);
        tracep->declBit(c+91,"fht_top CONTROL CHOOSE_EN_NEW_BIAS_RD", false,-1);
        tracep->declBit(c+92,"fht_top CONTROL EN_BIAS", false,-1);
        tracep->declBit(c+93,"fht_top CONTROL EN_BIAS_EVEN", false,-1);
        tracep->declBit(c+94,"fht_top CONTROL EN_BIAS_ODD", false,-1);
        tracep->declBus(c+290,"fht_top BUT_BLOCK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top BUT_BLOCK A_BIT", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top BUT_BLOCK W_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top BUT_BLOCK iCLK", false,-1);
        tracep->declBit(c+270,"fht_top BUT_BLOCK iRESET", false,-1);
        tracep->declBit(c+46,"fht_top BUT_BLOCK iST_ZERO", false,-1);
        tracep->declBit(c+47,"fht_top BUT_BLOCK iST_LAST", false,-1);
        tracep->declBit(c+48,"fht_top BUT_BLOCK i2ND_PART_SUBSEC", false,-1);
        tracep->declBus(c+49,"fht_top BUT_BLOCK iSECTOR", false,-1, 8,0);
        tracep->declBus(c+95,"fht_top BUT_BLOCK iBANK_0", false,-1, 26,0);
        tracep->declBus(c+96,"fht_top BUT_BLOCK iBANK_1", false,-1, 26,0);
        tracep->declBus(c+97,"fht_top BUT_BLOCK iBANK_2", false,-1, 26,0);
        tracep->declBus(c+98,"fht_top BUT_BLOCK iBANK_3", false,-1, 26,0);
        tracep->declBus(c+299,"fht_top BUT_BLOCK iSIN_0", false,-1, 12,0);
        tracep->declBus(c+300,"fht_top BUT_BLOCK iCOS_0", false,-1, 12,0);
        tracep->declBus(c+51,"fht_top BUT_BLOCK iSIN_1", false,-1, 12,0);
        tracep->declBus(c+52,"fht_top BUT_BLOCK iCOS_1", false,-1, 12,0);
        tracep->declBus(c+99,"fht_top BUT_BLOCK oY_0", false,-1, 26,0);
        tracep->declBus(c+100,"fht_top BUT_BLOCK oY_1", false,-1, 26,0);
        tracep->declBus(c+101,"fht_top BUT_BLOCK oY_2", false,-1, 26,0);
        tracep->declBus(c+102,"fht_top BUT_BLOCK oY_3", false,-1, 26,0);
        {int i; for (i=0; i<2; i++) {
                tracep->declBus(c+103+i*1,"fht_top BUT_BLOCK sin", true,(i+0), 12,0);}}
        {int i; for (i=0; i<2; i++) {
                tracep->declBus(c+105+i*1,"fht_top BUT_BLOCK cos", true,(i+0), 12,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+107+i*1,"fht_top BUT_BLOCK mux_buf", true,(i+0), 26,0);}}
        {int i; for (i=0; i<3; i++) {
                tracep->declBus(c+111+i*1,"fht_top BUT_BLOCK MIX_TO_BUT_0", true,(i+0), 26,0);}}
        {int i; for (i=0; i<3; i++) {
                tracep->declBus(c+114+i*1,"fht_top BUT_BLOCK MIX_TO_BUT_1", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+117+i*1,"fht_top BUT_BLOCK BUT_TO_MIX", true,(i+0), 26,0);}}
        tracep->declBus(c+290,"fht_top BUT_BLOCK MIX_0 D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top BUT_BLOCK MIX_0 A_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top BUT_BLOCK MIX_0 iCLK", false,-1);
        tracep->declBit(c+270,"fht_top BUT_BLOCK MIX_0 iRESET", false,-1);
        tracep->declBit(c+46,"fht_top BUT_BLOCK MIX_0 iST_ZERO", false,-1);
        tracep->declBus(c+49,"fht_top BUT_BLOCK MIX_0 iSECTOR", false,-1, 8,0);
        tracep->declBus(c+95,"fht_top BUT_BLOCK MIX_0 iBANK_0", false,-1, 26,0);
        tracep->declBus(c+96,"fht_top BUT_BLOCK MIX_0 iBANK_1", false,-1, 26,0);
        tracep->declBus(c+97,"fht_top BUT_BLOCK MIX_0 iBANK_2", false,-1, 26,0);
        tracep->declBus(c+98,"fht_top BUT_BLOCK MIX_0 iBANK_3", false,-1, 26,0);
        tracep->declBus(c+121,"fht_top BUT_BLOCK MIX_0 oY_0", false,-1, 26,0);
        tracep->declBus(c+122,"fht_top BUT_BLOCK MIX_0 oY_1", false,-1, 26,0);
        tracep->declBus(c+123,"fht_top BUT_BLOCK MIX_0 oY_2", false,-1, 26,0);
        {int i; for (i=0; i<3; i++) {
                tracep->declBus(c+124+i*1,"fht_top BUT_BLOCK MIX_0 mux_buf", true,(i+0), 26,0);}}
        tracep->declBus(c+290,"fht_top BUT_BLOCK MIX_1 D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top BUT_BLOCK MIX_1 A_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top BUT_BLOCK MIX_1 iCLK", false,-1);
        tracep->declBit(c+270,"fht_top BUT_BLOCK MIX_1 iRESET", false,-1);
        tracep->declBit(c+46,"fht_top BUT_BLOCK MIX_1 iST_ZERO", false,-1);
        tracep->declBus(c+49,"fht_top BUT_BLOCK MIX_1 iSECTOR", false,-1, 8,0);
        tracep->declBus(c+97,"fht_top BUT_BLOCK MIX_1 iBANK_0", false,-1, 26,0);
        tracep->declBus(c+98,"fht_top BUT_BLOCK MIX_1 iBANK_1", false,-1, 26,0);
        tracep->declBus(c+95,"fht_top BUT_BLOCK MIX_1 iBANK_2", false,-1, 26,0);
        tracep->declBus(c+96,"fht_top BUT_BLOCK MIX_1 iBANK_3", false,-1, 26,0);
        tracep->declBus(c+127,"fht_top BUT_BLOCK MIX_1 oY_0", false,-1, 26,0);
        tracep->declBus(c+128,"fht_top BUT_BLOCK MIX_1 oY_1", false,-1, 26,0);
        tracep->declBus(c+129,"fht_top BUT_BLOCK MIX_1 oY_2", false,-1, 26,0);
        {int i; for (i=0; i<3; i++) {
                tracep->declBus(c+130+i*1,"fht_top BUT_BLOCK MIX_1 mux_buf", true,(i+0), 26,0);}}
        tracep->declBus(c+290,"fht_top BUT_BLOCK BUT_0 D_BIT", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top BUT_BLOCK BUT_0 W_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top BUT_BLOCK BUT_0 iCLK", false,-1);
        tracep->declBit(c+270,"fht_top BUT_BLOCK BUT_0 iRESET", false,-1);
        tracep->declBus(c+133,"fht_top BUT_BLOCK BUT_0 iX_0", false,-1, 26,0);
        tracep->declBus(c+134,"fht_top BUT_BLOCK BUT_0 iX_1", false,-1, 26,0);
        tracep->declBus(c+135,"fht_top BUT_BLOCK BUT_0 iX_2", false,-1, 26,0);
        tracep->declBus(c+136,"fht_top BUT_BLOCK BUT_0 iSIN", false,-1, 12,0);
        tracep->declBus(c+137,"fht_top BUT_BLOCK BUT_0 iCOS", false,-1, 12,0);
        tracep->declBus(c+138,"fht_top BUT_BLOCK BUT_0 oY_0", false,-1, 26,0);
        tracep->declBus(c+139,"fht_top BUT_BLOCK BUT_0 oY_1", false,-1, 26,0);
        tracep->declQuad(c+140,"fht_top BUT_BLOCK BUT_0 sum_mul", false,-1, 40,0);
        tracep->declBus(c+138,"fht_top BUT_BLOCK BUT_0 sum_buf", false,-1, 26,0);
        tracep->declBus(c+139,"fht_top BUT_BLOCK BUT_0 sub_buf", false,-1, 26,0);
        tracep->declQuad(c+142,"fht_top BUT_BLOCK BUT_0 EXT_X0", false,-1, 40,0);
        tracep->declQuad(c+144,"fht_top BUT_BLOCK BUT_0 EXT_SUM_MUL", false,-1, 40,0);
        tracep->declQuad(c+146,"fht_top BUT_BLOCK BUT_0 EXT_SUM", false,-1, 41,0);
        tracep->declQuad(c+148,"fht_top BUT_BLOCK BUT_0 EXT_SUB", false,-1, 41,0);
        tracep->declBit(c+150,"fht_top BUT_BLOCK BUT_0 POS_LHALF_SUM", false,-1);
        tracep->declBit(c+151,"fht_top BUT_BLOCK BUT_0 NEG_LHALF_SUM", false,-1);
        tracep->declBit(c+152,"fht_top BUT_BLOCK BUT_0 POS_LHALF_SUB", false,-1);
        tracep->declBit(c+153,"fht_top BUT_BLOCK BUT_0 NEG_LHALF_SUB", false,-1);
        tracep->declBus(c+154,"fht_top BUT_BLOCK BUT_0 ROUND_SUM", false,-1, 26,0);
        tracep->declBus(c+155,"fht_top BUT_BLOCK BUT_0 ROUND_SUB", false,-1, 26,0);
        tracep->declBus(c+290,"fht_top BUT_BLOCK BUT_1 D_BIT", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top BUT_BLOCK BUT_1 W_BIT", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top BUT_BLOCK BUT_1 iCLK", false,-1);
        tracep->declBit(c+270,"fht_top BUT_BLOCK BUT_1 iRESET", false,-1);
        tracep->declBus(c+156,"fht_top BUT_BLOCK BUT_1 iX_0", false,-1, 26,0);
        tracep->declBus(c+157,"fht_top BUT_BLOCK BUT_1 iX_1", false,-1, 26,0);
        tracep->declBus(c+158,"fht_top BUT_BLOCK BUT_1 iX_2", false,-1, 26,0);
        tracep->declBus(c+159,"fht_top BUT_BLOCK BUT_1 iSIN", false,-1, 12,0);
        tracep->declBus(c+160,"fht_top BUT_BLOCK BUT_1 iCOS", false,-1, 12,0);
        tracep->declBus(c+161,"fht_top BUT_BLOCK BUT_1 oY_0", false,-1, 26,0);
        tracep->declBus(c+162,"fht_top BUT_BLOCK BUT_1 oY_1", false,-1, 26,0);
        tracep->declQuad(c+163,"fht_top BUT_BLOCK BUT_1 sum_mul", false,-1, 40,0);
        tracep->declBus(c+161,"fht_top BUT_BLOCK BUT_1 sum_buf", false,-1, 26,0);
        tracep->declBus(c+162,"fht_top BUT_BLOCK BUT_1 sub_buf", false,-1, 26,0);
        tracep->declQuad(c+165,"fht_top BUT_BLOCK BUT_1 EXT_X0", false,-1, 40,0);
        tracep->declQuad(c+167,"fht_top BUT_BLOCK BUT_1 EXT_SUM_MUL", false,-1, 40,0);
        tracep->declQuad(c+169,"fht_top BUT_BLOCK BUT_1 EXT_SUM", false,-1, 41,0);
        tracep->declQuad(c+171,"fht_top BUT_BLOCK BUT_1 EXT_SUB", false,-1, 41,0);
        tracep->declBit(c+173,"fht_top BUT_BLOCK BUT_1 POS_LHALF_SUM", false,-1);
        tracep->declBit(c+174,"fht_top BUT_BLOCK BUT_1 NEG_LHALF_SUM", false,-1);
        tracep->declBit(c+175,"fht_top BUT_BLOCK BUT_1 POS_LHALF_SUB", false,-1);
        tracep->declBit(c+176,"fht_top BUT_BLOCK BUT_1 NEG_LHALF_SUB", false,-1);
        tracep->declBus(c+177,"fht_top BUT_BLOCK BUT_1 ROUND_SUM", false,-1, 26,0);
        tracep->declBus(c+178,"fht_top BUT_BLOCK BUT_1 ROUND_SUB", false,-1, 26,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A iCLK", false,-1);
        tracep->declBit(c+270,"fht_top FHT_RAM_A iRESET", false,-1);
        tracep->declBus(c+229,"fht_top FHT_RAM_A iDATA_0", false,-1, 26,0);
        tracep->declBus(c+230,"fht_top FHT_RAM_A iDATA_1", false,-1, 26,0);
        tracep->declBus(c+231,"fht_top FHT_RAM_A iDATA_2", false,-1, 26,0);
        tracep->declBus(c+232,"fht_top FHT_RAM_A iDATA_3", false,-1, 26,0);
        tracep->declBus(c+233,"fht_top FHT_RAM_A iADDR_RD_0", false,-1, 8,0);
        tracep->declBus(c+234,"fht_top FHT_RAM_A iADDR_RD_1", false,-1, 8,0);
        tracep->declBus(c+235,"fht_top FHT_RAM_A iADDR_RD_2", false,-1, 8,0);
        tracep->declBus(c+236,"fht_top FHT_RAM_A iADDR_RD_3", false,-1, 8,0);
        tracep->declBus(c+237,"fht_top FHT_RAM_A iADDR_WR_0", false,-1, 8,0);
        tracep->declBus(c+238,"fht_top FHT_RAM_A iADDR_WR_1", false,-1, 8,0);
        tracep->declBus(c+239,"fht_top FHT_RAM_A iADDR_WR_2", false,-1, 8,0);
        tracep->declBus(c+240,"fht_top FHT_RAM_A iADDR_WR_3", false,-1, 8,0);
        tracep->declBit(c+241,"fht_top FHT_RAM_A iWE_0", false,-1);
        tracep->declBit(c+242,"fht_top FHT_RAM_A iWE_1", false,-1);
        tracep->declBit(c+243,"fht_top FHT_RAM_A iWE_2", false,-1);
        tracep->declBit(c+244,"fht_top FHT_RAM_A iWE_3", false,-1);
        tracep->declBus(c+9,"fht_top FHT_RAM_A oDATA_0", false,-1, 26,0);
        tracep->declBus(c+10,"fht_top FHT_RAM_A oDATA_1", false,-1, 26,0);
        tracep->declBus(c+11,"fht_top FHT_RAM_A oDATA_2", false,-1, 26,0);
        tracep->declBus(c+12,"fht_top FHT_RAM_A oDATA_3", false,-1, 26,0);
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+245+i*1,"fht_top FHT_RAM_A DATA_IN", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+249+i*1,"fht_top FHT_RAM_A ADDR_RD", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+253+i*1,"fht_top FHT_RAM_A ADDR_WR", true,(i+0), 8,0);}}
        tracep->declBus(c+228,"fht_top FHT_RAM_A WE", false,-1, 3,0);
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+13+i*1,"fht_top FHT_RAM_A DATA_OUT", true,(i+0), 26,0);}}
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK clock", false,-1);
        tracep->declBus(c+257,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+258,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+259,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+241,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK wren", false,-1);
        tracep->declBus(c+302,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+302,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+241,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+257,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+259,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+258,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+349,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+302,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+350,"fht_top FHT_RAM_A ram_bank[0] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK clock", false,-1);
        tracep->declBus(c+260,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+261,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+262,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+242,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK wren", false,-1);
        tracep->declBus(c+351,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+351,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+242,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+260,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+262,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+261,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+352,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+351,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+353,"fht_top FHT_RAM_A ram_bank[1] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK clock", false,-1);
        tracep->declBus(c+263,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+264,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+265,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+243,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK wren", false,-1);
        tracep->declBus(c+354,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+354,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+243,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+263,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+265,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+264,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+355,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+354,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+356,"fht_top FHT_RAM_A ram_bank[2] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK clock", false,-1);
        tracep->declBus(c+266,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+267,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+268,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+244,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK wren", false,-1);
        tracep->declBus(c+357,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+357,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+244,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+266,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+268,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+267,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+358,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+357,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+359,"fht_top FHT_RAM_A ram_bank[3] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B iCLK", false,-1);
        tracep->declBit(c+270,"fht_top FHT_RAM_B iRESET", false,-1);
        tracep->declBus(c+179,"fht_top FHT_RAM_B iDATA_0", false,-1, 26,0);
        tracep->declBus(c+180,"fht_top FHT_RAM_B iDATA_1", false,-1, 26,0);
        tracep->declBus(c+181,"fht_top FHT_RAM_B iDATA_2", false,-1, 26,0);
        tracep->declBus(c+182,"fht_top FHT_RAM_B iDATA_3", false,-1, 26,0);
        tracep->declBus(c+183,"fht_top FHT_RAM_B iADDR_RD_0", false,-1, 8,0);
        tracep->declBus(c+184,"fht_top FHT_RAM_B iADDR_RD_1", false,-1, 8,0);
        tracep->declBus(c+185,"fht_top FHT_RAM_B iADDR_RD_2", false,-1, 8,0);
        tracep->declBus(c+186,"fht_top FHT_RAM_B iADDR_RD_3", false,-1, 8,0);
        tracep->declBus(c+187,"fht_top FHT_RAM_B iADDR_WR_0", false,-1, 8,0);
        tracep->declBus(c+188,"fht_top FHT_RAM_B iADDR_WR_1", false,-1, 8,0);
        tracep->declBus(c+189,"fht_top FHT_RAM_B iADDR_WR_2", false,-1, 8,0);
        tracep->declBus(c+190,"fht_top FHT_RAM_B iADDR_WR_3", false,-1, 8,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B iWE_0", false,-1);
        tracep->declBit(c+45,"fht_top FHT_RAM_B iWE_1", false,-1);
        tracep->declBit(c+45,"fht_top FHT_RAM_B iWE_2", false,-1);
        tracep->declBit(c+45,"fht_top FHT_RAM_B iWE_3", false,-1);
        tracep->declBus(c+17,"fht_top FHT_RAM_B oDATA_0", false,-1, 26,0);
        tracep->declBus(c+18,"fht_top FHT_RAM_B oDATA_1", false,-1, 26,0);
        tracep->declBus(c+19,"fht_top FHT_RAM_B oDATA_2", false,-1, 26,0);
        tracep->declBus(c+20,"fht_top FHT_RAM_B oDATA_3", false,-1, 26,0);
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+191+i*1,"fht_top FHT_RAM_B DATA_IN", true,(i+0), 26,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+195+i*1,"fht_top FHT_RAM_B ADDR_RD", true,(i+0), 8,0);}}
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+199+i*1,"fht_top FHT_RAM_B ADDR_WR", true,(i+0), 8,0);}}
        tracep->declBus(c+203,"fht_top FHT_RAM_B WE", false,-1, 3,0);
        {int i; for (i=0; i<4; i++) {
                tracep->declBus(c+21+i*1,"fht_top FHT_RAM_B DATA_OUT", true,(i+0), 26,0);}}
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK clock", false,-1);
        tracep->declBus(c+204,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+205,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+206,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK wren", false,-1);
        tracep->declBus(c+360,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+360,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+204,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+206,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+205,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+361,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+360,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+362,"fht_top FHT_RAM_B ram_bank[0] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK clock", false,-1);
        tracep->declBus(c+207,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+208,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+209,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK wren", false,-1);
        tracep->declBus(c+363,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+363,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+207,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+209,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+208,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+364,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+363,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+365,"fht_top FHT_RAM_B ram_bank[1] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK clock", false,-1);
        tracep->declBus(c+210,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+211,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+212,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK wren", false,-1);
        tracep->declBus(c+366,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+366,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+210,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+212,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+211,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+367,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+366,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+368,"fht_top FHT_RAM_B ram_bank[2] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK D_BIT", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK A_BIT", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK DEPTH", false,-1, 31,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK clock", false,-1);
        tracep->declBus(c+213,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK data", false,-1, 26,0);
        tracep->declBus(c+214,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK rdaddress", false,-1, 8,0);
        tracep->declBus(c+215,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK wraddress", false,-1, 8,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK wren", false,-1);
        tracep->declBus(c+369,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK q", false,-1, 26,0);
        tracep->declBus(c+369,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK sub_wire0", false,-1, 26,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component address_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+306,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component init_file", false,-1, 47,0);
        tracep->declQuad(c+315,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component lpm_hint", false,-1, 47,0);
        tracep->declArray(c+321,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+301,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declArray(c+325,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component operation_mode", false,-1, 71,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declQuad(c+334,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_mixed_ports", false,-1, 63,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+290,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+291,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+45,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component rden_b", false,-1);
        tracep->declBus(c+213,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component data_a", false,-1, 26,0);
        tracep->declBus(c+348,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component data_b", false,-1, 26,0);
        tracep->declBus(c+215,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component address_a", false,-1, 8,0);
        tracep->declBus(c+214,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component address_b", false,-1, 8,0);
        tracep->declBit(c+269,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+370,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component q_a", false,-1, 26,0);
        tracep->declBus(c+369,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component q_b", false,-1, 26,0);
        tracep->declBus(c+371,"fht_top FHT_RAM_B ram_bank[3] RAM_BANK altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+372,"fht_top ROM_BLOCK A_BIT", false,-1, 31,0);
        tracep->declBus(c+373,"fht_top ROM_BLOCK DEPTH", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top ROM_BLOCK W_BIT", false,-1, 31,0);
        tracep->declArray(c+293,"fht_top ROM_BLOCK MIF_SIN", false,-1, 71,0);
        tracep->declArray(c+296,"fht_top ROM_BLOCK MIF_COS", false,-1, 71,0);
        tracep->declBit(c+269,"fht_top ROM_BLOCK iCLK", false,-1);
        tracep->declBit(c+46,"fht_top ROM_BLOCK iST_ZERO", false,-1);
        tracep->declBus(c+50,"fht_top ROM_BLOCK iADDR", false,-1, 6,0);
        tracep->declBus(c+299,"fht_top ROM_BLOCK oSIN_0", false,-1, 12,0);
        tracep->declBus(c+300,"fht_top ROM_BLOCK oCOS_0", false,-1, 12,0);
        tracep->declBus(c+51,"fht_top ROM_BLOCK oSIN_1", false,-1, 12,0);
        tracep->declBus(c+52,"fht_top ROM_BLOCK oCOS_1", false,-1, 12,0);
        tracep->declBus(c+299,"fht_top ROM_BLOCK OUT_SIN", false,-1, 12,0);
        tracep->declBus(c+300,"fht_top ROM_BLOCK OUT_COS", false,-1, 12,0);
        tracep->declBus(c+374,"fht_top ROM_BLOCK NEG_SIN", false,-1, 12,0);
        tracep->declBus(c+372,"fht_top ROM_BLOCK ROM_SIN A_BIT", false,-1, 31,0);
        tracep->declBus(c+373,"fht_top ROM_BLOCK ROM_SIN DEPTH", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top ROM_BLOCK ROM_SIN W_BIT", false,-1, 31,0);
        tracep->declArray(c+293,"fht_top ROM_BLOCK ROM_SIN MIF", false,-1, 71,0);
        tracep->declBus(c+50,"fht_top ROM_BLOCK ROM_SIN address", false,-1, 6,0);
        tracep->declBit(c+269,"fht_top ROM_BLOCK ROM_SIN clock", false,-1);
        tracep->declBus(c+299,"fht_top ROM_BLOCK ROM_SIN q", false,-1, 12,0);
        tracep->declBus(c+299,"fht_top ROM_BLOCK ROM_SIN sub_wire0", false,-1, 12,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component address_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_SIN altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_SIN altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_SIN altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declArray(c+293,"fht_top ROM_BLOCK ROM_SIN altsyncram_component init_file", false,-1, 71,0);
        tracep->declQuad(c+315,"fht_top ROM_BLOCK ROM_SIN altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top ROM_BLOCK ROM_SIN altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top ROM_BLOCK ROM_SIN altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declArray(c+375,"fht_top ROM_BLOCK ROM_SIN altsyncram_component lpm_hint", false,-1, 167,0);
        tracep->declArray(c+321,"fht_top ROM_BLOCK ROM_SIN altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top ROM_BLOCK ROM_SIN altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+373,"fht_top ROM_BLOCK ROM_SIN altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+324,"fht_top ROM_BLOCK ROM_SIN altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declBus(c+381,"fht_top ROM_BLOCK ROM_SIN altsyncram_component operation_mode", false,-1, 23,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top ROM_BLOCK ROM_SIN altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top ROM_BLOCK ROM_SIN altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top ROM_BLOCK ROM_SIN altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top ROM_BLOCK ROM_SIN altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_SIN altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declArray(c+382,"fht_top ROM_BLOCK ROM_SIN altsyncram_component read_during_write_mode_mixed_ports", false,-1, 71,0);
        tracep->declBus(c+292,"fht_top ROM_BLOCK ROM_SIN altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_SIN altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_SIN altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_SIN altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+372,"fht_top ROM_BLOCK ROM_SIN altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_SIN altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_SIN altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_SIN altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_SIN altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top ROM_BLOCK ROM_SIN altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top ROM_BLOCK ROM_SIN altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top ROM_BLOCK ROM_SIN altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component rden_b", false,-1);
        tracep->declBus(c+385,"fht_top ROM_BLOCK ROM_SIN altsyncram_component data_a", false,-1, 12,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component data_b", false,-1, 0,0);
        tracep->declBus(c+50,"fht_top ROM_BLOCK ROM_SIN altsyncram_component address_a", false,-1, 6,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component address_b", false,-1, 0,0);
        tracep->declBit(c+269,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_SIN altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_SIN altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+299,"fht_top ROM_BLOCK ROM_SIN altsyncram_component q_a", false,-1, 12,0);
        tracep->declBus(c+386,"fht_top ROM_BLOCK ROM_SIN altsyncram_component q_b", false,-1, 0,0);
        tracep->declBus(c+387,"fht_top ROM_BLOCK ROM_SIN altsyncram_component eccstatus", false,-1, 2,0);
        tracep->declBus(c+372,"fht_top ROM_BLOCK ROM_COS A_BIT", false,-1, 31,0);
        tracep->declBus(c+373,"fht_top ROM_BLOCK ROM_COS DEPTH", false,-1, 31,0);
        tracep->declBus(c+292,"fht_top ROM_BLOCK ROM_COS W_BIT", false,-1, 31,0);
        tracep->declArray(c+296,"fht_top ROM_BLOCK ROM_COS MIF", false,-1, 71,0);
        tracep->declBus(c+50,"fht_top ROM_BLOCK ROM_COS address", false,-1, 6,0);
        tracep->declBit(c+269,"fht_top ROM_BLOCK ROM_COS clock", false,-1);
        tracep->declBus(c+300,"fht_top ROM_BLOCK ROM_COS q", false,-1, 12,0);
        tracep->declBus(c+300,"fht_top ROM_BLOCK ROM_COS sub_wire0", false,-1, 12,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component address_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component address_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_COS altsyncram_component address_reg_b", false,-1, 47,0);
        tracep->declBus(c+308,"fht_top ROM_BLOCK ROM_COS altsyncram_component byte_size", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_COS altsyncram_component byteena_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component byteena_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_COS altsyncram_component byteena_reg_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_input_a", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_input_b", false,-1, 47,0);
        tracep->declQuad(c+311,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_output_a", false,-1, 47,0);
        tracep->declQuad(c+313,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_output_b", false,-1, 47,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_COS altsyncram_component indata_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component indata_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_COS altsyncram_component indata_reg_b", false,-1, 47,0);
        tracep->declArray(c+296,"fht_top ROM_BLOCK ROM_COS altsyncram_component init_file", false,-1, 71,0);
        tracep->declQuad(c+315,"fht_top ROM_BLOCK ROM_COS altsyncram_component init_file_layout", false,-1, 47,0);
        tracep->declArray(c+317,"fht_top ROM_BLOCK ROM_COS altsyncram_component intended_device_family", false,-1, 95,0);
        tracep->declBus(c+320,"fht_top ROM_BLOCK ROM_COS altsyncram_component implement_in_les", false,-1, 23,0);
        tracep->declArray(c+375,"fht_top ROM_BLOCK ROM_COS altsyncram_component lpm_hint", false,-1, 167,0);
        tracep->declArray(c+321,"fht_top ROM_BLOCK ROM_COS altsyncram_component lpm_type", false,-1, 79,0);
        tracep->declBus(c+324,"fht_top ROM_BLOCK ROM_COS altsyncram_component maximum_depth", false,-1, 31,0);
        tracep->declBus(c+373,"fht_top ROM_BLOCK ROM_COS altsyncram_component numwords_a", false,-1, 31,0);
        tracep->declBus(c+324,"fht_top ROM_BLOCK ROM_COS altsyncram_component numwords_b", false,-1, 31,0);
        tracep->declBus(c+381,"fht_top ROM_BLOCK ROM_COS altsyncram_component operation_mode", false,-1, 23,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component outdata_aclr_a", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component outdata_aclr_b", false,-1, 31,0);
        tracep->declArray(c+328,"fht_top ROM_BLOCK ROM_COS altsyncram_component outdata_reg_a", false,-1, 95,0);
        tracep->declArray(c+328,"fht_top ROM_BLOCK ROM_COS altsyncram_component outdata_reg_b", false,-1, 95,0);
        tracep->declQuad(c+331,"fht_top ROM_BLOCK ROM_COS altsyncram_component power_up_uninitialized", false,-1, 39,0);
        tracep->declBus(c+333,"fht_top ROM_BLOCK ROM_COS altsyncram_component ram_block_type", false,-1, 31,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component rdcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_COS altsyncram_component rdcontrol_reg_b", false,-1, 47,0);
        tracep->declArray(c+382,"fht_top ROM_BLOCK ROM_COS altsyncram_component read_during_write_mode_mixed_ports", false,-1, 71,0);
        tracep->declBus(c+292,"fht_top ROM_BLOCK ROM_COS altsyncram_component width_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_COS altsyncram_component width_b", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_COS altsyncram_component width_byteena_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_COS altsyncram_component width_byteena_b", false,-1, 31,0);
        tracep->declBus(c+372,"fht_top ROM_BLOCK ROM_COS altsyncram_component widthad_a", false,-1, 31,0);
        tracep->declBus(c+336,"fht_top ROM_BLOCK ROM_COS altsyncram_component widthad_b", false,-1, 31,0);
        tracep->declQuad(c+303,"fht_top ROM_BLOCK ROM_COS altsyncram_component wrcontrol_aclr_a", false,-1, 47,0);
        tracep->declBus(c+305,"fht_top ROM_BLOCK ROM_COS altsyncram_component wrcontrol_aclr_b", false,-1, 31,0);
        tracep->declQuad(c+309,"fht_top ROM_BLOCK ROM_COS altsyncram_component wrcontrol_wraddress_reg_b", false,-1, 47,0);
        tracep->declArray(c+337,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_core_a", false,-1, 119,0);
        tracep->declArray(c+337,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock_enable_core_b", false,-1, 119,0);
        tracep->declQuad(c+331,"fht_top ROM_BLOCK ROM_COS altsyncram_component enable_ecc", false,-1, 39,0);
        tracep->declArray(c+341,"fht_top ROM_BLOCK ROM_COS altsyncram_component read_during_write_mode_port_a", false,-1, 159,0);
        tracep->declArray(c+341,"fht_top ROM_BLOCK ROM_COS altsyncram_component read_during_write_mode_port_b", false,-1, 159,0);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component wren_a", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component wren_b", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component rden_a", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component rden_b", false,-1);
        tracep->declBus(c+385,"fht_top ROM_BLOCK ROM_COS altsyncram_component data_a", false,-1, 12,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component data_b", false,-1, 0,0);
        tracep->declBus(c+50,"fht_top ROM_BLOCK ROM_COS altsyncram_component address_a", false,-1, 6,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component address_b", false,-1, 0,0);
        tracep->declBit(c+269,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock0", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component clock1", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component clocken0", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component clocken1", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component clocken2", false,-1);
        tracep->declBit(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component clocken3", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component aclr0", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component aclr1", false,-1);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component byteena_a", false,-1, 0,0);
        tracep->declBus(c+347,"fht_top ROM_BLOCK ROM_COS altsyncram_component byteena_b", false,-1, 0,0);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component addressstall_a", false,-1);
        tracep->declBit(c+346,"fht_top ROM_BLOCK ROM_COS altsyncram_component addressstall_b", false,-1);
        tracep->declBus(c+300,"fht_top ROM_BLOCK ROM_COS altsyncram_component q_a", false,-1, 12,0);
        tracep->declBus(c+388,"fht_top ROM_BLOCK ROM_COS altsyncram_component q_b", false,-1, 0,0);
        tracep->declBus(c+389,"fht_top ROM_BLOCK ROM_COS altsyncram_component eccstatus", false,-1, 2,0);
    }
}

void Vfht_top::traceRegister(VerilatedVcd* tracep) {
    // Body
    {
        tracep->addFullCb(&traceFullTop0, __VlSymsp);
        tracep->addChgCb(&traceChgTop0, __VlSymsp);
        tracep->addCleanupCb(&traceCleanup, __VlSymsp);
    }
}

void Vfht_top::traceFullTop0(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceFullSub0(userp, tracep);
    }
}

void Vfht_top::traceFullSub0(void* userp, VerilatedVcd* tracep) {
    Vfht_top__Syms* __restrict vlSymsp = static_cast<Vfht_top__Syms*>(userp);
    Vfht_top* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Variables
    WData/*95:0*/ __Vtemp1[3];
    WData/*95:0*/ __Vtemp2[3];
    WData/*95:0*/ __Vtemp3[3];
    WData/*95:0*/ __Vtemp4[3];
    WData/*95:0*/ __Vtemp5[3];
    WData/*95:0*/ __Vtemp6[3];
    WData/*127:0*/ __Vtemp7[4];
    WData/*159:0*/ __Vtemp8[5];
    WData/*191:0*/ __Vtemp9[6];
    WData/*95:0*/ __Vtemp10[3];
    // Body
    {
        tracep->fullIData(oldp+1,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[0]),27);
        tracep->fullIData(oldp+2,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[1]),27);
        tracep->fullIData(oldp+3,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[2]),27);
        tracep->fullIData(oldp+4,(vlTOPp->fht_top__DOT__DATA_RAM_A_BUT[3]),27);
        tracep->fullIData(oldp+5,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[0]),27);
        tracep->fullIData(oldp+6,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[1]),27);
        tracep->fullIData(oldp+7,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[2]),27);
        tracep->fullIData(oldp+8,(vlTOPp->fht_top__DOT__DATA_RAM_B_BUT[3]),27);
        tracep->fullIData(oldp+9,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                  [0U]),27);
        tracep->fullIData(oldp+10,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                   [1U]),27);
        tracep->fullIData(oldp+11,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                   [2U]),27);
        tracep->fullIData(oldp+12,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT
                                   [3U]),27);
        tracep->fullIData(oldp+13,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[0]),27);
        tracep->fullIData(oldp+14,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[1]),27);
        tracep->fullIData(oldp+15,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[2]),27);
        tracep->fullIData(oldp+16,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT[3]),27);
        tracep->fullIData(oldp+17,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                   [0U]),27);
        tracep->fullIData(oldp+18,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                   [1U]),27);
        tracep->fullIData(oldp+19,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                   [2U]),27);
        tracep->fullIData(oldp+20,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT
                                   [3U]),27);
        tracep->fullIData(oldp+21,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[0]),27);
        tracep->fullIData(oldp+22,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[1]),27);
        tracep->fullIData(oldp+23,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[2]),27);
        tracep->fullIData(oldp+24,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT[3]),27);
        tracep->fullBit(oldp+25,(vlTOPp->fht_top__DOT__CONTROL__DOT__source_data));
        tracep->fullBit(oldp+26,(vlTOPp->fht_top__DOT__CONTROL__DOT__source_cont));
        tracep->fullBit(oldp+27,(vlTOPp->fht_top__DOT__CONTROL__DOT__rdy));
        tracep->fullIData(oldp+28,(vlTOPp->fht_top__DOT__DATA_BUT[0]),27);
        tracep->fullIData(oldp+29,(vlTOPp->fht_top__DOT__DATA_BUT[1]),27);
        tracep->fullIData(oldp+30,(vlTOPp->fht_top__DOT__DATA_BUT[2]),27);
        tracep->fullIData(oldp+31,(vlTOPp->fht_top__DOT__DATA_BUT[3]),27);
        tracep->fullSData(oldp+32,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[0]),9);
        tracep->fullSData(oldp+33,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[1]),9);
        tracep->fullSData(oldp+34,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[2]),9);
        tracep->fullSData(oldp+35,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL[3]),9);
        tracep->fullSData(oldp+36,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[0]),9);
        tracep->fullSData(oldp+37,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[1]),9);
        tracep->fullSData(oldp+38,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[2]),9);
        tracep->fullSData(oldp+39,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL[3]),9);
        tracep->fullIData(oldp+40,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[0]),27);
        tracep->fullIData(oldp+41,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[1]),27);
        tracep->fullIData(oldp+42,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[2]),27);
        tracep->fullIData(oldp+43,(vlTOPp->fht_top__DOT__DATA_BUT_RAM[3]),27);
        tracep->fullBit(oldp+44,(vlTOPp->fht_top__DOT__CONTROL__DOT__we_a));
        tracep->fullBit(oldp+45,(vlTOPp->fht_top__DOT__CONTROL__DOT__we_b));
        tracep->fullBit(oldp+46,(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE));
        tracep->fullBit(oldp+47,((0xaU == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))));
        tracep->fullBit(oldp+48,((1U & (((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                         >> 3U) & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE))))));
        tracep->fullSData(oldp+49,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_d),9);
        tracep->fullCData(oldp+50,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef),7);
        tracep->fullSData(oldp+51,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                                     ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)
                                     : (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0))),13);
        tracep->fullSData(oldp+52,((0x1fffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__ZERO_STAGE)
                                                ? (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0)
                                                : ((IData)(1U) 
                                                   + 
                                                   (~ (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0)))))),13);
        tracep->fullSData(oldp+53,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN)
                                     ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias)
                                     : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))),9);
        tracep->fullSData(oldp+54,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD)
                                     ? (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias)
                                     : (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))),9);
        tracep->fullSData(oldp+55,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d),9);
        tracep->fullSData(oldp+56,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_bias),9);
        tracep->fullBit(oldp+57,(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2));
        tracep->fullBit(oldp+58,((1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__clk_2)))));
        tracep->fullCData(oldp+59,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage),4);
        tracep->fullSData(oldp+60,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time),10);
        tracep->fullSData(oldp+61,(vlTOPp->fht_top__DOT__CONTROL__DOT__div),10);
        tracep->fullCData(oldp+62,(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2),4);
        tracep->fullSData(oldp+63,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector),9);
        tracep->fullSData(oldp+64,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time),9);
        tracep->fullSData(oldp+65,(vlTOPp->fht_top__DOT__CONTROL__DOT__size_bias_rd),10);
        tracep->fullSData(oldp+66,(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd),10);
        tracep->fullSData(oldp+67,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt),9);
        tracep->fullSData(oldp+68,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_bias),9);
        tracep->fullSData(oldp+69,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt),9);
        tracep->fullCData(oldp+70,(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_coef_cnt),7);
        tracep->fullCData(oldp+71,(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d),4);
        tracep->fullBit(oldp+72,((2U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+73,((1U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+74,((0x1ffU <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+75,((0x200U <= (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+76,((0x202U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+77,((0x201U == (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage_time))));
        tracep->fullBit(oldp+78,(vlTOPp->fht_top__DOT__CONTROL__DOT__EOF_SECTOR));
        tracep->fullBit(oldp+79,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                                  == ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                      - (IData)(2U)))));
        tracep->fullBit(oldp+80,(((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_sector_time) 
                                  >= (0x3ffU & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                >> 1U)))));
        tracep->fullBit(oldp+81,((1U & ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d) 
                                        >> 3U))));
        tracep->fullBit(oldp+82,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_RD));
        tracep->fullBit(oldp+83,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_WR));
        tracep->fullBit(oldp+84,(vlTOPp->fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF));
        tracep->fullBit(oldp+85,((1U & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage))));
        tracep->fullBit(oldp+86,((1U & (~ (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_stage)))));
        tracep->fullSData(oldp+87,((0x1ffU & ((IData)(1U) 
                                              + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt)))),9);
        tracep->fullSData(oldp+88,((0x7ffU & ((0x1ffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_rd_cnt))) 
                                              + ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__cnt_bias_rd) 
                                                 << (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div_2))))),11);
        tracep->fullSData(oldp+89,((0x1ffU & ((8U & (IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__sec_part_subsec_d))
                                               ? ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt) 
                                                  - 
                                                  ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                   >> 1U))
                                               : ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__addr_wr_cnt) 
                                                  + 
                                                  ((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__div) 
                                                   >> 1U))))),9);
        tracep->fullBit(oldp+90,(vlTOPp->fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD));
        tracep->fullBit(oldp+91,(vlTOPp->fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD));
        tracep->fullBit(oldp+92,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS));
        tracep->fullBit(oldp+93,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN));
        tracep->fullBit(oldp+94,(vlTOPp->fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD));
        tracep->fullIData(oldp+95,(vlTOPp->fht_top__DOT__DATA_BUT
                                   [0U]),27);
        tracep->fullIData(oldp+96,(vlTOPp->fht_top__DOT__DATA_BUT
                                   [1U]),27);
        tracep->fullIData(oldp+97,(vlTOPp->fht_top__DOT__DATA_BUT
                                   [2U]),27);
        tracep->fullIData(oldp+98,(vlTOPp->fht_top__DOT__DATA_BUT
                                   [3U]),27);
        tracep->fullIData(oldp+99,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                   [0U]),27);
        tracep->fullIData(oldp+100,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                    [1U]),27);
        tracep->fullIData(oldp+101,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                    [2U]),27);
        tracep->fullIData(oldp+102,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf
                                    [3U]),27);
        tracep->fullSData(oldp+103,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin[0]),13);
        tracep->fullSData(oldp+104,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin[1]),13);
        tracep->fullSData(oldp+105,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos[0]),13);
        tracep->fullSData(oldp+106,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos[1]),13);
        tracep->fullIData(oldp+107,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[0]),27);
        tracep->fullIData(oldp+108,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[1]),27);
        tracep->fullIData(oldp+109,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[2]),27);
        tracep->fullIData(oldp+110,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__mux_buf[3]),27);
        tracep->fullIData(oldp+111,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[0]),27);
        tracep->fullIData(oldp+112,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[1]),27);
        tracep->fullIData(oldp+113,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0[2]),27);
        tracep->fullIData(oldp+114,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[0]),27);
        tracep->fullIData(oldp+115,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[1]),27);
        tracep->fullIData(oldp+116,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1[2]),27);
        tracep->fullIData(oldp+117,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[0]),27);
        tracep->fullIData(oldp+118,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[1]),27);
        tracep->fullIData(oldp+119,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[2]),27);
        tracep->fullIData(oldp+120,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX[3]),27);
        tracep->fullIData(oldp+121,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                    [0U]),27);
        tracep->fullIData(oldp+122,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                    [1U]),27);
        tracep->fullIData(oldp+123,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf
                                    [2U]),27);
        tracep->fullIData(oldp+124,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[0]),27);
        tracep->fullIData(oldp+125,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[1]),27);
        tracep->fullIData(oldp+126,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf[2]),27);
        tracep->fullIData(oldp+127,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                    [0U]),27);
        tracep->fullIData(oldp+128,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                    [1U]),27);
        tracep->fullIData(oldp+129,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf
                                    [2U]),27);
        tracep->fullIData(oldp+130,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[0]),27);
        tracep->fullIData(oldp+131,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[1]),27);
        tracep->fullIData(oldp+132,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf[2]),27);
        tracep->fullIData(oldp+133,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                    [0U]),27);
        tracep->fullIData(oldp+134,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                    [1U]),27);
        tracep->fullIData(oldp+135,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0
                                    [2U]),27);
        tracep->fullSData(oldp+136,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                    [0U]),13);
        tracep->fullSData(oldp+137,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                    [0U]),13);
        tracep->fullIData(oldp+138,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf),27);
        tracep->fullIData(oldp+139,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf),27);
        tracep->fullQData(oldp+140,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul),41);
        tracep->fullQData(oldp+142,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0),41);
        tracep->fullQData(oldp+144,((0x1ffffffffffULL 
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
        tracep->fullQData(oldp+146,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM),42);
        tracep->fullQData(oldp+148,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB),42);
        tracep->fullBit(oldp+150,((IData)((0x800ULL 
                                           == (0x4000000800ULL 
                                               & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM)))));
        tracep->fullBit(oldp+151,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                            >> 0x26U)) 
                                   & (0x800U < (0xfffU 
                                                & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM))))));
        tracep->fullBit(oldp+152,((IData)((0x800ULL 
                                           == (0x4000000800ULL 
                                               & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB)))));
        tracep->fullBit(oldp+153,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                            >> 0x26U)) 
                                   & (0x800U < (0xfffU 
                                                & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB))))));
        tracep->fullIData(oldp+154,((0x7ffffffU & (
                                                   (1U 
                                                    & ((IData)(
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
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                               >> 0xcU)))
                                                    : (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM 
                                                               >> 0xcU))))),27);
        tracep->fullIData(oldp+155,((0x7ffffffU & (
                                                   (1U 
                                                    & ((IData)(
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
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                               >> 0xcU)))
                                                    : (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB 
                                                               >> 0xcU))))),27);
        tracep->fullIData(oldp+156,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                    [0U]),27);
        tracep->fullIData(oldp+157,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                    [1U]),27);
        tracep->fullIData(oldp+158,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1
                                    [2U]),27);
        tracep->fullSData(oldp+159,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__sin
                                    [1U]),13);
        tracep->fullSData(oldp+160,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__cos
                                    [1U]),13);
        tracep->fullIData(oldp+161,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf),27);
        tracep->fullIData(oldp+162,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf),27);
        tracep->fullQData(oldp+163,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul),41);
        tracep->fullQData(oldp+165,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0),41);
        tracep->fullQData(oldp+167,((0x1ffffffffffULL 
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
        tracep->fullQData(oldp+169,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM),42);
        tracep->fullQData(oldp+171,(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB),42);
        tracep->fullBit(oldp+173,((IData)((0x800ULL 
                                           == (0x4000000800ULL 
                                               & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM)))));
        tracep->fullBit(oldp+174,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                            >> 0x26U)) 
                                   & (0x800U < (0xfffU 
                                                & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM))))));
        tracep->fullBit(oldp+175,((IData)((0x800ULL 
                                           == (0x4000000800ULL 
                                               & vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB)))));
        tracep->fullBit(oldp+176,(((IData)((vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                            >> 0x26U)) 
                                   & (0x800U < (0xfffU 
                                                & (IData)(vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB))))));
        tracep->fullIData(oldp+177,((0x7ffffffU & (
                                                   (1U 
                                                    & ((IData)(
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
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                               >> 0xcU)))
                                                    : (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM 
                                                               >> 0xcU))))),27);
        tracep->fullIData(oldp+178,((0x7ffffffU & (
                                                   (1U 
                                                    & ((IData)(
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
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                               >> 0xcU)))
                                                    : (IData)(
                                                              (vlTOPp->fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB 
                                                               >> 0xcU))))),27);
        tracep->fullIData(oldp+179,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                    [0U]),27);
        tracep->fullIData(oldp+180,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                    [1U]),27);
        tracep->fullIData(oldp+181,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                    [2U]),27);
        tracep->fullIData(oldp+182,(vlTOPp->fht_top__DOT__DATA_BUT_RAM
                                    [3U]),27);
        tracep->fullSData(oldp+183,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                    [0U]),9);
        tracep->fullSData(oldp+184,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                    [1U]),9);
        tracep->fullSData(oldp+185,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                    [2U]),9);
        tracep->fullSData(oldp+186,(vlTOPp->fht_top__DOT__ADDR_RD_CTRL
                                    [3U]),9);
        tracep->fullSData(oldp+187,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                    [0U]),9);
        tracep->fullSData(oldp+188,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                    [1U]),9);
        tracep->fullSData(oldp+189,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                    [2U]),9);
        tracep->fullSData(oldp+190,(vlTOPp->fht_top__DOT__ADDR_WR_CTRL
                                    [3U]),9);
        tracep->fullIData(oldp+191,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[0]),27);
        tracep->fullIData(oldp+192,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[1]),27);
        tracep->fullIData(oldp+193,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[2]),27);
        tracep->fullIData(oldp+194,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN[3]),27);
        tracep->fullSData(oldp+195,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[0]),9);
        tracep->fullSData(oldp+196,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[1]),9);
        tracep->fullSData(oldp+197,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[2]),9);
        tracep->fullSData(oldp+198,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD[3]),9);
        tracep->fullSData(oldp+199,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[0]),9);
        tracep->fullSData(oldp+200,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[1]),9);
        tracep->fullSData(oldp+201,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[2]),9);
        tracep->fullSData(oldp+202,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR[3]),9);
        tracep->fullCData(oldp+203,((0xfU & (- (IData)((IData)(vlTOPp->fht_top__DOT__CONTROL__DOT__we_b))))),4);
        tracep->fullIData(oldp+204,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                    [0U]),27);
        tracep->fullSData(oldp+205,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                    [0U]),9);
        tracep->fullSData(oldp+206,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                    [0U]),9);
        tracep->fullIData(oldp+207,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                    [1U]),27);
        tracep->fullSData(oldp+208,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                    [1U]),9);
        tracep->fullSData(oldp+209,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                    [1U]),9);
        tracep->fullIData(oldp+210,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                    [2U]),27);
        tracep->fullSData(oldp+211,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                    [2U]),9);
        tracep->fullSData(oldp+212,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                    [2U]),9);
        tracep->fullIData(oldp+213,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__DATA_IN
                                    [3U]),27);
        tracep->fullSData(oldp+214,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD
                                    [3U]),9);
        tracep->fullSData(oldp+215,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR
                                    [3U]),9);
        tracep->fullIData(oldp+216,(vlTOPp->fht_top__DOT__DATA_RAM_A[0]),27);
        tracep->fullIData(oldp+217,(vlTOPp->fht_top__DOT__DATA_RAM_A[1]),27);
        tracep->fullIData(oldp+218,(vlTOPp->fht_top__DOT__DATA_RAM_A[2]),27);
        tracep->fullIData(oldp+219,(vlTOPp->fht_top__DOT__DATA_RAM_A[3]),27);
        tracep->fullSData(oldp+220,(vlTOPp->fht_top__DOT__ADDR_RD[0]),9);
        tracep->fullSData(oldp+221,(vlTOPp->fht_top__DOT__ADDR_RD[1]),9);
        tracep->fullSData(oldp+222,(vlTOPp->fht_top__DOT__ADDR_RD[2]),9);
        tracep->fullSData(oldp+223,(vlTOPp->fht_top__DOT__ADDR_RD[3]),9);
        tracep->fullSData(oldp+224,(vlTOPp->fht_top__DOT__ADDR_WR[0]),9);
        tracep->fullSData(oldp+225,(vlTOPp->fht_top__DOT__ADDR_WR[1]),9);
        tracep->fullSData(oldp+226,(vlTOPp->fht_top__DOT__ADDR_WR[2]),9);
        tracep->fullSData(oldp+227,(vlTOPp->fht_top__DOT__ADDR_WR[3]),9);
        tracep->fullCData(oldp+228,(vlTOPp->fht_top__DOT__WE),4);
        tracep->fullIData(oldp+229,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                    [0U]),27);
        tracep->fullIData(oldp+230,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                    [1U]),27);
        tracep->fullIData(oldp+231,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                    [2U]),27);
        tracep->fullIData(oldp+232,(vlTOPp->fht_top__DOT__DATA_RAM_A
                                    [3U]),27);
        tracep->fullSData(oldp+233,(vlTOPp->fht_top__DOT__ADDR_RD
                                    [0U]),9);
        tracep->fullSData(oldp+234,(vlTOPp->fht_top__DOT__ADDR_RD
                                    [1U]),9);
        tracep->fullSData(oldp+235,(vlTOPp->fht_top__DOT__ADDR_RD
                                    [2U]),9);
        tracep->fullSData(oldp+236,(vlTOPp->fht_top__DOT__ADDR_RD
                                    [3U]),9);
        tracep->fullSData(oldp+237,(vlTOPp->fht_top__DOT__ADDR_WR
                                    [0U]),9);
        tracep->fullSData(oldp+238,(vlTOPp->fht_top__DOT__ADDR_WR
                                    [1U]),9);
        tracep->fullSData(oldp+239,(vlTOPp->fht_top__DOT__ADDR_WR
                                    [2U]),9);
        tracep->fullSData(oldp+240,(vlTOPp->fht_top__DOT__ADDR_WR
                                    [3U]),9);
        tracep->fullBit(oldp+241,((1U & (IData)(vlTOPp->fht_top__DOT__WE))));
        tracep->fullBit(oldp+242,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                         >> 1U))));
        tracep->fullBit(oldp+243,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                         >> 2U))));
        tracep->fullBit(oldp+244,((1U & ((IData)(vlTOPp->fht_top__DOT__WE) 
                                         >> 3U))));
        tracep->fullIData(oldp+245,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[0]),27);
        tracep->fullIData(oldp+246,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[1]),27);
        tracep->fullIData(oldp+247,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[2]),27);
        tracep->fullIData(oldp+248,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN[3]),27);
        tracep->fullSData(oldp+249,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[0]),9);
        tracep->fullSData(oldp+250,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[1]),9);
        tracep->fullSData(oldp+251,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[2]),9);
        tracep->fullSData(oldp+252,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD[3]),9);
        tracep->fullSData(oldp+253,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[0]),9);
        tracep->fullSData(oldp+254,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[1]),9);
        tracep->fullSData(oldp+255,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[2]),9);
        tracep->fullSData(oldp+256,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR[3]),9);
        tracep->fullIData(oldp+257,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                    [0U]),27);
        tracep->fullSData(oldp+258,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                    [0U]),9);
        tracep->fullSData(oldp+259,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                    [0U]),9);
        tracep->fullIData(oldp+260,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                    [1U]),27);
        tracep->fullSData(oldp+261,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                    [1U]),9);
        tracep->fullSData(oldp+262,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                    [1U]),9);
        tracep->fullIData(oldp+263,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                    [2U]),27);
        tracep->fullSData(oldp+264,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                    [2U]),9);
        tracep->fullSData(oldp+265,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                    [2U]),9);
        tracep->fullIData(oldp+266,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__DATA_IN
                                    [3U]),27);
        tracep->fullSData(oldp+267,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD
                                    [3U]),9);
        tracep->fullSData(oldp+268,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR
                                    [3U]),9);
        tracep->fullBit(oldp+269,(vlTOPp->iCLK));
        tracep->fullBit(oldp+270,(vlTOPp->iRESET));
        tracep->fullBit(oldp+271,(vlTOPp->iSTART));
        tracep->fullCData(oldp+272,(vlTOPp->iWE),4);
        tracep->fullIData(oldp+273,(vlTOPp->iDATA_0),27);
        tracep->fullIData(oldp+274,(vlTOPp->iDATA_1),27);
        tracep->fullIData(oldp+275,(vlTOPp->iDATA_2),27);
        tracep->fullIData(oldp+276,(vlTOPp->iDATA_3),27);
        tracep->fullSData(oldp+277,(vlTOPp->iADDR_WR_0),9);
        tracep->fullSData(oldp+278,(vlTOPp->iADDR_WR_1),9);
        tracep->fullSData(oldp+279,(vlTOPp->iADDR_WR_2),9);
        tracep->fullSData(oldp+280,(vlTOPp->iADDR_WR_3),9);
        tracep->fullSData(oldp+281,(vlTOPp->iADDR_RD_0),9);
        tracep->fullSData(oldp+282,(vlTOPp->iADDR_RD_1),9);
        tracep->fullSData(oldp+283,(vlTOPp->iADDR_RD_2),9);
        tracep->fullSData(oldp+284,(vlTOPp->iADDR_RD_3),9);
        tracep->fullIData(oldp+285,(vlTOPp->oDATA_0),27);
        tracep->fullIData(oldp+286,(vlTOPp->oDATA_1),27);
        tracep->fullIData(oldp+287,(vlTOPp->oDATA_2),27);
        tracep->fullIData(oldp+288,(vlTOPp->oDATA_3),27);
        tracep->fullBit(oldp+289,(vlTOPp->oRDY));
        tracep->fullIData(oldp+290,(0x1bU),32);
        tracep->fullIData(oldp+291,(9U),32);
        tracep->fullIData(oldp+292,(0xdU),32);
        __Vtemp1[0U] = 0x2e6d6966U;
        __Vtemp1[1U] = 0x2f73696eU;
        __Vtemp1[2U] = 0x2eU;
        tracep->fullWData(oldp+293,(__Vtemp1),72);
        __Vtemp2[0U] = 0x2e6d6966U;
        __Vtemp2[1U] = 0x2f636f73U;
        __Vtemp2[2U] = 0x2eU;
        tracep->fullWData(oldp+296,(__Vtemp2),72);
        tracep->fullSData(oldp+299,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0),13);
        tracep->fullSData(oldp+300,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0),13);
        tracep->fullIData(oldp+301,(0x200U),32);
        tracep->fullIData(oldp+302,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullQData(oldp+303,(0x554e55534544ULL),48);
        tracep->fullIData(oldp+305,(0x4e4f4e45U),32);
        tracep->fullQData(oldp+306,(0x434c4f434b30ULL),48);
        tracep->fullIData(oldp+308,(8U),32);
        tracep->fullQData(oldp+309,(0x434c4f434b31ULL),48);
        tracep->fullQData(oldp+311,(0x425950415353ULL),48);
        tracep->fullQData(oldp+313,(0x4e4f524d414cULL),48);
        tracep->fullQData(oldp+315,(0x504f52545f41ULL),48);
        __Vtemp3[0U] = 0x49562045U;
        __Vtemp3[1U] = 0x6f6e6520U;
        __Vtemp3[2U] = 0x4379636cU;
        tracep->fullWData(oldp+317,(__Vtemp3),96);
        tracep->fullIData(oldp+320,(0x4f4646U),24);
        __Vtemp4[0U] = 0x6372616dU;
        __Vtemp4[1U] = 0x7473796eU;
        __Vtemp4[2U] = 0x616cU;
        tracep->fullWData(oldp+321,(__Vtemp4),80);
        tracep->fullIData(oldp+324,(0U),32);
        __Vtemp5[0U] = 0x504f5254U;
        __Vtemp5[1U] = 0x55414c5fU;
        __Vtemp5[2U] = 0x44U;
        tracep->fullWData(oldp+325,(__Vtemp5),72);
        __Vtemp6[0U] = 0x45524544U;
        __Vtemp6[1U] = 0x47495354U;
        __Vtemp6[2U] = 0x554e5245U;
        tracep->fullWData(oldp+328,(__Vtemp6),96);
        tracep->fullQData(oldp+331,(0x46414c5345ULL),40);
        tracep->fullIData(oldp+333,(0x4155544fU),32);
        tracep->fullQData(oldp+334,(0x4f4c445f44415441ULL),64);
        tracep->fullIData(oldp+336,(1U),32);
        __Vtemp7[0U] = 0x4c4b454eU;
        __Vtemp7[1U] = 0x55545f43U;
        __Vtemp7[2U] = 0x5f494e50U;
        __Vtemp7[3U] = 0x555345U;
        tracep->fullWData(oldp+337,(__Vtemp7),120);
        __Vtemp8[0U] = 0x52454144U;
        __Vtemp8[1U] = 0x4e42455fU;
        __Vtemp8[2U] = 0x5f4e4f5fU;
        __Vtemp8[3U] = 0x44415441U;
        __Vtemp8[4U] = 0x4e45575fU;
        tracep->fullWData(oldp+341,(__Vtemp8),160);
        tracep->fullBit(oldp+346,(0U));
        tracep->fullBit(oldp+347,(1U));
        tracep->fullIData(oldp+348,(0x7ffffffU),27);
        tracep->fullIData(oldp+349,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+350,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+351,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+352,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+353,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+354,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+355,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+356,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+357,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+358,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+359,(vlTOPp->fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+360,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+361,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+362,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+363,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+364,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+365,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+366,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+367,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+368,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+369,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0),27);
        tracep->fullIData(oldp+370,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a),27);
        tracep->fullCData(oldp+371,(vlTOPp->fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullIData(oldp+372,(7U),32);
        tracep->fullIData(oldp+373,(0x80U),32);
        tracep->fullSData(oldp+374,((0x1fffU & ((IData)(1U) 
                                                + (~ (IData)(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0))))),13);
        __Vtemp9[0U] = 0x443d4e4fU;
        __Vtemp9[1U] = 0x455f4d4fU;
        __Vtemp9[2U] = 0x4e54494dU;
        __Vtemp9[3U] = 0x455f5255U;
        __Vtemp9[4U] = 0x4e41424cU;
        __Vtemp9[5U] = 0x45U;
        tracep->fullWData(oldp+375,(__Vtemp9),168);
        tracep->fullIData(oldp+381,(0x524f4dU),24);
        __Vtemp10[0U] = 0x43415245U;
        __Vtemp10[1U] = 0x4f4e545fU;
        __Vtemp10[2U] = 0x44U;
        tracep->fullWData(oldp+382,(__Vtemp10),72);
        tracep->fullSData(oldp+385,(0x1fffU),13);
        tracep->fullBit(oldp+386,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__q_b));
        tracep->fullCData(oldp+387,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__eccstatus),3);
        tracep->fullBit(oldp+388,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__q_b));
        tracep->fullCData(oldp+389,(vlTOPp->fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__eccstatus),3);
    }
}
