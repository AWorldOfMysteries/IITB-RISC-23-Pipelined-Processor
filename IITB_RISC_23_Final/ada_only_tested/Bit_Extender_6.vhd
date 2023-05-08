-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit_Extender_6 is
    port(
        BE_6_in : in std_logic_vector(5 downto 0);
        BE_6_out : out std_logic_vector(15 downto 0)
    );
end entity Bit_Extender_6;

architecture arch_Bit_Extender_6 OF Bit_Extender_6 is
begin
    BE_6_out(5 downto 0) <= BE_6_in(5 downto 0);
    BE_6_out(15 downto 6) <= "0000000000";
end architecture arch_Bit_Extender_6;