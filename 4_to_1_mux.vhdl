-- Mux with 4 input lines

library ieee;
use ieee.std_logic_1164.all;

entity Mux_4_to_1 is
    port(
        i_select    : in std_logic_vector(1 downto 0);
        i_data1     : in std_logic;
        i_data2     : in std_logic;
        i_data3     : in std_logic;
        i_data4     : in std_logic;
        o_data      : out std_logic
    );
end entity Mux_4_to_1;

architecture arch_Mux_4_to_1 of Mux_4_to_1 is
begin
    o_data <=   i_data1 when i_select = "00" else
                i_data2 when i_select = "01" else
                i_data3 when i_select = "10" else
                i_data4;
end architecture arch_Mux_4_to_1;