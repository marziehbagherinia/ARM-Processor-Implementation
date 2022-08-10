library verilog;
use verilog.vl_types.all;
entity WB_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_read_enable : in     vl_logic;
        wb_enable_in    : in     vl_logic;
        alu_result      : in     vl_logic_vector(31 downto 0);
        data_memory     : in     vl_logic_vector(31 downto 0);
        wb_dest_in      : in     vl_logic_vector(3 downto 0);
        wb_enable_out   : out    vl_logic;
        wb_dest_out     : out    vl_logic_vector(3 downto 0);
        wb_value        : out    vl_logic_vector(31 downto 0)
    );
end WB_Stage;
