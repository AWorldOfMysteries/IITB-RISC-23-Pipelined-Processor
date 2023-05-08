library ieee;
use ieee.std_logic_1164.all;

entity DATAPATH is
    port(
        clk     : in std_logic;
        rst     : in std_logic
    );
end entity DATAPATH;

architecture structure of DATAPATH is
-- Signal Definitions
-------------------STAGE 1-----------------
signal S1_1     : std_logic_vector(15 downto 0);
signal S1_2     : std_logic_vector(15 downto 0);
signal S1_3     : std_logic_vector(15 downto 0);
-------------------------------------------

-------------------STAGE 2-----------------
signal S2_1     : std_logic_vector(15 downto 0);
signal S2_2     : std_logic_vector(15 downto 0);
signal S2_3     : std_logic_vector(2 downto 0);
signal S2_4     : std_logic_vector(2 downto 0);
signal S2_5     : std_logic_vector(2 downto 0);
signal S2_6     : std_logic_vector(8 downto 0);
signal S2_7     : std_logic_vector(5 downto 0);

signal S2_Ra    : std_logic_vector(2 downto 0);
signal S2_Rc    : std_logic_vector(2 downto 0);
-------------------------------------------

-------------------STAGE 3-----------------
signal S3_1      : std_logic_vector(15 downto 0);
signal S3_2      : std_logic_vector(15 downto 0);
signal S3_3      : std_logic_vector(2 downto 0);
signal S3_4      : std_logic_vector(2 downto 0);
signal S3_5      : std_logic_vector(2 downto 0);
signal S3_6      : std_logic_vector(8 downto 0);
signal S3_7      : std_logic_vector(5 downto 0);
signal S3_8      : std_logic_vector(15 downto 0);
signal S3_9      : std_logic_vector(15 downto 0);
signal S3_10     : std_logic_vector(15 downto 0);
signal S3_11     : std_logic_vector(15 downto 0);
signal S3_12     : std_logic_vector(15 downto 0);
signal S3_13     : std_logic_vector(15 downto 0);
-------------------------------------------

-------------------STAGE 4-----------------
signal S4_1      : std_logic_vector(15 downto 0);
signal S4_2      : std_logic_vector(15 downto 0);
signal S4_3      : std_logic_vector(15 downto 0);
signal S4_4      : std_logic_vector(15 downto 0);
signal S4_5      : std_logic_vector(15 downto 0);
signal S4_6      : std_logic_vector(15 downto 0);
signal S4_7      : std_logic_vector(15 downto 0);
signal S4_8      : std_logic_vector(15 downto 0);
signal S4_9      : std_logic_vector(15 downto 0);
-- signal S4_10     : std_logic_vector(15 downto 0);
-- signal S4_11     : std_logic_vector(15 downto 0);
-- signal S4_12     : std_logic_vector(15 downto 0);
-- signal S4_13     : std_logic_vector(15 downto 0);
signal S4_C1        : std_logic;
signal S4_C2        : std_logic;
signal S4_Z1        : std_logic;
signal S4_Z2        : std_logic;

signal S4_rc        : std_logic_vector(2 downto 0);
-------------------------------------------

-------------------STAGE 5-----------------
signal S5_1      : std_logic_vector(15 downto 0);
signal S5_2      : std_logic_vector(15 downto 0);
signal S5_3      : std_logic_vector(15 downto 0);
signal S5_4      : std_logic_vector(15 downto 0);
signal S5_5      : std_logic_vector(15 downto 0);
signal S5_6      : std_logic_vector(15 downto 0);
signal S5_7      : std_logic;
signal S5_8      : std_logic;

signal S5_C1        : std_logic;
signal S5_C2        : std_logic;
signal S5_Z1        : std_logic;
signal S5_Z2        : std_logic;

signal S5_rc        : std_logic_vector(2 downto 0);
-------------------------------------------

