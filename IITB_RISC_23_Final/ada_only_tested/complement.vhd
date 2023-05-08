-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;

entity complement is
    port(data_in: in std_logic_vector(15 downto 0);
         data_out: out std_logic_vector(15 downto 0));
end entity complement;


architecture Structure of complement is



begin
    data_out(0) <= not(data_in(0));
    data_out(1) <= not(data_in(1));
    data_out(2) <= not(data_in(2));
    data_out(3) <= not(data_in(3));
    data_out(4) <= not(data_in(4));
    data_out(5) <= not(data_in(5));
    data_out(6) <= not(data_in(6));
    data_out(7) <= not(data_in(7));
    data_out(8) <= not(data_in(8));
    data_out(9) <= not(data_in(9));
    data_out(10) <= not(data_in(10));
    data_out(11) <= not(data_in(11));
    data_out(12) <= not(data_in(12));
    data_out(13) <= not(data_in(13));
    data_out(14) <= not(data_in(14));
    data_out(15) <= not(data_in(15));

end Structure;