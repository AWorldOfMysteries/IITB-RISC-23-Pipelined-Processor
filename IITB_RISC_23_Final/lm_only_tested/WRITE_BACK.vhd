-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;

--The Sixth stage of WRITE BACK is assembled here :

entity WRITE_BACK is
    port(
        ALU1_out_in         : in std_logic_vector(15 downto 0); 
        Mem_dataout_in      : in std_logic_vector(15 downto 0); 
        WB_data             : out std_logic_vector(15 downto 0);

        ---NEW SIGNALS
        Ins_in                          : in std_logic_vector(15 downto 0);
        --Temp_Data_in                    : in std_logic_vector(15 downto 0);
        ALU2_value_in                   : in std_logic_vector(15 downto 0);
        C1_old_in                       : in std_logic;
        Z1_old_in                       : in std_logic;
        R0_Update_Hazard_in             : in std_logic;
        C2_in                           : in std_logic;
        Z2_in                           : in std_logic;
        RF_wr_en_out                    : out std_logic
    );
end entity WRITE_BACK;


architecture Structure of WRITE_BACK is

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

component Stage6_Control_Unit is
    port(
        Ins             : in std_logic_vector(15 downto 0);
        C1_old          : in std_logic;
        Z1_old          : in std_logic;
        R0_Hazard       : in std_logic;
        RF_wr_en        : out std_logic;
        WB_mux_s        : out std_logic_vector(1 downto 0)
    );
end component;

Signal RF_wr_en_Temp: std_logic;
Signal WB_mux_s_Temp: std_logic_vector(1 downto 0);

begin

Write_Back_Mux_INST: Mux_4to1_16 port map(
    i_select => WB_mux_s_Temp,
    i_data00 => ALU1_out_in,
    i_data01 => Mem_dataout_in,
    i_data10 => x"0000",--Temp_Data_in,
    i_data11 => ALU2_value_in,
    o_data => WB_data
);

Controller_INST: Stage6_Control_Unit port map(
    Ins => Ins_in,
    C1_old => C1_old_in,
    Z1_old => Z1_old_in,
    R0_Hazard => R0_Update_Hazard_in,
    RF_wr_en => RF_wr_en_out,
    WB_mux_s => WB_mux_s_Temp
);
end Structure;