-- COMPILE TESTED

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity alu_2 is
    port(
        ALU_2_in1, ALU_2_in2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_2_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_2_control : IN STD_LOGIC;
        ALU_2_C, ALU_2_Z : OUT STD_LOGIC
    );
end entity alu_2;

architecture arch_alu_2 of alu_2 is
    signal result: std_logic_vector(15 downto 0);
    signal result_sig: std_logic_vector(16 downto 0);
    signal ALU_2_in1_sig: std_logic_vector(16 downto 0) := (others => '0');
    signal ALU_2_in2_sig: std_logic_vector(16 downto 0) := (others => '0');
begin
    ALU_2_in1_sig(15 downto 0) <= ALU_2_in1(15 downto 0);
    ALU_2_in2_sig(15 downto 0) <= ALU_2_in2(15 downto 0);
    result_sig <= ALU_2_in1_sig + ALU_2_in2_sig;
    process(ALU_2_in1, ALU_2_in2, ALU_2_control)
    begin
        case ALU_2_control is
            when '1' =>               --  Subtraction operation
                result <= ALU_2_in1 - ALU_2_in2;
                if(to_integer(unsigned(ALU_2_in1))< to_integer(unsigned(ALU_2_in2))) then
                    ALU_2_C <= '1';
                else
                    ALU_2_C <= '0';
                end if;
            when '0' =>                 -- Add without carry operation
                result <= ALU_2_in1 + ALU_2_in2;
                if(result_sig(16)='1') then
                    ALU_2_C <= '1';
                else
                    ALU_2_C <= '0';
                end if;
            when others =>
                null;
        end case;
    end process;
    ALU_2_Z <= '1' when result = x"0000" else '0';
    ALU_2_out <= result;
end architecture arch_alu_2;