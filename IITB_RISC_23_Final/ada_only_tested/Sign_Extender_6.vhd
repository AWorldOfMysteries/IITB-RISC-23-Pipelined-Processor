-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_Extender_6 is
	port(
		SE_6_in : in std_logic_vector(5 downto 0);
		SE_6_out : out std_logic_vector(15 downto 0)
	);
end entity Sign_Extender_6;

architecture arch_Sign_Extender_6 of Sign_Extender_6 is
begin
	SE_6_out(4 downto 0) <= SE_6_in(4 downto 0);
	SE_6_out(15 downto 5) <= "11111111111" when SE_6_in(5) = '1' else "00000000000";
end architecture arch_Sign_Extender_6;