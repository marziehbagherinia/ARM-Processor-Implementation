`include "Defines.v"

module MEM_Stage(clk, 
                 rst,
                 wb_en_in, 
                 mem_r_en_in, 
                 mem_w_en_in,
                 alu_res_in, 
                 val_Rm,
                 dest_in,
                 wb_en_out, 
                 mem_r_en_out,
                 mem_out, 
                 alu_res_out,
                 dest_out,
                 ready);

	input clk, 
	      rst,
	      wb_en_in, 
	      mem_r_en_in, 
	      mem_w_en_in;
	input [`REGISTER_LEN - 1:0] alu_res_in, 
	                            val_Rm;
	input [`REG_ADDRESS_LEN - 1:0] dest_in;

	output ready,
	       wb_en_out, 
	       mem_r_en_out;
	output [`REGISTER_LEN - 1:0] mem_out, 
	                             alu_res_out;
	output [`REG_ADDRESS_LEN - 1:0] dest_out;
	
	assign wb_en_out = wb_en_in;
	assign mem_r_en_out = mem_r_en_in;
	assign alu_res_out = alu_res_in;
	assign dest_out = dest_in;
	 
  Memory memory(.clk(clk), 
                .rst(rst), 
                .address(alu_res_in),
	 		          .WriteData(val_Rm), 
	 		          .MemRead(mem_r_en_in), 
	 		          .MemWrite(mem_w_en_in),
	 		          .ReadData(mem_out),
	 		          .ready(ready));
	 		          
endmodule