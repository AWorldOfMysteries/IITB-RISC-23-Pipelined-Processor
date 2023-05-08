-- Compile

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit_Extender_9 is
    port(
        BE_9_in : in std_logic_vector(8 downto 0);
        BE_9_out : out std_logic_vector(15 downto 0)
    );
end entity Bit_Extender_9;

architecture arch_Bit_Extender_9 OF Bit_Extender_9 is
begin
    BE_9_out(8 downto 0) <= BE_9_in(8 downto 0);
    BE_9_out(15 downto 9) <= "0000000";
end architecture arch_Bit_Extender_9;