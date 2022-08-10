`include "Defines.v"

module Forwarding (en_forwarding,
                   WB_wb_en, 
                   MEM_wb_en,
                   MEM_dst, WB_dst, 
                   ID_src1, 
                   ID_src2,
                   sel_src1, 
                   sel_src2,
                   ignore_hazard);

  input en_forwarding,
        WB_wb_en, 
        MEM_wb_en;
  input [`REG_ADDRESS_LEN - 1:0] MEM_dst, 
                                 WB_dst, 
                                 ID_src1, 
                                 ID_src2;

  output ignore_hazard;
  output [1:0] sel_src1, 
               sel_src2;

  assign sel_src1 = (en_forwarding == 1'b1) 
                  ? ((MEM_wb_en && (MEM_dst == ID_src1)) 
                  ? `FORW_SEL_FROM_MEM
                  : (WB_wb_en && (WB_dst == ID_src1)) 
                  ? `FORW_SEL_FROM_WB
                  : 2'b0)
                  : 2'b0;

    assign sel_src2 = (en_forwarding == 1'b1) 
                    ? ((MEM_wb_en && (MEM_dst == ID_src2)) 
                    ? `FORW_SEL_FROM_MEM
                    : (WB_wb_en && (WB_dst == ID_src2)) 
                    ? `FORW_SEL_FROM_WB
                    : 2'b0)
                    : 2'b0;

    assign ignore_hazard = (en_forwarding == 1'b1) 
                         ? ((MEM_wb_en && ((MEM_dst == ID_src2) || (MEM_dst == ID_src1)))   
                         ? 1'b1
                         : (WB_wb_en && ((WB_dst == ID_src2) || (WB_dst == ID_src1)))    
                         ? 1'b1
                         : 1'b0)
                         : 1'b0;
endmodule