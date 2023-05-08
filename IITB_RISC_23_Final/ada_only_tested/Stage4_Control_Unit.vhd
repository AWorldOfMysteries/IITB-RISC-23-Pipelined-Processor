library ieee;
use ieee.std_logic_1164.all;

entity Stage4_Control_Unit is
    port(
        Ins: in std_logic_vector(15 downto 0);
        ALU1_Ctrl, ALU2_Ctrl, C1_en, Z1_en, C_take: out std_logic;

        ---NEW SIGNALS
        ALU2A_mux_s: out std_logic_vector(1 downto 0);
        ALU2B_mux_s: out std_logic
    );
end entity Stage4_Control_Unit;

architecture Structure of Stage4_Control_Unit is



begin

    Controller_4: process(Ins)
    
    variable Op: std_logic_vector(3 downto 0);

    begin

    Op  := Ins(15 downto 12);

    if(Op="0001" or Op="0000")then
        C1_en <= '1';
        Z1_en <= '1';
    elsif(Op="0010" or Op="0100")then
        C1_en <= '0';
        Z1_en <= '1';
    else
        C1_en <= '0';
        Z1_en <= '0';
    end if;

    if(Op="0010")then
        ALU1_Ctrl <='1';
    else
        ALU1_Ctrl <='0';
    end if;

    if (Op="1000" or Op="1001" or Op="1010")then
        ALU2_Ctrl <='1';
    else
        ALU2_Ctrl <='0';
    end if;

    if(Op="0001" and (Ins(1 downto 0)="11"))then
        C_take <= '1';
    else
        C_take <= '0';
    end if;

    if(Op="0110" or Op="0111")then
        ALU2A_mux_s <="11";
        ALU2B_mux_s <='1';
    elsif (Op="1000" or Op="1001" or Op="1010") then
        ALU2A_mux_s <="00";
        ALU2B_mux_s <='0';
    else
        ALU2A_mux_s <="01";
        ALU2B_mux_s <='1';
    end if;
    
    end process Controller_4;
end Structure;