-- Compile checked

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Priority_encoder IS
    PORT (
        PE_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        PE_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END Priority_encoder;

ARCHITECTURE arch_priority_encoder OF Priority_encoder IS
BEGIN
    P_encoding: PROCESS (PE_in)
    BEGIN
        if(PE_in(0)='1')then
            PE_out <= "111";
        elsif(PE_in(1)='1')then
            PE_out <= "110";
        elsif(PE_in(2)='1')then
            PE_out <= "101";
        elsif(PE_in(3)='1')then
            PE_out <= "100";
        elsif(PE_in(4)='1')then
            PE_out <= "011";
        elsif(PE_in(5)='1')then
            PE_out <= "010";
        elsif(PE_in(6)='1')then
            PE_out <= "001";
        elsif(PE_in(7)='1')then
            PE_out <= "000";
        else
            PE_out <= "UUU";
        end if;
    END PROCESS;

END arch_priority_encoder;