-------------------STAGE 6-----------------
signal S6_1      : std_logic_vector(15 downto 0);
signal S6_2      : std_logic_vector(15 downto 0);
signal S6_3      : std_logic_vector(15 downto 0);
signal S6_4      : std_logic_vector(15 downto 0);
signal S6_5      : std_logic_vector(15 downto 0);

signal S6_C1        : std_logic;
signal S6_C2        : std_logic;
signal S6_Z1        : std_logic;
signal S6_Z2        : std_logic;

signal S6_rc            : std_logic_vector(2 downto 0);
signal S6_RF_wr_en_out  : std_logic;          
signal S6_WB_data       : std_logic_vector(15 downto 0);            
-------------------------------------------

-------------------------Hazard Control---------------------------------
signal S7_1      : std_logic_vector(2 downto 0);
signal S7_2      : std_logic_vector(1 downto 0);
signal S7_3      : std_logic;
signal S7_4      : std_logic_vector(15 downto 0);
signal S7_5      : std_logic;
signal S7_6      : std_logic_vector(15 downto 0);
signal S7_7      : std_logic_vector(15 downto 0);
signal S7_8      : std_logic_vector(15 downto 0);
signal S7_9      : std_logic;
signal S7_10     : std_logic_vector(1 downto 0);
signal S7_11     : std_logic;
signal S7_12     : std_logic;

signal Buffer1en : std_logic;
signal Buffer2en : std_logic;
signal Buffer3en : std_logic;
signal Buffer4en : std_logic;
signal Buffer5en : std_logic;

------------------------------------------------------------------------
begin
-----------------------------Stage 1----------------------------------
    INS_FETCH_INST: entity work.INS_FETCH
    port map(
        Ins_mux_s           => S7_3,
        R0_pass_mux         => S7_2, 
        HC_Ins_in           => S7_4,
        ALU_frwrd_in        => S4_8,
        Mem_frwrd_in        => S5_6,
        R0_dataRF           => S3_12,
        Ins_addr_out_B      => S1_1,
        R0_datain_RF        => S1_2,
        Ins_out_B           => S1_3
    );
    Buffer_1_INST: entity work.Buffer1_IFS_IDC
    port map(
        i_rst       => rst,
        i_en        => Buffer1en,
        i_clk       => clk,
        i_b1_Ins    => S1_3,
        i_b1_pc     => S1_1,
        o_b1_Ins    => S2_1,
        o_b1_pc     => S2_2
    );
-------------------------------------------------------------------
                        
---------------------------Stage 2----------------------------------
    INS_DECODE_INST: entity work.INS_DECODE
    port map(
        Ins_in          => S2_1,
        Ra_addr         => S2_3,
        Rb_addr         => S2_4,
        Rc_addr         => S2_5,
        Ra_mux          => S2_Ra,
        Rc_mux          => S2_Rc,
        P_enc_addr      => S7_1,
        imm9_out        => S2_6,
        imm6_out        => S2_7
    );
    Buffer_2_INST: entity work.Buffer2_IDC_RR
    port map(
        i_rst               => rst,
        i_en                => Buffer2en,
        i_clk               => clk,
        i_b2_Ra_Addr        => S2_Ra,
        i_b2_Rb_Addr        => S2_4,
        i_b2_Rc_Addr        => S2_Rc,
        i_b2_imm9           => S2_6,
        i_b2_imm6           => S2_7,
        i_b2_pc             => S2_2, 
        i_ins               => S2_1,
        o_b2_Ra_Addr        => S3_3,
        o_b2_Rb_Addr        => S3_4,
        o_b2_Rc_Addr        => S3_5,
        o_b2_imm9           => S3_6,
        o_b2_imm6           => S3_7,
        o_b2_pc             => S3_2,
        o_ins               => S3_1

    );
-------------------------------------------------------------------

