library ieee;
use ieee.std_logic_1164.all;

entity Stage2_Control_Unit is
    port (Ins: in std_logic_vector(15 downto 0);
          Ra_mux_s, Rc_mux_s: out std_logic);
end entity Stage2_Control_Unit;


architecture Behaviour of Stage2_Control_Unit is


begin

    Controller_2: process(Ins)

    variable Op: std_logic_vector(3 downto 0);
begin
    Op  := Ins(15 downto 12);

    if(Op="0110") then    --LM
        Ra_mux_s <= '0';
        Rc_mux_s <= '1';
    elsif(Op="0111")then  --SM
        Ra_mux_s <= '1';
        Rc_mux_s <= '0';
    else
        Ra_mux_s <= '0';
        Rc_mux_s <= '0';
    end if;
-- hello I am back !!

end process Controller_2;
end Behaviour;