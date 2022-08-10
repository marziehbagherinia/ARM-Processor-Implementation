library verilog;
use verilog.vl_types.all;
entity MUX_2_to_1 is
    generic(
        WORD_LENGTH     : integer := 32
    );
    port(
        first           : in     vl_logic_vector;
        second          : in     vl_logic_vector;
        sel_first       : in     vl_logic;
        sel_second      : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 1;
end MUX_2_to_1;