-----------------------------Stage 3---------------------------------
    REGISTER_READ_INST: entity work.REGISTER_READ
    port map(
       Ins_in        => S3_1,  
       PC_in         => S3_2,    
       Ra_addr_in    => S3_3,
       Rb_addr_in    => S3_4,
       Rc_addr_in    => S6_rc,
       Data_in       => S6_WB_data,              
       HC_in1        => S7_6,         
       HC_in2        => S7_7,         
       R0_datain     => S1_2,            
       ALU2_value    => S4_9,             
       imm6_in       => S3_7,          
       imm9_in       => S3_6,          
       clk           => clk,      
       rst           => rst,      
       RF_wr_en      => S6_RF_wr_en_out,           
       R0_wr_en      => S7_5,           
       ALU1_A        => S3_8,         
       ALU1_B        => S3_9,         
       Ra_data       => S3_10,          
       Rb_data       => S3_11,          
       Data_Temp     => S3_13,            
       R0_dataout    => S3_12,
       
       ---NEW SIGNALS
       Frwrd_Hzrd_A => S7_11,
       Frwrd_Hzrd_B  => S7_12,
       Temp_Data_s   => S7_10
    );
    Buffer_3_INST: entity work.Buffer3_RR_EX
    port map(
        i_rst               => rst,   
        i_en                => Buffer3en,
        i_clk               => clk,
        i_ALU1_A_input      => S3_8,
        i_ALU1_B_input      => S3_9,
        i_Ra_data           => S3_10,
        i_Rb_data           => S3_11,
        i_Temp_Data         => S3_12,
        i_PC_in             => S3_2,
        i_Ins               => S3_1,
        o_ALU1_A_input      => S4_3,
        o_ALU1_B_input      => S4_4,
        o_Ra_data           => S4_5,
        o_Rb_data           => S4_6,
        o_Temp_Data         => S4_7,
        o_PC_in             => S4_2,
        o_Ins               => S4_1,

        i_Rc_addr           => S3_5,
        o_Rc_addr           => S4_rc
    );
-------------------------------------------------------------------

----------------------------Stage 4-------------------------------
    EXECUTION_UNIT_INST: entity work.EXECUTION_UNIT
    port map(          
    --clk_in => clk,

        C1_in           => S5_C1,              
        Z1_in           => S5_Z1,              
        ALU1_A          => S4_3,              
        ALU1_B          => S4_4,              
        Data_Temp       => S4_7,              
        PC_in           => S4_2,              
        Ra_data         => S4_5,              
        Rb_data         => S4_6,      
        ALU1_out        => S4_8,              
        ALU2_out        => S4_9,              
        C1_out          => S4_C1,              
        C2_out          => S4_C2,              
        Z1_out          => S4_Z1,              
        Z2_out          => S4_Z2,              
        Ins_in          => S4_1   
    );
    Buffer_4_INST: entity work.Buffer4_EX_MA
    port map(
        i_rst           => rst,       
        i_en            => Buffer4en,        
        i_clk           => clk,        
        i_Rc_addr       => S4_rc,       
        o_Rc_addr       => S5_rc,       
        i_ALU1_output   => S4_8,       
        i_ALU2_output   => S4_9,       
        --i_Mem_data      =>  ,       
        i_Ra_data       => S4_5,       
        i_PC_in         => S4_2,       
        i_Ins_in        => S4_1,       
        i_C1_in         => S4_C1,       
        i_C2_in         => S4_C2,       
        i_Z1_in         => S4_Z1,       
        i_Z2_in         => S4_Z2,       
        o_ALU1_output   => S5_4,       
        o_ALU2_output   => S5_5,       
        --o_Mem_data      =>  ,       
        o_Ra_data       => S5_3,       
        o_PC_in         => S5_2,       
        o_Ins_in        => S5_1,       
        o_C1_in         => S5_C1,       
        o_C2_in         => S5_C2,       
        o_Z1_in         => S5_Z1,       
        o_Z2_in         => S5_Z2       
        );
