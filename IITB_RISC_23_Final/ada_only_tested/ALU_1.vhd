-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_signed.all; 

entity ALU_1 is
    port(


        ALU_1_Cin           : in std_logic;
        ALU_1_in1           : in std_logic_vector(15 downto 0);
        ALU_1_in2           : in std_logic_vector(15 downto 0);
        ALU_1_control       : in std_logic;
        ALU_1_out           : out std_logic_vector(15 downto 0);
        ALU_1_Z, ALU_1_C    : out std_logic
    );
end entity ALU_1;

architecture arch_ALU_1 of ALU_1 is
    signal result: std_logic_vector(15 downto 0);
    signal result_sig: std_logic_vector(16 downto 0);
    signal ALU_1_in1_sig: std_logic_vector(16 downto 0) := (others => '0');
    signal ALU_1_in2_sig: std_logic_vector(16 downto 0) := (others => '0');
begin
    ALU_1_in1_sig(15 downto 0) <= ALU_1_in1(15 downto 0); 
    ALU_1_in2_sig(15 downto 0) <= ALU_1_in2(15 downto 0);
    result_sig <= ALU_1_in1_sig + ALU_1_in2_sig + ALU_1_Cin;
    process(ALU_1_in1, ALU_1_in2, ALU_1_control)
    begin
        case ALU_1_control is
            when '0' =>               --  Add with carry operation
                result <= ALU_1_in1 + ALU_1_in2 + ALU_1_Cin;
                if(result_sig(16)='1') then
                    ALU_1_C <= '1';
                else
                    ALU_1_C <= '0';
                end if;
            when '1' =>                 -- Nand operation
                result <= ALU_1_in1 nand ALU_1_in2;
            when others =>
                null;
        end case;
    end process;
    ALU_1_Z <= '1' when result = x"0000" else '0';
    ALU_1_out <= result;
end architecture arch_ALU_1;