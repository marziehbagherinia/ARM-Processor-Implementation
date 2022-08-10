`include "Defines.v"

module MUX_2_to_1(first, 
                  second, 
                  sel_first, 
                  sel_second, 
                  out);
  
	parameter WORD_LENGTH = 32;

	input sel_first, 
	      sel_second;	
	input[WORD_LENGTH - 1:0] first, second;
	output[WORD_LENGTH - 1:0] out;
	
	assign out = sel_first ? first : (sel_second ? second : out); 
	
endmodule

module MUX_3_to_1(first, 
                  second, 
                  third, 
                  sel, 
                  out);
                  
	parameter WORD_LENGTH = 32;
	input [1:0] sel;	
	input [WORD_LENGTH - 1:0] first, 
	                          second,
	                          third;
	output [WORD_LENGTH - 1:0] out;
	
	assign out = (sel == `FORW_SEL_FROM_ID) ? first 
	           : ((sel == `FORW_SEL_FROM_WB) ? second 
	           : ((sel == `FORW_SEL_FROM_MEM) ? third : out)); 
	
endmodule