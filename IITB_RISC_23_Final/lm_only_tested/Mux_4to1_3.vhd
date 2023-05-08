library ieee;
use ieee.std_logic_1164.all;

entity Mux_4to1_3 is
    port(
        i_select    : in std_logic_vector(1 downto 0);
        i_data00     : in std_logic_vector(2 downto 0);
        i_data01     : in std_logic_vector(2 downto 0);
        i_data10     : in std_logic_vector(2 downto 0);
        i_data11     : in std_logic_vector(2 downto 0);
        o_data      : out std_logic_vector(2 downto 0)
    );
end entity Mux_4to1_3;

architecture arch_Mux_4to1_3 of Mux_4to1_3 is
begin
    mux: process(i_data00, i_data01, i_data10, i_data11, i_select)

        begin
            
            case i_select is

                                when "00" =>
                                    o_data <= i_data00;
                                when "01" =>
                                    o_data <= i_data01;
                                when "10" =>
                                    o_data <= i_data10;
                                when "11" =>
                                    o_data <= i_data11;
                                when others =>
                                    o_data <= "UUU";
            end case;
    end process mux;

end architecture arch_Mux_4to1_3;