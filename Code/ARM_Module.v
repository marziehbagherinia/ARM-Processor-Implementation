`include "Defines.v"

module ARM_Module(CLOCK_50,                       //  50 MH
                  SW                              //  Toggle Switch[17:0]
                  );

  //////////////////////// Clock Input ////////////////////////
  input         CLOCK_50;               //  50 MHz
  //////////////////////// DPDT Switch ////////////////////////
  input  [17:0] SW;                     //  Toggle Switch[17:0]
  
  wire en_forwarding, rst;
  wire MEM_ready;
  
  assign en_forwarding = SW[10];
  assign rst = SW[13];
    

  // ##############################               
  // ########## IF Stage ##########
  // ##############################               

  wire branch_taken_EXE_out, 
       branch_taken_ID_out,
       hazard_detected, 
       flush;
       
  wire[`ADDRESS_LEN - 1:0] PC_IF, 
                           PC_ID,
                           branch_address;
                                
  wire[`INSTRUCTION_LEN - 1:0] Instruction_IF;
    
  assign flush = branch_taken_ID_out;
    
  IF_Stage_Module IF_Stage_Module(// inputs:
                                  .clk(CLOCK_50), .rst(rst),
                                  .freeze_in(hazard_detected | ~MEM_ready),
                                  .Branch_taken_in(branch_taken_ID_out),
                                  .flush_in(flush),
                                  .BranchAddr_in(branch_address),
                                  //outputs from reg:
                                  .PC_out(PC_IF),
                                  .Instruction_out(Instruction_IF));  
            
  // ##############################               
  // ########## ID Stage ##########
  // ##############################
  
  wire ID_two_src, 
       ignore_hazard_ID_out,
       mem_read_ID_out, 
       mem_write_ID_out,
       wb_enable_ID_out, 
       immediate_ID_out,
       status_write_enable_ID_out,
       wb_enable_WB_out;

  wire [3:0] status_reg_ID_out,
             status_reg_ID_in;
               
  wire [`REGISTER_LEN - 1:0] wb_value_WB; 
  wire [`REG_ADDRESS_LEN - 1:0] wb_dest_WB_out; 
  wire [`REG_ADDRESS_LEN - 1:0] dest_reg_ID_out;
  wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_ID_out; 
  wire [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_ID_out;
   wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_ID_out;
    
  wire [`REGISTER_LEN - 1:0] reg_file_ID_out1, 
                             reg_file_ID_out2;
                             
  wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out, 
                                reg_file_first_src_out;
                                
  wire [`REG_ADDRESS_LEN - 1:0] staged_reg_file_ID_out1, 
                                staged_reg_file_ID_out2;        
               
  ID_Stage_Module ID_Stage_Module(// Inputs:
                                  .clk(CLOCK_50), .rst(rst), .PC_in(PC_IF),
                                  .Instruction_in(Instruction_IF),
                                  .status_reg_in(status_reg_ID_in),
                                  .hazard(hazard_detected),
                                  .flush(flush),
                                  .freeze(~MEM_ready),
                                  // Register file inputs:
                                  .reg_file_wb_data(wb_value_WB),
                                  .reg_file_wb_address(wb_dest_WB_out),
                                  .reg_file_wb_en(wb_enable_WB_out),
                                  // Wired Outputs:
                                  .two_src_out(ID_two_src),
                                  .reg_file_second_src_out(reg_file_second_src_out),
                                  .reg_file_first_src_out(reg_file_first_src_out),
                                  .ignore_hazard_out(ignore_hazard_ID_out),
                                  // Registered Outputs:
                                  .PC_out(PC_ID),
                                  .mem_read_en_out(mem_read_ID_out),
                                  .mem_write_en_out(mem_write_ID_out),
                                  .wb_enable_out(wb_enable_ID_out),
                                  .immediate_out(immediate_ID_out),
                                  .branch_taken_out(branch_taken_ID_out),
                                  .status_write_enable_out(status_write_enable_ID_out),       
                                  .execute_command_out(execute_command_ID_out),
                                  .reg_file_out1(reg_file_ID_out1),
                                  .reg_file_out2(reg_file_ID_out2),
                                  .dest_reg_out(dest_reg_ID_out),
                                  .sign_immediate_out(signed_immediate_ID_out),
                                  .shift_operand_out(shift_operand_ID_out),
                                  .status_reg_out(status_reg_ID_out),
                                  .staged_reg_file_first_src_out(staged_reg_file_ID_out1),
                                  .staged_reg_file_second_src_out(staged_reg_file_ID_out2));

  // ###############################              
  // ########## EXE Stage ##########
  // ###############################  

  wire wb_en_hazard_EXE_out,
       status_w_en_EXE_out,
       wb_enable_EXE_out,
       mem_read_EXE_out,
       mem_write_EXE_out;
       
  wire [1:0] EXE_alu_mux_sel_src1, 
             EXE_alu_mux_sel_src2;

  wire [3:0] status_reg_EXE_out;
  
  wire [`REGISTER_LEN - 1:0] alu_res_EXE_out, 
                             val_Rm_EXE_out;
                             
  wire [`REG_ADDRESS_LEN - 1:0] dest_EXE_out;
  wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_EXE_out;
            
  EX_Stage_Module EX_Stage_Module(//inputs to main moduel:
                                  .clk(CLOCK_50), .rst(rst),
                                  .freeze(~MEM_ready),
                                  .PC_in(PC_ID),
                                  .wb_en_in(wb_enable_ID_out), 
                                  .mem_r_en_in(mem_read_ID_out),
                                  .mem_w_en_in(mem_write_ID_out),
                                  .status_w_en_in(status_write_enable_ID_out),
                                  .branch_taken_in(branch_taken_ID_out),
                                  .immd(immediate_ID_out),
                                  .exe_cmd(execute_command_ID_out),
                                  .val_Rn(reg_file_ID_out1),
                                  .val_Rm_in(reg_file_ID_out2),
                                  .dest_in(dest_reg_ID_out),
                                  .signed_immd_24(signed_immediate_ID_out),
                                  .shift_operand(shift_operand_ID_out),
                                  .status_reg_in(status_reg_ID_out),
                                  //forwarding inputs:
                                  .alu_mux_sel_src1(EXE_alu_mux_sel_src1),
                                  .alu_mux_sel_src2(EXE_alu_mux_sel_src2),
                                  .MEM_wb_value(alu_res_EXE_out),
                                  .WB_wb_value(wb_value_WB),
                                  // outputs from Reg:
                                  .wb_en_out(wb_enable_EXE_out),
                                  .mem_r_en_out(mem_read_EXE_out),
                                  .mem_w_en_out(mem_write_EXE_out),
                                  .alu_res_out(alu_res_EXE_out),
                                  .val_Rm_out(val_Rm_EXE_out),
                                  .dest_out(dest_EXE_out),
                                  //outputs from main module:
                                  .wb_en_hazard_in(wb_en_hazard_EXE_out),
                                  .dest_hazard_in(dest_hazard_EXE_out),
                                  .status_w_en_out(status_w_en_EXE_out),
                                  .branch_taken_out(branch_taken_EXE_out),
                                  .statusRegister_out(status_reg_EXE_out),
                                  .branch_address_out(branch_address));
    

  // ##############################               
  // ########## MEM Stage ##########
  // ##############################               

  wire wb_en_MEM_out, mem_r_en_MEM_out;
  wire [`REGISTER_LEN - 1:0] alu_res_MEM_out, 
                             mem_res_MEM_out;
  wire [`REG_ADDRESS_LEN - 1:0] dest_MEM_out;

  wire wb_en_hazard_MEM_out;
  wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_MEM_out;
    
  MEM_Stage_Module MEM_Stage_Module(//inputs to main moduel:
                                    .clk(CLOCK_50), .rst(rst),
                                    .freeze(~MEM_ready),
                                    .wb_en_in(wb_enable_EXE_out),
                                    .mem_r_en_in(mem_read_EXE_out),
                                    .mem_w_en_in(mem_write_EXE_out),
                                    .alu_res_in(alu_res_EXE_out), .val_Rm(val_Rm_EXE_out),
                                    .dest_in(dest_EXE_out),

                                    // outputs from Reg:
                                    .wb_en_out(wb_en_MEM_out), .mem_r_en_out(mem_r_en_MEM_out),
                                    .alu_res_out(alu_res_MEM_out), .mem_res_out(mem_res_MEM_out),
                                    .dest_out(dest_MEM_out),

                                    //outputs from stage:
                                    .wb_en_hazard_in(wb_en_hazard_MEM_out),
                                    .dest_hazard_in(dest_hazard_MEM_out),
                                    .ready(MEM_ready));

  // ##############################       
  // ########## WB Stage ##########       
  // ##############################

  WB_Stage WB_Stage(// inputs:
                    .clk(CLOCK_50),
                    .rst(rst),
                    .mem_read_enable(mem_r_en_MEM_out),
                    .wb_enable_in(wb_en_MEM_out),
                    .alu_result(alu_res_MEM_out),
                    .data_memory(mem_res_MEM_out),
                    .wb_dest_in(dest_MEM_out),
                    // outputs:
                    .wb_enable_out(wb_enable_WB_out),     
                    .wb_dest_out(wb_dest_WB_out),
                    .wb_value(wb_value_WB));

  // ##############################
  // #### top module elements #####
  // ##############################
  
  wire ignore_hazard_forwarding_out;

  Status_Register Status_Register(.clk(CLOCK_50), .rst(rst),
                                  .ld(status_w_en_EXE_out),
                                  .data_out(status_reg_ID_in),
                                  .data_in(status_reg_EXE_out));
    
  Hazard_Detection_Unit hazard_detection_unit(//inputs:
                                              .with_forwarding(en_forwarding),
                                              .have_two_src(ID_two_src),
                                              .src1_address(reg_file_first_src_out),
                                              .src2_address(reg_file_second_src_out),
                                              .ignore_hazard(ignore_hazard_ID_out),
                                              .ignore_from_forwarding(ignore_hazard_forwarding_out),
                                              // TODO : get it from EXE
                                              .EXE_mem_read_en(mem_read_ID_out),
                                              .exe_wb_dest(dest_hazard_EXE_out),
                                              .exe_wb_en(wb_en_hazard_EXE_out), 
                                              .mem_wb_dest(dest_hazard_MEM_out),
                                              .mem_wb_en(wb_en_hazard_MEM_out),
                                              // outputs:
                                              .hazard_detected(hazard_detected));

  Forwarding forwarding(.en_forwarding(en_forwarding),
                        .ID_src1(staged_reg_file_ID_out1),
                        .ID_src2(staged_reg_file_ID_out2),
                        .MEM_wb_en(wb_en_hazard_MEM_out),
                        .MEM_dst(dest_hazard_MEM_out),
                        .WB_wb_en(wb_enable_WB_out),
                        .WB_dst(wb_dest_WB_out),
                        .sel_src1(EXE_alu_mux_sel_src1),
                        .sel_src2(EXE_alu_mux_sel_src2),
                        .ignore_hazard(ignore_hazard_forwarding_out));

endmodule