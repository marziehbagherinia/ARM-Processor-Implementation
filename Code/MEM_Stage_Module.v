`include "Defines.v"

module MEM_Stage_Module(//inputs to main moduel:
                        clk, 
                        rst, 
                        freeze,
                        wb_en_in, 
                        mem_r_en_in, 
                        mem_w_en_in,
                        alu_res_in, val_Rm,
                        dest_in,
                        // outputs from Reg:
                        wb_en_out, 
                        mem_r_en_out,
                        alu_res_out, 
                        mem_res_out,
                        dest_out,
                        // outputs from stage:
                        wb_en_hazard_in,
                        ready,
                        dest_hazard_in);

	input clk, 
	      rst, 
	      freeze, 
	      wb_en_in, 
	      mem_r_en_in, 
	      mem_w_en_in;
	input [`REGISTER_LEN - 1:0] alu_res_in, 
	                            val_Rm;
	input [`REG_ADDRESS_LEN - 1:0] dest_in;
  
  output wb_en_out, 
         mem_r_en_out,
         wb_en_hazard_in,
         ready;
	output [`REGISTER_LEN - 1:0] alu_res_out, 
	                             mem_res_out;
	output [`REG_ADDRESS_LEN - 1:0] dest_out,
	                                dest_hazard_in;
	                                
  wire wb_en_middle, 
       mem_r_en_middle;
	wire [`REGISTER_LEN - 1:0] alu_res_middle, 
	                           mem_res_middle;
	wire [`REG_ADDRESS_LEN - 1:0] dest_middle;
  
  assign wb_en_hazard_in = wb_en_in;
  assign dest_hazard_in = dest_in;

	MEM_Stage memory_stage(//inputs:
                         .clk(clk),
                         .rst(rst),
                         .wb_en_in(wb_en_in),
                         .mem_r_en_in(mem_r_en_in),
                         .mem_w_en_in(mem_w_en_in),
                         .alu_res_in(alu_res_in),
                         .val_Rm(val_Rm),
                         .dest_in(dest_in),
                         // outputs to Reg:
                         .wb_en_out(wb_en_middle),
                         .mem_r_en_out(mem_r_en_middle),
                         .mem_out(mem_res_middle),
                         .alu_res_out(alu_res_middle),
                         .dest_out(dest_middle),
                         // outputs to top module:
                         .ready(ready));

  MEM_Stage_Reg mem_stage_reg(.clk(clk), 
                              .rst(rst),
                              .freeze(freeze),
                              //inputs:
                              .wb_en_in(wb_en_middle),
                              .mem_r_en_in(mem_r_en_middle),
                              .alu_res_in(alu_res_middle),
                              .mem_res_in(mem_res_middle),
                              .dest_in(dest_middle),
                              //outputs:
                              .wb_en_out(wb_en_out),
                              .mem_r_en_out(mem_r_en_out),
                              .alu_res_out(alu_res_out),
                              .mem_res_out(mem_res_out),
                              .dest_out(dest_out));

endmodule