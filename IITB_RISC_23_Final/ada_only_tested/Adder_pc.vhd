--Compile Checked

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
use ieee.std_logic_signed.all;

ENTITY Adder_pc IS
    PORT (
        ADDER_IN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ADDER_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END Adder_pc;

ARCHITECTURE arch_Adder_pc OF Adder_pc IS 
BEGIN
    ADDER_OUT <= ADDER_IN + x"0001";
END arch_Adder_pc;