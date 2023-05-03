-- Mux with 2 input lines

library ieee;
use ieee.std_logic_1164.all;

entity Mux_2_to_1 is
    port(
        i_select    : in std_logic;
        i_data1     : in std_logic;
        i_data2     : in std_logic;
        o_data      : out std_logic
    );
end entity Mux_2_to_1;

architecture arch_Mux_2_to_1 of Mux_2_to_1 is
begin
    o_data <=   i_data1 when i_select = '0' else
                i_data2;
end architecture arch_Mux_2_to_1;