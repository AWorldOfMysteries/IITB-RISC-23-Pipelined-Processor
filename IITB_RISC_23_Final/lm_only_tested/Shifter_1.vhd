-- Compile Tested

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY shifter_1 IS
    PORT (
        shift_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        shift_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END shifter_1;

ARCHITECTURE arch_shifter_1 OF shifter_1 IS
BEGIN

    PROCESS (shift_in)
    BEGIN
        shift_out <= shift_in(14 DOWNTO 0) & "0";
    END PROCESS;

END arch_shifter_1;