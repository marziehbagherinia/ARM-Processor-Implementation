library verilog;
use verilog.vl_types.all;
entity Hazard_Detection_Unit is
    port(
        with_forwarding : in     vl_logic;
        have_two_src    : in     vl_logic;
        ignore_hazard   : in     vl_logic;
        ignore_from_forwarding: in     vl_logic;
        EXE_mem_read_en : in     vl_logic;
        src1_address    : in     vl_logic_vector(3 downto 0);
        src2_address    : in     vl_logic_vector(3 downto 0);
        exe_wb_dest     : in     vl_logic_vector(3 downto 0);
        mem_wb_dest     : in     vl_logic_vector(3 downto 0);
        exe_wb_en       : in     vl_logic;
        mem_wb_en       : in     vl_logic;
        hazard_detected : out    vl_logic
    );
end Hazard_Detection_Unit;
