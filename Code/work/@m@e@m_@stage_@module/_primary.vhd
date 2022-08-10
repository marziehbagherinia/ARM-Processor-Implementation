library verilog;
use verilog.vl_types.all;
entity MEM_Stage_Module is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        freeze          : in     vl_logic;
        wb_en_in        : in     vl_logic;
        mem_r_en_in     : in     vl_logic;
        mem_w_en_in     : in     vl_logic;
        alu_res_in      : in     vl_logic_vector(31 downto 0);
        val_Rm          : in     vl_logic_vector(31 downto 0);
        dest_in         : in     vl_logic_vector(3 downto 0);
        wb_en_out       : out    vl_logic;
        mem_r_en_out    : out    vl_logic;
        alu_res_out     : out    vl_logic_vector(31 downto 0);
        mem_res_out     : out    vl_logic_vector(31 downto 0);
        dest_out        : out    vl_logic_vector(3 downto 0);
        wb_en_hazard_in : out    vl_logic;
        ready           : out    vl_logic;
        dest_hazard_in  : out    vl_logic_vector(3 downto 0)
    );
end MEM_Stage_Module;
