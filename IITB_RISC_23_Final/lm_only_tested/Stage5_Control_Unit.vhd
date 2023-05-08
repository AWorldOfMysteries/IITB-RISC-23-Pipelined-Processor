-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;

entity Stage5_Control_Unit is
  port (
        Ins: in std_logic_vector(15 downto 0);
        mem_addr_s, mem_wr_en: out std_logic
    );
end Stage5_Control_Unit;


architecture Behaviour of Stage5_Control_Unit is

begin

    Controller_5: process(Ins)


    variable Op: std_logic_vector(3 downto 0);

    begin

    Op  := Ins(15 downto 12);

    if(Op="0101" or Op="0111")then
        mem_wr_en <= '1';
    else
        mem_wr_en <= '0';
    end if;

    if(Op="0110") then
        mem_addr_s <= '1';
    else
        mem_addr_s <= '0';
    end if;

    end process;
end Behaviour;