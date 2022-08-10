module TB();

/////////////////////// Clock reg //////////////////////////////
reg         CLOCK_50 = 1'b0;        //  50 MHz
/////////////////////// DPDT Switch ////////////////////////////
reg  [17:0] SW;                     //  Toggle Switch[17:0]

ARM_Module ARM(
              .CLOCK_50(CLOCK_50),                    //  50 MHz
              .SW(SW)                                 //  Toggle Switch[17:0]
              );

initial repeat
        (1500) 
        #100 CLOCK_50 = ~CLOCK_50;
    
initial begin
        #250
        SW[13] = 1'b1;
        SW[10] = 1'b1;
        #100
        SW[13] = 1'b0;
end
    
endmodule