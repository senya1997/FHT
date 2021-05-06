// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VFHT_TOP_H_
#define VERILATED_VFHT_TOP_H_  // guard

#include "verilated_heavy.h"

//==========

class Vfht_top__Syms;
class Vfht_top_VerilatedVcd;


//----------

VL_MODULE(Vfht_top) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(iCLK,0,0);
    VL_IN8(iRESET,0,0);
    VL_IN8(iSTART,0,0);
    VL_IN8(iWE,3,0);
    VL_OUT8(oRDY,0,0);
    VL_IN16(iADDR_WR_0,8,0);
    VL_IN16(iADDR_WR_1,8,0);
    VL_IN16(iADDR_WR_2,8,0);
    VL_IN16(iADDR_WR_3,8,0);
    VL_IN16(iADDR_RD_0,8,0);
    VL_IN16(iADDR_RD_1,8,0);
    VL_IN16(iADDR_RD_2,8,0);
    VL_IN16(iADDR_RD_3,8,0);
    VL_IN(iDATA_0,26,0);
    VL_IN(iDATA_1,26,0);
    VL_IN(iDATA_2,26,0);
    VL_IN(iDATA_3,26,0);
    VL_OUT(oDATA_0,26,0);
    VL_OUT(oDATA_1,26,0);
    VL_OUT(oDATA_2,26,0);
    VL_OUT(oDATA_3,26,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*3:0*/ fht_top__DOT__WE;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__clk_2;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__N_CLK_2;
        CData/*3:0*/ fht_top__DOT__CONTROL__DOT__cnt_stage;
        CData/*3:0*/ fht_top__DOT__CONTROL__DOT__div_2;
        CData/*6:0*/ fht_top__DOT__CONTROL__DOT__addr_coef_cnt;
        CData/*6:0*/ fht_top__DOT__CONTROL__DOT__addr_coef;
        CData/*3:0*/ fht_top__DOT__CONTROL__DOT__sec_part_subsec_d;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__we_a;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__we_b;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__source_data;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__source_cont;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__rdy;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__ZERO_STAGE;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__EOF_STAGE;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__EOF_SECTOR;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__RESET_CNT_RD;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__RESET_CNT_WR;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__RESET_CNT_COEF;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__NEW_BIAS_RD;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__CHOOSE_EN_NEW_BIAS_RD;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__EN_BIAS;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__EN_BIAS_EVEN;
        CData/*0:0*/ fht_top__DOT__CONTROL__DOT__EN_BIAS_ODD;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*2:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__eccstatus;
        CData/*0:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__q_b;
        CData/*2:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__altsyncram_component__DOT__eccstatus;
        CData/*0:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__q_b;
        CData/*2:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__altsyncram_component__DOT__eccstatus;
        SData/*9:0*/ fht_top__DOT__CONTROL__DOT__cnt_stage_time;
        SData/*9:0*/ fht_top__DOT__CONTROL__DOT__div;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__cnt_sector;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__cnt_sector_d;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__cnt_sector_time;
        SData/*9:0*/ fht_top__DOT__CONTROL__DOT__size_bias_rd;
        SData/*9:0*/ fht_top__DOT__CONTROL__DOT__cnt_bias_rd;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__addr_rd_cnt;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__addr_rd_bias;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__addr_wr_cnt;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__addr_wr_cnt_d;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__addr_wr_bias;
        SData/*8:0*/ fht_top__DOT__CONTROL__DOT__INC_ADDR_RD;
        SData/*12:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_SIN__DOT__sub_wire0;
        SData/*12:0*/ fht_top__DOT__ROM_BLOCK__DOT__ROM_COS__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_buf;
        IData/*26:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sub_buf;
        IData/*26:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_buf;
        IData/*26:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sub_buf;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_A__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__sub_wire0;
    };
    struct {
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__0__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__1__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__2__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__sub_wire0;
        IData/*26:0*/ fht_top__DOT__FHT_RAM_B__DOT__ram_bank__BRA__3__KET____DOT__RAM_BANK__DOT__altsyncram_component__DOT__q_a;
        QData/*40:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__sum_mul;
        QData/*40:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_X0;
        QData/*41:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUM;
        QData/*41:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_0__DOT__EXT_SUB;
        QData/*40:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__sum_mul;
        QData/*40:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_X0;
        QData/*41:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUM;
        QData/*41:0*/ fht_top__DOT__BUT_BLOCK__DOT__BUT_1__DOT__EXT_SUB;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__DATA_RAM_A;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__DATA_BUT;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__ADDR_RD_CTRL;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__ADDR_WR_CTRL;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__ADDR_RD;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__ADDR_WR;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__DATA_RAM_A_BUT;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__DATA_RAM_B_BUT;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__DATA_BUT_RAM;
        VlUnpacked<SData/*12:0*/, 2> fht_top__DOT__BUT_BLOCK__DOT__sin;
        VlUnpacked<SData/*12:0*/, 2> fht_top__DOT__BUT_BLOCK__DOT__cos;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__BUT_BLOCK__DOT__mux_buf;
        VlUnpacked<IData/*26:0*/, 3> fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_0;
        VlUnpacked<IData/*26:0*/, 3> fht_top__DOT__BUT_BLOCK__DOT__MIX_TO_BUT_1;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__BUT_BLOCK__DOT__BUT_TO_MIX;
        VlUnpacked<IData/*26:0*/, 3> fht_top__DOT__BUT_BLOCK__DOT__MIX_0__DOT__mux_buf;
        VlUnpacked<IData/*26:0*/, 3> fht_top__DOT__BUT_BLOCK__DOT__MIX_1__DOT__mux_buf;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__FHT_RAM_A__DOT__DATA_IN;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__FHT_RAM_A__DOT__ADDR_RD;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__FHT_RAM_A__DOT__ADDR_WR;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__FHT_RAM_A__DOT__DATA_OUT;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__FHT_RAM_B__DOT__DATA_IN;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__FHT_RAM_B__DOT__ADDR_RD;
        VlUnpacked<SData/*8:0*/, 4> fht_top__DOT__FHT_RAM_B__DOT__ADDR_WR;
        VlUnpacked<IData/*26:0*/, 4> fht_top__DOT__FHT_RAM_B__DOT__DATA_OUT;
    };
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*0:0*/ fht_top__DOT__CONTROL__DOT____Vlvbound1;
    CData/*0:0*/ __Vclklast__TOP__iCLK;
    CData/*0:0*/ __Vclklast__TOP__iRESET;
    VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vfht_top__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vfht_top);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vfht_top(VerilatedContext* contextp, const char* name = "TOP");
    Vfht_top(const char* name = "TOP")
      : Vfht_top(nullptr, name) {}
    /// Destroy the model; called (often implicitly) by application code
    ~Vfht_top();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    
    // API METHODS
    /// Return current simulation context for this model.
    /// Used to get to e.g. simulation time via contextp()->time()
    VerilatedContext* contextp();
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
    static void _eval_initial_loop(Vfht_top__Syms* __restrict vlSymsp);
    void __Vconfigure(Vfht_top__Syms* symsp, bool first);
  private:
    static QData _change_request(Vfht_top__Syms* __restrict vlSymsp);
    static QData _change_request_1(Vfht_top__Syms* __restrict vlSymsp);
  public:
    static void _combo__TOP__3(Vfht_top__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vfht_top__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(Vfht_top__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vfht_top__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(Vfht_top__Syms* __restrict vlSymsp);
    static void _settle__TOP__1(Vfht_top__Syms* __restrict vlSymsp) VL_ATTR_COLD;
  private:
    static void traceChgSub0(void* userp, VerilatedVcd* tracep);
    static void traceChgTop0(void* userp, VerilatedVcd* tracep);
    static void traceCleanup(void* userp, VerilatedVcd* /*unused*/);
    static void traceFullSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceFullTop0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitTop(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    void traceRegister(VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
