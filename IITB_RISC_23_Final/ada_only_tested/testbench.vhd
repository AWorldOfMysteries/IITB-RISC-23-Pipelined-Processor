library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity testbench is 
end entity testbench;

architecture arch_testbench of testbench is
    constant c_CLOCK_PERIOD : time := 100 ns; 
    signal r_CLOCK          : std_logic := '1';

begin
    UUT: entity work.DATAPATH
     port map(
        clk     => r_CLOCK,
        rst     => '0'
    );
    p_CLK_GEN : process is
    begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN;
end architecture arch_testbench;