`include "Defines.v"

module ID_Stage(clk,
                rst,
                PC_in,
                Instruction_in,
                status_register,
                reg_file_wb_data,
                reg_file_wb_address,
                reg_file_wb_en, hazard,
                PC,
                mem_read_en_out, mem_write_en_out,
                wb_enable_out, immediate_out,
                branch_taken_out, 
                status_write_enable_out, 
                ignore_hazard_out,
                execute_command_out,
                reg_file_out1, reg_file_out2,
                two_src,
                dest_reg_out,
                signed_immediate,
                shift_operand,
                reg_file_second_src_out, 
                reg_file_first_src_out);

	input clk,
	      rst,
	      reg_file_wb_en, 
	      hazard;
	      
	input [3:0] status_register;
	input [`ADDRESS_LEN - 1:0] PC_in;
	input [`REGISTER_LEN - 1:0] reg_file_wb_data;	
	input [`INSTRUCTION_LEN - 1 : 0] Instruction_in;	
	input [`REG_ADDRESS_LEN - 1:0] reg_file_wb_address;
		
	output two_src,
	       mem_read_en_out, 
	       mem_write_en_out,
       		wb_enable_out, 
       		immediate_out,
		     branch_taken_out, 
		     status_write_enable_out, 
		     ignore_hazard_out;

	output [`ADDRESS_LEN - 1:0] PC;		
	output [`REG_ADDRESS_LEN - 1:0] dest_reg_out;
	output [`SHIFT_OPERAND_LEN - 1:0] shift_operand;
	output [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate;	
	output [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_out;
	output [`REGISTER_LEN - 1:0] reg_file_out1, reg_file_out2;
	output wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out, 
	                                     reg_file_first_src_out;
	
	wire mem_read, mem_write,
     		wb_enable, immediate,
		   branch_taken, status_write_enable,
		   cond_state, control_unit_mux_enable;
		   
	wire [`REG_ADDRESS_LEN - 1:0] reg_file_src1, 
	                              reg_file_src2;
	wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command;

	// Number of control signals = 6
	wire [`EXECUTE_COMMAND_LEN + 6 - 1 : 0] control_unit_mux_in, 
	                                        control_unit_mux_out;
		
	// Control Unit
	ControlUnit control_unit(.mode(Instruction_in[27 : 26]), 
	                         .opcode(Instruction_in[24 : 21]),
	                         .s(Instruction_in[20]), 
	                         .immediate_in(Instruction_in[25]),
	                         .execute_command(execute_command),
	                         .mem_read(mem_read), 
	                         .mem_write(mem_write),
	                         .wb_enable(wb_enable), 
	                         .immediate(immediate),
	                         .branch_taken(branch_taken),
	                         .status_write_enable(status_write_enable),
	                         .ignore_hazard(ignore_hazard_out));

		
	// Register File
	MUX_2_to_1 #(.WORD_LENGTH(4)) reg_file_src2_mux(.first(Instruction_in[15:12]), 
	                                                .second(Instruction_in[3:0]),
                                                  .sel_first(mem_write), 
                                                  .sel_second(~mem_write),
		  	                                           .out(reg_file_src2));
	
	assign reg_file_second_src_out = reg_file_src2;
	assign reg_file_first_src_out = reg_file_src1;
	assign reg_file_src1 = Instruction_in[19:16];
	
	// Register File
	RegisterFile register_file(.clk(clk), .rst(rst), 
		                         .src1(reg_file_src1), .src2(reg_file_src2),
		                         .dest_wb(reg_file_wb_address),
		                         .result_wb(reg_file_wb_data),
		                         .writeBackEn(reg_file_wb_en),
		                         .reg1(reg_file_out1), .reg2(reg_file_out2));
	
	// Conditional Check
	ConditionalCheck conditional_check(.cond(Instruction_in[31:28]),
		                                 .statusRegister(status_register),
		                                 .condState(cond_state));
	
	// Other Components
	assign control_unit_mux_in = {execute_command, mem_read, mem_write,
			                          immediate, wb_enable, branch_taken,
			                          status_write_enable};
	
	assign control_unit_mux_enable = hazard | (~cond_state);
	
	// Number of control signals = 6
	// @TODO: Check the control_unit_mux_enable
	 MUX_2_to_1 #(.WORD_LENGTH(`EXECUTE_COMMAND_LEN + 6)) control_unit_mux(
	              .first(control_unit_mux_in), .second(10'b0),
			          .sel_first(~control_unit_mux_enable),
			          .sel_second(control_unit_mux_enable),
			          .out(control_unit_mux_out));
	
	assign {execute_command_out, mem_read_en_out, mem_write_en_out, immediate_out, 
	        wb_enable_out, branch_taken_out, status_write_enable_out} = control_unit_mux_out;
	
	assign PC = PC_in;
	
	// @TODO: Change this name
	// @TODO: Check the operands: mem_write_en_out or mem_write
	assign two_src = (~Instruction_in[25]) | mem_write_en_out;
	assign shift_operand = Instruction_in[`SHIFT_OPERAND_INDEX - 1:0];
	assign dest_reg_out = Instruction_in[15:12];
	assign signed_immediate = Instruction_in[23:0];
	
endmodule