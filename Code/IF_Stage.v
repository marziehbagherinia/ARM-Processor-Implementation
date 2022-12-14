`include "Defines.v"

module IF_Stage (clk, 
                 rst, 
                 freeze, 
                 Branch_taken,
                 BranchAddr,
                 PC,
                 Instruction);

  input clk, 
        rst, 
        freeze, 
        Branch_taken;
        
	input [`ADDRESS_LEN - 1:0] BranchAddr;
	
	output[`ADDRESS_LEN - 1:0] PC;
	output[`INSTRUCTION_LEN - 1:0] Instruction;
	
	////////// PC block ///////////

	reg pc_write_en;
	
	wire[`ADDRESS_LEN - 1 : 0] pc_in, 
	                           pc_out;
	
	Register #(.WORD_LENGTH(`ADDRESS_LEN)) PC_Module(.clk(clk), 
	                                                 .rst(rst), 
	                                                 .ld(~freeze),
			                                             .in(pc_in), 
			                                             .out(pc_out));
	
	Incrementer #(.WORD_LENGTH(`ADDRESS_LEN)) PC_Incrementer(.in(pc_out), 
	                                                         .out(PC));
	
  MUX_2_to_1 #(.WORD_LENGTH(`ADDRESS_LEN)) PC_Mux(.first(PC), 
                                                  .second(BranchAddr),
                                                  .sel_first(~Branch_taken), 
                                                  .sel_second(Branch_taken),
                                                  .out(pc_in));
	
	/////////// Instruction Memory //////////

	reg[`INSTRUCTION_LEN - 1:0] instruction_write_data;
	
	wire[`INSTRUCTION_LEN - 1:0] ReadData;
	
	assign Instruction = ReadData;

	InstructionMemory Instruction_Mem(.clk(clk), 
	                                  .rst(rst), 
	                                  .address(pc_out),
	                                  .WriteData(instruction_write_data), 
	                                  .MemRead(1'b1),
			                              .MemWrite(1'b0), 
			                              .ReadData(ReadData));
	
endmodule