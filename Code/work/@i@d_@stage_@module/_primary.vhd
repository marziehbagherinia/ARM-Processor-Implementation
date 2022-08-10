library verilog;
use verilog.vl_types.all;
entity ID_Stage_Module is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        freeze          : in     vl_logic;
        PC_in           : in     vl_logic_vector(31 downto 0);
        Instruction_in  : in     vl_logic_vector(31 downto 0);
        status_reg_in   : in     vl_logic_vector(3 downto 0);
        reg_file_wb_data: in     vl_logic_vector(31 downto 0);
        reg_file_wb_address: in     vl_logic_vector(3 downto 0);
        reg_file_wb_en  : in     vl_logic;
        hazard          : in     vl_logic;
        two_src_out     : out    vl_logic;
        ignore_hazard_out: out    vl_logic;
        reg_file_second_src_out: out    vl_logic_vector(3 downto 0);
        reg_file_first_src_out: out    vl_logic_vector(3 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        mem_read_en_out : out    vl_logic;
        mem_write_en_out: out    vl_logic;
        wb_enable_out   : out    vl_logic;
        immediate_out   : out    vl_logic;
        branch_taken_out: out    vl_logic;
        status_write_enable_out: out    vl_logic;
        execute_command_out: out    vl_logic_vector(3 downto 0);
        reg_file_out1   : out    vl_logic_vector(31 downto 0);
        reg_file_out2   : out    vl_logic_vector(31 downto 0);
        dest_reg_out    : out    vl_logic_vector(3 downto 0);
        sign_immediate_out: out    vl_logic_vector(23 downto 0);
        shift_operand_out: out    vl_logic_vector(11 downto 0);
        status_reg_out  : out    vl_logic_vector(3 downto 0);
        staged_reg_file_second_src_out: out    vl_logic_vector(3 downto 0);
        staged_reg_file_first_src_out: out    vl_logic_vector(3 downto 0)
    );
end ID_Stage_Module;
