`include "Defines.v"

module Hazard_Detection_Unit (with_forwarding,
                              have_two_src, 
                              ignore_hazard, 
                              ignore_from_forwarding,
                              EXE_mem_read_en,
                              src1_address, 
                              src2_address,
                              exe_wb_dest, 
                              mem_wb_dest,
                              exe_wb_en, mem_wb_en,
                              hazard_detected);
 
    input with_forwarding,
          have_two_src, 
          ignore_hazard, 
          ignore_from_forwarding,
          EXE_mem_read_en,
          exe_wb_en,
          mem_wb_en;
          
    input [`REG_ADDRESS_LEN - 1:0] src1_address, 
                                   src2_address,
                                   exe_wb_dest,
                                   mem_wb_dest;

    output hazard_detected;
      
    wire internal_hazard_with_forwarding,
         internal_hazard_without_forwarding;

    assign internal_hazard_with_forwarding = ((src1_address == exe_wb_dest) && (exe_wb_en == 1'b1)) ? 1'b1
                                           : ((src2_address == exe_wb_dest) && (exe_wb_en == 1'b1) && (have_two_src == 1'b1)) 
                                           ? 1'b1
                                           : 1'b0;

    assign internal_hazard_without_forwarding = ((src1_address == exe_wb_dest) && (exe_wb_en == 1'b1)) ? 1'b1
                                              : ((src1_address == mem_wb_dest) && (mem_wb_en == 1'b1)) ? 1'b1
                                              : ((src2_address == exe_wb_dest) && (exe_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
                                              : ((src2_address == mem_wb_dest) && (mem_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
                                              : 1'b0;

    assign hazard_detected = (ignore_hazard == 1'b1) ? 1'b0
                           : (with_forwarding == 1'b1) ? internal_hazard_with_forwarding & EXE_mem_read_en
                           : internal_hazard_without_forwarding;
endmodule