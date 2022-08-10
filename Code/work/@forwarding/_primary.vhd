library verilog;
use verilog.vl_types.all;
entity Forwarding is
    port(
        en_forwarding   : in     vl_logic;
        WB_wb_en        : in     vl_logic;
        MEM_wb_en       : in     vl_logic;
        MEM_dst         : in     vl_logic_vector(3 downto 0);
        WB_dst          : in     vl_logic_vector(3 downto 0);
        ID_src1         : in     vl_logic_vector(3 downto 0);
        ID_src2         : in     vl_logic_vector(3 downto 0);
        sel_src1        : out    vl_logic_vector(1 downto 0);
        sel_src2        : out    vl_logic_vector(1 downto 0);
        ignore_hazard   : out    vl_logic
    );
end Forwarding;
