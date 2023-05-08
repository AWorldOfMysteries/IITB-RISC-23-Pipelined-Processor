-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;

--The Fifth stage of MEMORY ACCESS is assembled here :
--Data memory to be checked

entity MEMORY_ACCESS is
    port (
        clk                 : in std_logic;
        ALU1_in             : in std_logic_vector(15 downto 0);
        ALU2_in             : in std_logic_vector(15 downto 0);   ---THIS MAY BE CONNECTED TO TEMP REG INSTEAD OF ALU OUTPUT
        Data_in             : in std_logic_vector(15 downto 0);
        Data_out            : out std_logic_vector(15 downto 0);

        ---NEW SIGNALS
        Ins_in              : in std_logic_vector(15 downto 0)
    );
end entity MEMORY_ACCESS;

architecture Structure of MEMORY_ACCESS is

component Data_Memory is
    PORT (
        clk : IN STD_LOGIC;
        mem_write_en : IN STD_LOGIC;
        mem_write_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        mem_read_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        mem_access_addr : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
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

component Stage5_Control_Unit is
    port (
          Ins: in std_logic_vector(15 downto 0);
          mem_addr_s, mem_wr_en: out std_logic
      );
end component;

Signal Mem_addr: std_logic_vector(15 downto 0);
Signal mem_wr_en_Temp, mem_addr_s_Temp: std_logic;

begin

Memory_Address_Mux_INS: Mux_2to1_16 port map(
                                         i_select => mem_addr_s_Temp,
                                         i_data0 => ALU1_in,
                                         i_data1 => ALU2_in,
                                         o_data  => Mem_addr
);

Data_Memory_INS: Data_Memory port map(
                                  clk => clk,   --
                                  mem_write_en => mem_wr_en_Temp,    --
                                  mem_write_data => Data_in,    --
                                  mem_read_data => Data_out,    --
                                  mem_access_addr => Mem_addr   --
);

Controller: Stage5_Control_Unit port map(
    Ins => Ins_in,
    mem_addr_s => mem_addr_s_Temp,
    mem_wr_en => mem_wr_en_Temp
);




end Structure;
