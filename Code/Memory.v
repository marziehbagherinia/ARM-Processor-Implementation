`include "Defines.v"

module Memory(clk, 
              rst, 
              address, 
              WriteData, 
              MemRead, 
              MemWrite, 
              ReadData, 
              ready);

	input clk, 
	      rst, 
	      MemRead, 
	      MemWrite;              
	input[`ADDRESS_LEN - 1:0] address;      
	input[`INSTRUCTION_LEN - 1:0] WriteData;
	output ready;
	output wire[`INSTRUCTION_LEN - 1:0] ReadData;
	
	reg[`DATA_MEMORY_LEN - 1:0] data[0:`DATA_MEMORY_SIZE - 1];

	wire [`ADDRESS_LEN - 1:0] address4k    = {address[`ADDRESS_LEN - 1:2], 2'b0} - `ADDRESS_LEN'd1024;
	wire [`ADDRESS_LEN - 1:0] address4k_p1 = {address4k[`ADDRESS_LEN - 1:2], 2'b01}; // address4k + 1
	wire [`ADDRESS_LEN - 1:0] address4k_p2 = {address4k[`ADDRESS_LEN - 1:2], 2'b10}; // address4k + 2
	wire [`ADDRESS_LEN - 1:0] address4k_p3 = {address4k[`ADDRESS_LEN - 1:2], 2'b11}; // address4k + 3

	assign ready = 1'b1;
	assign ReadData = (MemRead == `ENABLE) 
	                ? {data[address4k], data[address4k_p1], data[address4k_p2], data[address4k_p3]}
			            : `INSTRUCTION_LEN'b0;

	always @(posedge clk, posedge rst) begin
      if (rst) begin
        /*
          data[0] <= 8'b00010000;
          data[1] <= 8'b00000000;
          data[2] <= 8'b00000000;
          data[3] <= 8'b00000000;
			
          data[4] <= 8'b11000000;
          data[5] <= 8'b00100010;
          data[6] <= 8'b00000000;
          data[7] <= 8'b00000000;
			
          data[8] <= 8'b00000000;
          data[9] <= 8'b01100100;
          data[10] <= 8'b00000000;
          data[11] <= 8'b00000000;
			
          data[12] <= 8'b00000000;
          data[13] <= 8'b10100110;
          data[14] <= 8'b00000000;
          data[15] <= 8'b00000000;
          */
      end
      else if (MemWrite) begin
          data[address4k_p3] = WriteData[`INSTRUCTION_MEM_LEN - 1:0];
          // write to data[address + 1]
          data[address4k_p2] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN];
			
          // write to data[address + 2]
          data[address4k_p1] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN];

          // write to data[address + 3]
          data[address4k] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN];
      end
	end

endmodule