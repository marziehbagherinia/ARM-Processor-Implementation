library verilog;
use verilog.vl_types.all;
entity Register_Flush is
    generic(
        WORD_LENGTH     : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        ld              : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 1;
end Register_Flush;
