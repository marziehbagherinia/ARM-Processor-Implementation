`include "Defines.v"

module WB_Stage(clk,
	              rst,
	              mem_read_enable,
	              wb_enable_in,
	              alu_result,
	              data_memory,
	              wb_dest_in,
	              wb_enable_out,
		            wb_dest_out,
	              wb_value);
  input clk,
        rst,
        mem_read_enable,
        wb_enable_in;
	
	input [`REGISTER_LEN - 1:0] alu_result,
		                          data_memory;
	input [`REG_ADDRESS_LEN - 1:0] wb_dest_in;
	
	output wire wb_enable_out;
	output wire [`REGISTER_LEN - 1:0] wb_value;
	output wire [`REG_ADDRESS_LEN - 1:0] wb_dest_out;

	MUX_2_to_1 #(.WORD_LENGTH(`REGISTER_LEN)) wb_stage_mux(.first(data_memory), 
	                                                       .second(alu_result),
	                                                       .sel_first(mem_read_enable), 
	                                                       .sel_second(~mem_read_enable),
	                                                       .out(wb_value));
		
	assign wb_dest_out = wb_dest_in;
	assign wb_enable_out = wb_enable_in;

endmodule