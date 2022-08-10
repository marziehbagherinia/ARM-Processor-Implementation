library verilog;
use verilog.vl_types.all;
entity MUX_3_to_1 is
    generic(
        WORD_LENGTH     : integer := 32
    );
    port(
        first           : in     vl_logic_vector;
        second          : in     vl_logic_vector;
        third           : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 1;
end MUX_3_to_1;
