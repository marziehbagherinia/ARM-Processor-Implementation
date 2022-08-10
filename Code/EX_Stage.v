`include "Defines.v"

module EX_Stage(clk, 
                rst,
                PC_in,
                wb_en_in, 
                mem_r_en_in, 
                mem_w_en_in, 
                status_w_en_in, 
                branch_taken_in,
                immd,
                exe_cmd,
                val_Rn, 
                val_Rm_in,
                dest_in,
                signed_immd_24,
                shift_operand,
                status_reg_in,
                //forwarding inputs:
                alu_mux_sel_src1, 
                alu_mux_sel_src2,
                MEM_wb_value, 
                WB_wb_value,
                // output[`ADDRESS_LEN - 1:0] PC_out,
                wb_en_out, 
                mem_r_en_out, 
                mem_w_en_out, 
                status_w_en_out, 
                branch_taken_out,
                dest_out,
                alu_res, 
                val_Rm_out,
                statusRegister,
                branch_address);
	
	input clk, 
	      rst,
	      wb_en_in, 
	      mem_r_en_in, 
	      mem_w_en_in, 
	      status_w_en_in, 
	      branch_taken_in,
	      immd;
	      
	input [1:0] alu_mux_sel_src1, 
	            alu_mux_sel_src2;
	input [3:0] status_reg_in;
	input [11:0] shift_operand;
	input [23:0] signed_immd_24;
			            	      
	input [`ADDRESS_LEN - 1:0] PC_in;
	input [`REGISTER_LEN - 1:0] val_Rn, 
	                            val_Rm_in;
	input [`REGISTER_LEN - 1:0] MEM_wb_value, 
	                            WB_wb_value;
	input [`REG_ADDRESS_LEN - 1:0] dest_in;
	input [`EXECUTE_COMMAND_LEN - 1:0] exe_cmd;

	output wb_en_out, 
	       mem_r_en_out, 
	       mem_w_en_out, 
	       status_w_en_out, 
	       branch_taken_out;
	output [3:0] statusRegister;      
	output [`REGISTER_LEN - 1:0] alu_res, 
	                             val_Rm_out;
	output [`REG_ADDRESS_LEN - 1:0] dest_out;
	output[`ADDRESS_LEN - 1:0] branch_address;
	
	wire is_mem_command;
	wire [`REGISTER_LEN - 1:0] val2,
	                           alu_mux_src1, 
	                           alu_mux_src2;

	assign wb_en_out = wb_en_in;
	assign mem_r_en_out = mem_r_en_in;
	assign mem_w_en_out = mem_w_en_in;
	assign status_w_en_out = status_w_en_in;
	assign branch_taken_out = branch_taken_in;
	assign dest_out = dest_in;
	assign is_mem_command = mem_r_en_in | mem_w_en_in;

	Adder #(.WORD_LENGTH(`ADDRESS_LEN)) adder(.in1(PC_in), 
	                                          .in2({signed_immd_24[23],
			                                            signed_immd_24[23], 
			                                            signed_immd_24[23], 
			                                            signed_immd_24[23],
			                                            signed_immd_24[23], 
			                                            signed_immd_24[23],
			                                            signed_immd_24, 
			                                            2'b0}),
	                                          .out(branch_address));	

	/////////// ALU src 1 MUX ///////////
	MUX_3_to_1 alu_src1_mux(.first(val_Rn), 
	                        .second(WB_wb_value), 
	                        .third(MEM_wb_value), 
	                        .sel(alu_mux_sel_src1), 
	                        .out(alu_mux_src1));

	/////////// Val2 Generator ///////////
	MUX_3_to_1 alu_src2_mux(.first(val_Rm_in), 
	                        .second(WB_wb_value), 
	                        .third(MEM_wb_value), 
	                        .sel(alu_mux_sel_src2), 
	                        .out(alu_mux_src2));
	
	Val2Generator val2_generator(.Rm(alu_mux_src2), 
	                             .shift_operand(shift_operand), 
	                             .immd(immd),
			                         .is_mem_command(is_mem_command), 
			                         .val2_out(val2));
			                         
	assign val_Rm_out = alu_mux_src2;

	/////////// ALU ///////////
	ALU alu(.alu_in1(alu_mux_src1), 
	        .alu_in2(val2), 
	        .alu_command(exe_cmd), 
	        .cin(status_reg_in[2]),
			    .alu_out(alu_res), 
			    .statusRegister(statusRegister));

endmodule