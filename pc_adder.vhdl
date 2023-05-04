library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use ieee.std_logic_signed.all;

entity pc_adder is 
    port(
        i : in std_logic_vector(15 downto 0);
        o : out std_logic_vector(15 downto 0)
    );
end entity pc_adder;

architecture arch_pc_adder of pc_adder is
    begin
        o <= i + x"0001";
end architecture arch_pc_adder;