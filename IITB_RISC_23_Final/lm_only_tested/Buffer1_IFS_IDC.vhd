-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Buffer1_IFS_IDC is
    port(
        i_rst           : in std_logic;
        i_en            : in std_logic;
        i_clk           : in std_logic;
        i_b1_Ins        : in std_logic_vector(15 downto 0);
        i_b1_pc         : in std_logic_vector(15 downto 0);
        o_b1_Ins        : out std_logic_vector(15 downto 0);
        o_b1_pc         : out std_logic_vector(15 downto 0)
    );
end entity Buffer1_IFS_IDC;

architecture arch_Buffer1_IFS_IDC of Buffer1_IFS_IDC is
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            o_b1_Ins        <= x"0000";
            o_b1_pc     <= x"0000";
        elsif(rising_edge(i_clk)) then
            if(i_en='1') then
                o_b1_Ins        <= i_b1_Ins;
                o_b1_pc         <= i_b1_pc;
            -- elsif(i_en='0')then
                -- o_b1_Ins        <= "1011000000000000";   ---DUMMY UNUSABLE INSTRUCTION
            end if;
        end if;
    end process;
end architecture arch_Buffer1_IFS_IDC;