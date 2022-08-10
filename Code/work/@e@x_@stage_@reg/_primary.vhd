library verilog;
use verilog.vl_types.all;
entity EX_Stage_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        freeze          : in     vl_logic;
        wb_en_in        : in     vl_logic;
        mem_r_en_in     : in     vl_logic;
        mem_w_en_in     : in     vl_logic;
        alu_res_in      : in     vl_logic_vector(31 downto 0);
        val_Rm_in       : in     vl_logic_vector(31 downto 0);
        dest_in         : in     vl_logic_vector(3 downto 0);
        branch_taken_in : in     vl_logic;
        wb_en_out       : out    vl_logic;
        mem_r_en_out    : out    vl_logic;
        mem_w_en_out    : out    vl_logic;
        alu_res_out     : out    vl_logic_vector(31 downto 0);
        val_Rm_out      : out    vl_logic_vector(31 downto 0);
        dest_out        : out    vl_logic_vector(3 downto 0);
        branch_taken_out: out    vl_logic
    );
end EX_Stage_Reg;
