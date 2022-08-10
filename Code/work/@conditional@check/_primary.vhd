library verilog;
use verilog.vl_types.all;
entity ConditionalCheck is
    port(
        cond            : in     vl_logic_vector(3 downto 0);
        statusRegister  : in     vl_logic_vector(3 downto 0);
        condState       : out    vl_logic
    );
end ConditionalCheck;
