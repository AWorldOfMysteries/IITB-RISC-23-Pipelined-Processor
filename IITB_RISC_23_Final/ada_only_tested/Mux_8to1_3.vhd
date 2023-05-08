-- Compile checked

library ieee;
use ieee.std_logic_1164.all;

entity Mux_8to1_3 is
    port(
        i_select      : in std_logic_vector(2 downto 0);
        i_data000     : in std_logic_vector(2 downto 0);
        i_data001     : in std_logic_vector(2 downto 0);
        i_data010     : in std_logic_vector(2 downto 0);
        i_data011     : in std_logic_vector(2 downto 0);
        i_data100     : in std_logic_vector(2 downto 0);
        i_data101     : in std_logic_vector(2 downto 0);
        i_data110     : in std_logic_vector(2 downto 0);
        i_data111     : in std_logic_vector(2 downto 0);
        o_data        : out std_logic_vector(2 downto 0)
    );
end entity Mux_8to1_3;

architecture arch_Mux_8to1_3 of Mux_8to1_3 is
begin
    mux: process(i_data000, i_data001, i_data010, i_data011, i_data100, i_data101, i_data110, i_data111, i_select)

        begin
            
            case i_select is

                                when "000" =>
                                    o_data <= i_data000;
                                when "001" =>
                                    o_data <= i_data001;
                                when "010" =>
                                    o_data <= i_data010;
                                when "011" =>
                                    o_data <= i_data011;
                                when "100" =>
                                    o_data <= i_data100;
                                when "101" =>
                                    o_data <= i_data101;
                                when "110" =>
                                    o_data <= i_data110;
                                when "111" =>
                                    o_data <= i_data111;
                                when others =>
                                    o_data <= "UUU";
            end case;
    end process mux;

end architecture arch_Mux_8to1_3;