library verilog;
use verilog.vl_types.all;
entity Val2Generator is
    port(
        Rm              : in     vl_logic_vector(31 downto 0);
        shift_operand   : in     vl_logic_vector(11 downto 0);
        immd            : in     vl_logic;
        is_mem_command  : in     vl_logic;
        val2_out        : out    vl_logic_vector(31 downto 0)
    );
end Val2Generator;
