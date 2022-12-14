`include "Defines.v"

module ID_Stage_Module(// inputs to main module:
                       clk,
                       rst,
                       flush,
                       freeze, 
                       PC_in,
                       Instruction_in,
                       status_reg_in,
                       // Register file inputs:
                       reg_file_wb_data,
                       reg_file_wb_address,
                       reg_file_wb_en, hazard,			
                       // outputs from Stage:
                       two_src_out, ignore_hazard_out,
                       reg_file_second_src_out, reg_file_first_src_out,
                       PC_out,
                       mem_read_en_out, mem_write_en_out,
                       wb_enable_out, immediate_out,
                       branch_taken_out, status_write_enable_out,			
                       execute_command_out,
                       reg_file_out1, reg_file_out2,
                       dest_reg_out,
                       sign_immediate_out,
                       shift_operand_out,
                       status_reg_out,
                       staged_reg_file_second_src_out,
                       staged_reg_file_first_src_out);
	
  input clk,
        rst,
	      flush,
	      freeze;
	       
	input[`ADDRESS_LEN - 1:0] PC_in;
	input [`INSTRUCTION_LEN - 1 : 0] Instruction_in;
	input [3:0] status_reg_in;
		
	// Register file inputs:
	input [`REGISTER_LEN - 1:0] reg_file_wb_data;
	input [`REG_ADDRESS_LEN - 1:0] reg_file_wb_address;
	input reg_file_wb_en, 
	      hazard;
			
	// outputs from Stage:
	output wire two_src_out, ignore_hazard_out;
	output wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out, reg_file_first_src_out;
	
	// outputs from Reg:
	output wire [`ADDRESS_LEN - 1:0] PC_out;
	output wire mem_read_en_out, mem_write_en_out,
	            wb_enable_out, immediate_out,
			        branch_taken_out, status_write_enable_out;
			
	output wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_out;
	output wire [`REGISTER_LEN - 1:0] reg_file_out1, reg_file_out2;
	output wire [`REG_ADDRESS_LEN - 1:0] dest_reg_out;
	output wire [`SIGNED_IMMEDIATE_LEN - 1:0] sign_immediate_out;
	output wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_out;
	output wire [3:0] status_reg_out;

	output wire [`REG_ADDRESS_LEN - 1:0] staged_reg_file_second_src_out,
			                                 staged_reg_file_first_src_out;
			
	wire[`ADDRESS_LEN - 1:0] PC_middle;

	wire mem_read_en_middle, mem_write_en_middle,
		   wb_enable_middle, immediate_middle,
		   branch_taken_middle, status_write_enable_middle;
		
	wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_middle;
	wire [`REGISTER_LEN - 1:0] reg_file_middle1, reg_file_middle2;
	wire [`REG_ADDRESS_LEN - 1:0] dest_reg_middle;
	wire [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_middle;
	wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_middle;
	wire [`REG_ADDRESS_LEN - 1:0] src1_addr_middle, src2_addr_middle;

	ID_Stage ID_Stage(// inputs:
			              .clk(clk), .rst(rst), .PC_in(PC_in),
			              .Instruction_in(Instruction_in),
			              .status_register(status_reg_in),
                 			.reg_file_wb_data(reg_file_wb_data),
                 			.reg_file_wb_address(reg_file_wb_address),
                 			.reg_file_wb_en(reg_file_wb_en),
                 			.hazard(hazard),
                 			// outputs to Reg:
                 			.PC(PC_middle),			
                 			.mem_read_en_out(mem_read_en_middle),
                 			.mem_write_en_out(mem_write_en_middle),
                 			.wb_enable_out(wb_enable_middle),
                 			.immediate_out(immediate_middle),
                 			.branch_taken_out(branch_taken_middle),
                 			.status_write_enable_out(status_write_enable_middle),
                 			.execute_command_out(execute_command_middle),
                 			.reg_file_out1(reg_file_middle1),
                 			.reg_file_out2(reg_file_middle2),
                 			.dest_reg_out(dest_reg_middle),
                 			.signed_immediate(signed_immediate_middle),
                 			.shift_operand(shift_operand_middle),
                 			// outputs to top-module:
                 			.two_src(two_src_out),
                 			.reg_file_second_src_out(reg_file_second_src_out),
                 			.reg_file_first_src_out(reg_file_first_src_out),
                 			.ignore_hazard_out(ignore_hazard_out));

	assign src1_addr_middle = reg_file_first_src_out;
	assign src2_addr_middle = reg_file_second_src_out;
		
	ID_Stage_Reg ID_Stage_Reg(.clk(clk),
                 			        .rst(rst),
                 			        .flush(flush),
                 			        .freeze(freeze),
                 			        .PC_in(PC_middle),			
                 			        .mem_read_en_in(mem_read_en_middle),
                 			        .mem_write_en_in(mem_write_en_middle),
                 			        .wb_enable_in(wb_enable_middle),
                 			        .immediate_in(immediate_middle),
                 			        .branch_taken_in(branch_taken_middle),
                 			        .status_write_enable_in(status_write_enable_middle),
                 			        .execute_command_in(execute_command_middle),
                 			        .reg_file_in1(reg_file_middle1),
                 			        .reg_file_in2(reg_file_middle2),
                 			        .dest_reg_in(dest_reg_middle),
                 			        .signed_immediate_in(signed_immediate_middle),
                 			        .shift_operand_in(shift_operand_middle),
                 			        .status_reg_in(status_reg_in),
                 			        .src1_addr_in(src1_addr_middle),
                 			        .src2_addr_in(src2_addr_middle),
                 			        .PC_out(PC_out),			
                 			        .mem_read_en_out(mem_read_en_out),
                 			        .mem_write_en_out(mem_write_en_out),
                 			        .wb_enable_out(wb_enable_out),
                 			        .immediate_out(immediate_out),
                 			        .branch_taken_out(branch_taken_out),
                 			        .status_write_enable_out(status_write_enable_out),
                 			        .execute_command_out(execute_command_out),
                 			        .reg_file_out1(reg_file_out1),
                 			        .reg_file_out2(reg_file_out2),
                 			        .dest_reg_out(dest_reg_out),
                 			        .signed_immediate_out(sign_immediate_out),
                 			        .shift_operand_out(shift_operand_out),
                 			        .status_reg_out(status_reg_out),
                 			        .src1_addr_out(staged_reg_file_first_src_out),
                 			        .src2_addr_out(staged_reg_file_second_src_out));
		
endmodule