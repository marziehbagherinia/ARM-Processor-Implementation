`include "Defines.v"

module EX_Stage_Reg(clk, 
                    rst,
                    freeze,
                    wb_en_in, 
                    mem_r_en_in, 
                    mem_w_en_in,
                    alu_res_in, 
                    val_Rm_in,
                    dest_in,
                    branch_taken_in,
                    wb_en_out, 
                    mem_r_en_out, 
                    mem_w_en_out,
                    alu_res_out, 
                    val_Rm_out,
                    dest_out,
                    branch_taken_out);

	input clk, 
	      rst,
	      freeze,
	      wb_en_in, 
	      mem_r_en_in, 
	      mem_w_en_in,
	      branch_taken_in;
	      
	input [`REGISTER_LEN - 1:0] alu_res_in, 
	                            val_Rm_in;
	input [`REG_ADDRESS_LEN - 1:0] dest_in;
	
	output wb_en_out, 
	       mem_r_en_out, 
	       mem_w_en_out,
	       branch_taken_out;
	       
	output [`REGISTER_LEN - 1:0] alu_res_out, 
	                             val_Rm_out;
	output [`REG_ADDRESS_LEN - 1:0] dest_out;

	Register #(.WORD_LENGTH(1)) reg_wb_en(.clk(clk), 
	                                      .rst(rst),
			                                  .ld(~freeze), 
			                                  .in(wb_en_in), 
			                                  .out(wb_en_out));

	Register #(.WORD_LENGTH(1)) reg_mem_r_en(.clk(clk), 
	                                         .rst(rst),
	                                         .ld(~freeze), 
	                                         .in(mem_r_en_in), 
	                                         .out(mem_r_en_out));

	Register #(.WORD_LENGTH(1)) reg_mem_w_en(.clk(clk), 
		                                       .rst(rst),
	                                         .ld(~freeze), 
	                                         .in(mem_w_en_in), 
	                                         .out(mem_w_en_out));

	Register #(.WORD_LENGTH(`REGISTER_LEN)) reg_alu_res(.clk(clk), 
		                                                  .rst(rst),
		                                                  .ld(~freeze), 
		                                                  .in(alu_res_in), 
		                                                  .out(alu_res_out));

	Register #(.WORD_LENGTH(`REGISTER_LEN)) reg_val_Rm(.clk(clk), 
			                                               .rst(rst),
		                                                 .ld(~freeze), 
		                                                 .in(val_Rm_in), 
		                                                 .out(val_Rm_out));

	Register #(.WORD_LENGTH(`REG_ADDRESS_LEN)) reg_dest(.clk(clk), 
		                                                  .rst(rst),
		                                                  .ld(~freeze), 
		                                                  .in(dest_in), 
		                                                  .out(dest_out));
	
	Register #(.WORD_LENGTH(1)) reg_branch_taken(.clk(clk),
		                                           .rst(rst),
		                                           .ld(~freeze), 
		                                           .in(branch_taken_in), 
		                                           .out(branch_taken_out));
	
endmodule