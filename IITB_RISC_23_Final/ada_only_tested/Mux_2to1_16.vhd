-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;

entity Mux_2to1_16 is
    port(
        i_select    : in std_logic;
        i_data0     : in std_logic_vector(15 downto 0);
        i_data1     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
    );
end entity Mux_2to1_16;

architecture arch_Mux_2to1_16 of Mux_2to1_16 is
begin
    mux: process(i_data0, i_data1, i_select)

        begin
            
            case i_select is

                                when '0' =>
                                    o_data <= i_data0;
                                when '1' =>
                                    o_data <= i_data1;
                                when others =>
                                    o_data <= "UUUUUUUUUUUUUUUU";
            end case;
    end process mux;

end architecture arch_Mux_2to1_16;