`include "Defines.v"

module ID_Stage_Reg(clk,
                    rst,
                    freeze,
                    mem_read_en_in,
                    mem_write_en_in,
                    wb_enable_in,
                    immediate_in,
                    branch_taken_in,
                    status_write_enable_in,
                    flush,
                    PC_in,			
                    execute_command_in,
                    reg_file_in1,
                    reg_file_in2,
                    dest_reg_in,
                    signed_immediate_in,
                    shift_operand_in,
                    status_reg_in,
                    src1_addr_in, src2_addr_in,
                    mem_read_en_out,
                    mem_write_en_out,
                    wb_enable_out,
                    immediate_out,
                    branch_taken_out,
                    status_write_enable_out,
                    PC_out,
                    execute_command_out,
                    reg_file_out1,
                    reg_file_out2,
                    dest_reg_out,
                    signed_immediate_out,
                    shift_operand_out,
                    status_reg_out,
                    src1_addr_out, src2_addr_out);

	input clk,
	      rst,
	      freeze,
	      mem_read_en_in,
	      mem_write_en_in,
	      wb_enable_in,
        immediate_in,
        branch_taken_in,
        status_write_enable_in,
        flush;

	input [3:0] status_reg_in;        
	input [`ADDRESS_LEN - 1:0] PC_in;		
	input [`REGISTER_LEN - 1:0] reg_file_in1,
                              reg_file_in2;
                              
	input [`REG_ADDRESS_LEN - 1:0] dest_reg_in;
	input [`SHIFT_OPERAND_LEN - 1:0] shift_operand_in;
	input [`EXECUTE_COMMAND_LEN - 1:0] execute_command_in;
	input [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_in;
	input [`REG_ADDRESS_LEN - 1:0] src1_addr_in, src2_addr_in;

	output wire mem_read_en_out,
              mem_write_en_out,
              wb_enable_out,
              immediate_out,
              branch_taken_out,
              status_write_enable_out;
              
 	output wire [3:0] status_reg_out;            
	output wire [`ADDRESS_LEN - 1:0] PC_out;
	output wire [`REGISTER_LEN - 1:0] reg_file_out1,
                                    reg_file_out2;
 	output wire [`REG_ADDRESS_LEN - 1:0] dest_reg_out;                                   
	output wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_out;	
	output wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_out;
	output wire [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_out;
	output wire [`REG_ADDRESS_LEN - 1:0] src1_addr_out, src2_addr_out;
	
  Register_Flush #(.WORD_LENGTH(`ADDRESS_LEN)) reg_PC_in(.clk(clk), 
                                                         .rst(rst), 
                                                         .flush(flush), 
		                                                     .ld(~freeze), 
		                                                     .in(PC_in), 
		                                                     .out(PC_out));

  Register_Flush #(.WORD_LENGTH(1)) reg_mem_read_en_in(.clk(clk), 
                                                       .rst(rst), 
                                                       .flush(flush), 
		                                                   .ld(~freeze), 
		                                                   .in(mem_read_en_in), 
		                                                   .out(mem_read_en_out));

  Register_Flush #(.WORD_LENGTH(1)) reg_mem_write_en_in(.clk(clk), 
                                                        .rst(rst), 
                                                        .flush(flush), 
		                                                    .ld(~freeze), 
		                                                    .in(mem_write_en_in), 
		                                                    .out(mem_write_en_out));
  
  Register_Flush #(.WORD_LENGTH(1)) reg_wb_enable_in(.clk(clk), 
                                                     .rst(rst), 
                                                     .flush(flush), 
		                                                 .ld(~freeze), 
		                                                 .in(wb_enable_in), 
		                                                 .out(wb_enable_out));

  Register_Flush #(.WORD_LENGTH(1)) reg_immediate_in(.clk(clk), 
                                                     .rst(rst), 
                                                     .flush(flush), 
	                                                  	.ld(~freeze), 
	                                                  	.in(immediate_in), 
	                                                  	.out(immediate_out));

  Register_Flush #(.WORD_LENGTH(1)) reg_branch_taken_in(.clk(clk), 
                                                        .rst(rst), 
                                                        .flush(flush), 
		                                                    .ld(~freeze), 
		                                                    .in(branch_taken_in), 
		                                                    .out(branch_taken_out));

  Register_Flush #(.WORD_LENGTH(1)) reg_status_write_enable_in(.clk(clk), 
                                                               .rst(rst), 
                                                               .flush(flush), 
		                                                           .ld(~freeze), 
		                                                           .in(status_write_enable_in), 
		                                                           .out(status_write_enable_out));

  Register_Flush #(.WORD_LENGTH(`EXECUTE_COMMAND_LEN)) reg_execute_command_in(.clk(clk), 
                                                                              .rst(rst), 
                                                                              .flush(flush), 
		                                                                          .ld(~freeze), 
		                                                                          .in(execute_command_in), 
		                                                                          .out(execute_command_out));

  Register_Flush #(.WORD_LENGTH(`REGISTER_LEN)) reg_reg_file_in1(.clk(clk), 
                                                                 .rst(rst), 
                                                                 .flush(flush), 
		                                                             .ld(~freeze), 
		                                                             .in(reg_file_in1), 
		                                                             .out(reg_file_out1));

  Register_Flush #(.WORD_LENGTH(`REGISTER_LEN)) reg_reg_file_in2(.clk(clk), 
                                                                 .rst(rst), 
                                                                 .flush(flush), 
		                                                             .ld(~freeze), 
		                                                             .in(reg_file_in2), 
		                                                             .out(reg_file_out2));

  Register_Flush #(.WORD_LENGTH(`REG_ADDRESS_LEN)) reg_dest_reg_in(.clk(clk), 
                                                                   .rst(rst), 
                                                                   .flush(flush), 
		                                                               .ld(~freeze), 
		                                                               .in(dest_reg_in), 
		                                                               .out(dest_reg_out));

  Register_Flush #(.WORD_LENGTH(`SIGNED_IMMEDIATE_LEN)) reg_signed_immediate_in(.clk(clk), 
                                                                                .rst(rst), 
                                                                                .flush(flush), 
		                                                                            .ld(~freeze), 
		                                                                            .in(signed_immediate_in), 
		                                                                            .out(signed_immediate_out));

  Register_Flush #(.WORD_LENGTH(`SHIFT_OPERAND_LEN)) reg_shift_operand_in(.clk(clk), 
                                                                          .rst(rst), 
                                                                          .flush(flush), 
		                                                                      .ld(~freeze), 
		                                                                      .in(shift_operand_in), 
		                                                                      .out(shift_operand_out));

  Register_Flush #(.WORD_LENGTH(4)) reg_status_reg_in(.clk(clk), 
                                                      .rst(rst), 
                                                      .flush(flush), 
		                                                  .ld(~freeze), 
		                                                  .in(status_reg_in), 
		                                                  .out(status_reg_out));

  Register_Flush #(.WORD_LENGTH(`REG_ADDRESS_LEN)) forwarding_reg_in1(.clk(clk), 
                                                                      .rst(rst), 
                                                                      .flush(flush), 
		                                                                  .ld(~freeze), 
		                                                                  .in(src1_addr_in), 
		                                                                  .out(src1_addr_out));

  Register_Flush #(.WORD_LENGTH(`REG_ADDRESS_LEN)) forwarding_reg_in2(.clk(clk), 
                                                                      .rst(rst), 
                                                                      .flush(flush), 
		                                                                  .ld(~freeze), 
		                                                                  .in(src2_addr_in), 
		                                                                  .out(src2_addr_out));
		
endmodule