-------------------------------------------------------------------
        
-----------------------------Stage 5---------------------------------
    MEMORY_ACCESS_INST: entity work.MEMORY_ACCESS
    port map(
        clk         => clk,
        ALU1_in     => S5_4,
        ALU2_in     => S5_5,
        Data_in     => S5_3,
        Data_out    => S5_6,
        Ins_in      => S5_1
    );
    Buffer_5_INST: entity work.Buffer5_MA_WB
    port map(
        i_rst           => rst,
        i_en            => Buffer5en,
        i_clk           => clk,
        i_C1_in         => S5_C1,
        i_C2_in         => S5_C2,
        i_Z1_in         => S5_Z1,
        i_Z2_in         => S5_Z2,

        i_C1_old_in     => S5_7,
        i_Z1_old_in     => S5_8,

        i_ALU1_dataout  => S5_4,
        i_ALU2_dataout  => S5_5,
        i_Mem_dataout   => S5_6,
        i_Dest_addr     => S5_rc,
        i_Ins_in        => S5_1,
        i_PC_in         => S5_2,
        o_C1_in         => S5_7,
        o_Z1_in         => S5_8,
        o_C2_in         => S6_C2,
        o_Z2_in         => S6_Z2,

        o_C1_old_out    => S6_C1,       
        o_Z1_old_out    => S6_Z1,       ---ADD a line for Temp Register data [Dont do this now]

        o_ALU1_dataout  => S6_3,
        o_ALU2_dataout  => S6_4,
        o_Mem_dataout   => S6_5,
        o_Dest_addr     => S6_rc,
        o_Ins_in        => S6_1,
        o_PC_in         => S6_2       
    );

-------------------------------------------------------------------
----Chhota sa change h Stage 6 me; ALU 2 ka out put bhi pass kardenaa buffers ke through Write Back ko
-------------------------------Stage 6----------------------------------

WRITE_BACK_INST: entity work.WRITE_BACK
    port map(
        ALU1_out_in             => S6_3,
        Mem_dataout_in          => S6_5,
        WB_data                 => S6_WB_data,
        Ins_in                  => S6_1,
        --Temp_Data_in            => *,
        ALU2_value_in           => S6_4,
        C1_old_in               => S6_C1,
        Z1_old_in               => S6_Z1,
        R0_Update_Hazard_in     => S7_9,
        C2_in                   => S6_C2,
        Z2_in                   => S6_Z2,
        RF_wr_en_out            => S6_RF_wr_en_out
    );
-------SMALL CHANGE IN PORTS OF REGISTER READ STAGE-------------

-------------------------Hazard Control Unit--------------------------------
Hazard_Control_INST: entity work.Hazard_Control
    port map(
        clk             => clk,

        ALU             => S4_8,
        ALU_MEM         => S5_4,
        MEM_DATA        => S5_6, ---Memory output
        WB              => S6_WB_data,
        IB1             => S2_1,
        IB2             => S3_1,
        IB3             => S4_1,
        IB4             => S5_1,
        IB5             => S6_1,
        Ra_Addr         => S2_3,
        Rb_Addr         => S2_4,
        P_enc_addr      => S7_1,
        DATA_FA         => S7_6,
        DATA_FB         => S7_7,
        DATA_R0         => S7_8,
        Ins_outB        => S7_4,
        A_dataF         => S7_11,
        B_dataF         => S7_12,
        BF1_en          => Buffer1en,
        BF2_en          => Buffer2en,
        BF3_en          => Buffer3en,
        BF4_en          => Buffer4en,
        BF5_en          => Buffer5en,
        R0_pass_mux     => S7_2,
        Ins_mux_s       => S7_3,
        R0_wr_en        => S7_5,

        R0_Hazard_out   => S7_9,
        Temp_data_s_out => S7_10,

        C2              => S6_C2,
        Z2              => S6_Z2
    );
----------------------------------------------------------------------------
end structure;   