library verilog;
use verilog.vl_types.all;
entity IF_Stage_Module is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        freeze_in       : in     vl_logic;
        Branch_taken_in : in     vl_logic;
        flush_in        : in     vl_logic;
        BranchAddr_in   : in     vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        Instruction_out : out    vl_logic_vector(31 downto 0)
    );
end IF_Stage_Module;
