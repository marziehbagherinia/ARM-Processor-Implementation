library verilog;
use verilog.vl_types.all;
entity EX_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC_in           : in     vl_logic_vector(31 downto 0);
        wb_en_in        : in     vl_logic;
        mem_r_en_in     : in     vl_logic;
        mem_w_en_in     : in     vl_logic;
        status_w_en_in  : in     vl_logic;
        branch_taken_in : in     vl_logic;
        immd            : in     vl_logic;
        exe_cmd         : in     vl_logic_vector(3 downto 0);
        val_Rn          : in     vl_logic_vector(31 downto 0);
        val_Rm_in       : in     vl_logic_vector(31 downto 0);
        dest_in         : in     vl_logic_vector(3 downto 0);
        signed_immd_24  : in     vl_logic_vector(23 downto 0);
        shift_operand   : in     vl_logic_vector(11 downto 0);
        status_reg_in   : in     vl_logic_vector(3 downto 0);
        alu_mux_sel_src1: in     vl_logic_vector(1 downto 0);
        alu_mux_sel_src2: in     vl_logic_vector(1 downto 0);
        MEM_wb_value    : in     vl_logic_vector(31 downto 0);
        WB_wb_value     : in     vl_logic_vector(31 downto 0);
        wb_en_out       : out    vl_logic;
        mem_r_en_out    : out    vl_logic;
        mem_w_en_out    : out    vl_logic;
        status_w_en_out : out    vl_logic;
        branch_taken_out: out    vl_logic;
        dest_out        : out    vl_logic_vector(3 downto 0);
        alu_res         : out    vl_logic_vector(31 downto 0);
        val_Rm_out      : out    vl_logic_vector(31 downto 0);
        statusRegister  : out    vl_logic_vector(3 downto 0);
        branch_address  : out    vl_logic_vector(31 downto 0)
    );
end EX_Stage;
