-- Compile Tested :-)

library ieee;
use ieee.std_logic_1164.all;

--The Third stage of REGISTER READ is assembled here :
--Files to be checked Sign Extenders, Shifter, Register File


entity REGISTER_READ is
    port(
         PC_in      : in std_logic_vector(15 downto 0);
         Ins_in     : in std_logic_vector(15 downto 0);
         Ra_addr_in, Rb_addr_in, Rc_addr_in: in std_logic_vector(2 downto 0);
         Data_in, HC_in1, HC_in2, R0_datain, ALU2_value: in std_logic_vector(15 downto 0);
         imm6_in: in std_logic_vector(5 downto 0);
         imm9_in: in std_logic_vector(8 downto 0);
         clk, rst, RF_wr_en, R0_wr_en: in std_logic;
         ALU1_A, ALU1_B, Ra_data, Rb_data, Data_Temp, R0_dataout: out std_logic_vector(15 downto 0);

         ---NEW SIGNALS
         Frwrd_Hzrd_A, Frwrd_Hzrd_B: in std_logic;
        Temp_Data_s: in std_logic_vector(1 downto 0) 
        );
end entity REGISTER_READ;


architecture Structure of REGISTER_READ is

component complement is
    port(data_in: in std_logic_vector(15 downto 0);
         data_out: out std_logic_vector(15 downto 0));
end component;

component Register_File is
    port(
        i_clk, i_rst        : in std_logic;
        i_reg_wr_en         : in std_logic;
        i_reg_wr_data       : in std_logic_vector(15 downto 0);
        i_reg_wr_addr       : in std_logic_vector(2 downto 0);
        i_reg_rd_addr_1     : in std_logic_vector(2 downto 0);
        i_reg_rd_addr_2     : in std_logic_vector(2 downto 0);
        o_reg_rd_data_1     : out std_logic_vector(15 downto 0);
        o_reg_rd_data_2     : out std_logic_vector(15 downto 0);

        i_r0_wr_en          : in std_logic;
        o_r0_rd             : out std_logic_vector(15 downto 0);
        i_r0_wr             : in std_logic_vector(15 downto 0)
    );
end component;

