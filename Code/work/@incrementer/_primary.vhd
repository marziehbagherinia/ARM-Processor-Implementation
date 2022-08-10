library verilog;
use verilog.vl_types.all;
entity Incrementer is
    generic(
        WORD_LENGTH     : integer := 32
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_LENGTH : constant is 1;
end Incrementer;
