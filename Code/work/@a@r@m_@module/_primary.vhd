library verilog;
use verilog.vl_types.all;
entity ARM_Module is
    port(
        CLOCK_50        : in     vl_logic;
        SW              : in     vl_logic_vector(17 downto 0)
    );
end ARM_Module;
