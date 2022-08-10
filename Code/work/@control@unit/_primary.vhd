library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    port(
        mode            : in     vl_logic_vector(1 downto 0);
        opcode          : in     vl_logic_vector(3 downto 0);
        s               : in     vl_logic;
        immediate_in    : in     vl_logic;
        execute_command : out    vl_logic_vector(3 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        wb_enable       : out    vl_logic;
        immediate       : out    vl_logic;
        branch_taken    : out    vl_logic;
        status_write_enable: out    vl_logic;
        ignore_hazard   : out    vl_logic
    );
end ControlUnit;
