library ieee;
use ieee.std_logic_1164.all;

--The Fourth stage of EXECUTION UNIT is assembled here :
-- ALU1 and 2 to be checked; Include carry in calculations
-- Include Registers for C and Z flags of ALU1(Solved)


entity EXECUTION_UNIT is
    port(   


            C1_in              : in std_logic;
            Z1_in              : in std_logic;
            ALU1_A             : in std_logic_vector(15 downto 0);
            ALU1_B             : in std_logic_vector(15 downto 0);
            Data_Temp          : in std_logic_vector(15 downto 0);
            PC_in              : in std_logic_vector(15 downto 0);
            Ra_data            : in std_logic_vector(15 downto 0);
            Rb_data            : in std_logic_vector(15 downto 0);
            ALU1_out           : out std_logic_vector(15 downto 0);
            ALU2_out           : out std_logic_vector(15 downto 0);
            C1_out             : out std_logic;
            C2_out             : out std_logic;
            Z1_out             : out std_logic;
            Z2_out             : out std_logic;

             ---NEW SIGNALS
             Ins_in: in std_logic_vector(15 downto 0)

             ---Deleted Signals: C1_en, Z1_en, ALU1_Ctrl, ALU2_Ctrl
    );
end entity EXECUTION_UNIT;

architecture Structure of EXECUTION_UNIT is

component ALU_1 is
    PORT (
        ALU_1_Cin : IN STD_LOGIC;
        ALU_1_in1, ALU_1_in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_1_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_1_control : IN STD_LOGIC;
        ALU_1_C, ALU_1_Z : OUT STD_LOGIC
    );
end component;

component ALU_2 IS
    PORT (
        ALU_2_in1, ALU_2_in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_2_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_2_control : IN STD_LOGIC;
        ALU_2_C, ALU_2_Z : OUT STD_LOGIC
    );
end component;

component Mux_2to1_16 is
    port(
        i_select    : in std_logic;
        i_data0     : in std_logic_vector(15 downto 0);
        i_data1     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
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

component Stage4_Control_Unit is
    port(
        Ins: in std_logic_vector(15 downto 0);
        ALU1_Ctrl, ALU2_Ctrl, C1_en, Z1_en, C_take: out std_logic;

        ---NEW SIGNALS
        ALU2A_mux_s: out std_logic_vector(1 downto 0);
        ALU2B_mux_s: out std_logic_vector(1 downto 0)
    );
end component;

Signal C1_Temp, Z1_Temp: std_logic;
Signal ALU2_A_in, ALU2_B_in: std_logic_vector(15 downto 0);
Signal ALU1_Ctrl_Temp, ALU2_Ctrl_Temp, C1_en_Temp, Z1_en_Temp, C_take_Temp, C1_in_Temp: std_logic;
Signal ALU2A_mux_s_Temp, ALU2B_mux_s_Temp: std_logic_vector(1 downto 0);


begin

C1_in_Temp <= C1_in and C_take_Temp;

ALU1_INST: ALU_1 port map(
                     
                     ALU_1_Cin => C1_in_Temp,
                     ALU_1_in1 => ALU1_A,
                     ALU_1_in2 => ALU1_B,
                     ALU_1_out => ALU1_out,
                     ALU_1_control => ALU1_Ctrl_Temp,
                     ALU_1_C => C1_Temp,
                     ALU_1_Z => Z1_Temp
);

C1_out <= (C1_Temp and C1_en_Temp) or (C1_in and not(C1_en_Temp));
Z1_out <= (Z1_Temp and Z1_en_Temp) or (Z1_in and not(Z1_en_Temp));

ALU2_A_Mux_INST: Mux_4to1_16 port map(
                                 i_select => ALU2A_mux_s_Temp,
                                 i_data00 => Ra_data,
                                 i_data01 => PC_in,
                                 i_data10 => "UUUUUUUUUUUUUUUU",
                                 i_data11 => Data_Temp,
                                 o_data => ALU2_A_in
);

ALU2_B_Mux_INST: Mux_4to1_16 port map(
                                 i_select => ALU2B_mux_s_Temp,
                                 i_data00 => Rb_data,
                                 i_data01 => "0000000000000001",
                                 i_data10 => "0000000000000000",
                                 i_data11 => "UUUUUUUUUUUUUUUU",
                                 o_data => ALU2_B_in
);



ALU2_INST: ALU_2 port map(
                     ALU_2_in1 => ALU2_A_in,
                     ALU_2_in2 => ALU2_B_in,
                     ALU_2_out => ALU2_out,
                     ALU_2_control => ALU2_Ctrl_Temp,
                     ALU_2_C => C2_out,
                     ALU_2_Z => Z2_out
);

Controller_INST: Stage4_Control_Unit port map(
    Ins => Ins_in,
    ALU1_Ctrl => ALU1_Ctrl_Temp,
    ALU2_Ctrl => ALU2_Ctrl_Temp,
    C1_en => C1_en_Temp,
    Z1_en => Z1_en_Temp,
    C_take => C_take_Temp,
    ALU2A_mux_s => ALU2A_mux_s_Temp,
    ALU2B_mux_s => ALU2B_mux_s_Temp

);




end Structure;