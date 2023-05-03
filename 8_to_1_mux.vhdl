-- Mux with 8 input lines

library ieee;
use ieee.std_logic_1164.all;

entity Mux_8_to_1 is
    port(
        i_select    : in std_logic_vector(2 downto 0);
        i_data1     : in std_logic;
        i_data2     : in std_logic;
        i_data3     : in std_logic;
        i_data4     : in std_logic;
        i_data5     : in std_logic;
        i_data6     : in std_logic;
        i_data7     : in std_logic;
        i_data8     : in std_logic;
        o_data      : out std_logic
    );
end entity Mux_8_to_1;

architecture arch_Mux_8_to_1 of Mux_8_to_1 is
begin
    o_data <=   i_data1 when i_select = "000" else
                i_data2 when i_select = "001" else
                i_data3 when i_select = "010" else
                i_data4 when i_select = "011" else
                i_data5 when i_select = "100" else
                i_data6 when i_select = "101" else
                i_data7 when i_select = "110" else
                i_data8;
end architecture arch_Mux_8_to_1;