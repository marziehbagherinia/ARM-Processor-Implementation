library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        alu_in1         : in     vl_logic_vector(31 downto 0);
        alu_in2         : in     vl_logic_vector(31 downto 0);
        alu_command     : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        alu_out         : out    vl_logic_vector(31 downto 0);
        statusRegister  : out    vl_logic_vector(3 downto 0)
    );
end ALU;