component Sign_Extender_6 IS
	PORT (
		SE_6_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		SE_6_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end component;

component Bit_Extender_6 IS
	PORT (
		BE_6_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		BE_6_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end component;

component Bit_Extender_9 IS
    PORT (
        BE_9_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        BE_9_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
end component;

component shifter_1 IS
    PORT (
        shift_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        shift_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
end component;

component Mux_4to1_16 is
    port(
        i_select    : in std_logic_vector(1 downto 0);
        i_data00     : in std_logic_vector(15 downto 0);
        i_data01     : in std_logic_vector(15 downto 0);
        i_data10     : in std_logic_vector(15 downto 0);
        i_data11     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
    );
end component;

component Mux_8to1_16 is
    port(
        i_select    : in std_logic_vector(2 downto 0);
        i_data000     : in std_logic_vector(15 downto 0);
        i_data001     : in std_logic_vector(15 downto 0);
        i_data010     : in std_logic_vector(15 downto 0);
        i_data011     : in std_logic_vector(15 downto 0);
        i_data100     : in std_logic_vector(15 downto 0);
        i_data101     : in std_logic_vector(15 downto 0);
        i_data110     : in std_logic_vector(15 downto 0);
        i_data111     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
    );
end component;

component Stage3_Control_Unit is
    port(
        Ins         : in std_logic_vector(15 downto 0);
        Sign_mux_s    : out std_logic_vector(1 downto 0);
        ALU1A_mux_s              : out std_logic_vector(1 downto 0);
        ALU1B_mux_s              : out std_logic_vector(2 downto 0)
--        Temp_Data_s           : out std_logic_vector(1 downto 0)
    );
end component Stage3_Control_Unit;

Signal Ra_Temp, Ra_Comp, Rb_Temp, Rb_Comp, Signed_Imm: std_logic_vector(15 downto 0);
signal c_BE_9, c_BE_6, c_SE_6, c_SH_A, c_SH_B   : std_logic_vector(15 downto 0);  

signal c_signed_selection, c_ALU1_A, c_ALU1_A_Temp, c_Temp_Data : std_logic_vector(1 downto 0);
signal  c_ALU1_B, c_ALU1_B_Temp : std_logic_vector(2 downto 0);

begin


Register_File_INST: Register_File port map(
                i_clk               => clk,
                i_rst               => rst,
                i_reg_wr_en         => RF_wr_en,
                i_reg_wr_data       => Data_in,
                i_reg_wr_addr       => Rc_addr_in,
                i_reg_rd_addr_1     => Ra_addr_in,
                i_reg_rd_addr_2     => Rb_addr_in,
                o_reg_rd_data_1     => Ra_Temp,
                o_reg_rd_data_2     => Rb_Temp,

                i_r0_wr_en      => R0_wr_en, 
                o_r0_rd         => R0_dataout,    --To Stage 1 without Buffers
                i_r0_wr         => R0_datain      --This R0 is directly from Stage 1 without Buffers
);
--------------------------------------------------------------------------------
Sign6_INST: Sign_Extender_6 port map(
                                SE_6_in => imm6_in,
                                SE_6_out => c_SE_6
);

Bit6_INST: Bit_Extender_6 port map(
                                BE_6_in => imm6_in,
                                BE_6_out => c_BE_6
);

Bit9_INST: Bit_Extender_9 port map(
                                BE_9_in => imm9_in,
                                BE_9_out => c_BE_9
);

ShiftA_INST: shifter_1 port map(
                          shift_in => c_BE_9,
                          shift_out => c_SH_A
); 

ShiftB_INST: shifter_1 port map(
                          shift_in => c_BE_6,
                          shift_out => c_SH_B
); 

ComplementA_INST: complement port map(
                                 data_in => Ra_Temp,
                                 data_out => Ra_Comp
);

ComplementB_INST: complement port map(
                                 data_in => Rb_Temp,
                                 data_out => Rb_Comp
);
----------------------------------------------------------------------------------

Signed_Selection_Mux_INST: Mux_4to1_16 port map(
                                           i_select => c_signed_selection,--Sign_mux_s;
                                           i_data00 => c_SE_6,    --- Sign Extended 6
                                           i_data01 => c_SH_B,     --- Bit Extended Shifted 6
                                           i_data10 => c_SH_A,    --- 9 bit extended shifted
                                           i_data11 => c_BE_9,    --- 9 bit extended
                                           o_data => Signed_Imm
);

ALU1_A_Mux_INST: Mux_4to1_16 port map(
                                 i_select => c_ALU1_A,-- ALU1A_mux_s;
                                 i_data00 => Ra_Temp,
                                 i_data01 => Signed_Imm,
                                 i_data10 => Ra_Comp,
                                 i_data11 => HC_in1,
                                 o_data => ALU1_A
);

ALU1_B_Mux_INST: Mux_8to1_16 port map(
                                 i_select =>  c_ALU1_B,--ALU1B_mux_s;
                                 i_data000 => Rb_Temp,
                                 i_data001 => PC_in,    -- This PC is from Buffer
                                 i_data010 => Rb_Comp,
                                 i_data011 => "0000000000000000",
                                 i_data100 => "UUUUUUUUUUUUUUUU",
                                 i_data101 => "UUUUUUUUUUUUUUUU",
                                 i_data110 => "UUUUUUUUUUUUUUUU",
                                 i_data111 => HC_in2,
                                 o_data => ALU1_B
);



Temp_Data_Mux_INST: Mux_4to1_16 port map(
                                    i_select => "00",--Temp_Data_s,--Temp_data_s; changedfortest
                                    i_data00 => Ra_Temp,
                                    i_data01 => Rb_Temp,
                                    i_data10 => ALU2_value,  --This comes directly from the next stage without buffer
                                    i_data11 => "UUUUUUUUUUUUUUUU",
                                    o_data => Data_Temp
);

Ra_data <= Ra_Temp;
Rb_data <= Rb_Temp;

s3_control_INST: Stage3_Control_Unit
    port map(
        Ins                     => Ins_in,
        Sign_mux_s              => c_signed_selection,
        ALU1A_mux_s             => c_ALU1_A_Temp,
        ALU1B_mux_s             => c_ALU1_B_Temp
    );


c_ALU1_A(0) <= c_ALU1_A_Temp(0) or Frwrd_Hzrd_A;
c_ALU1_A(1) <= c_ALU1_A_Temp(1) or Frwrd_Hzrd_A;
c_ALU1_B(0) <= c_ALU1_B_Temp(0) or Frwrd_Hzrd_B;
c_ALU1_B(1) <= c_ALU1_B_Temp(1) or Frwrd_Hzrd_B;
c_ALU1_B(2) <= c_ALU1_B_Temp(2) or Frwrd_Hzrd_B; 

end Structure;