`include "Defines.v"

module Status_Register (clk, 
                        rst,
                        ld,
                        data_in,
                        data_out);

  input clk, 
        rst, 
        ld;
  input [3:0] data_in;

  output reg [3:0] data_out;
	
	always@(negedge clk, posedge rst) begin
		if (rst) data_out <= 0;
		else if (ld) data_out <= data_in;
	end
	
endmodule