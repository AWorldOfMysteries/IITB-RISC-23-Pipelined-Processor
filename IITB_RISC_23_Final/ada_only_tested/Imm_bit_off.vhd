library ieee;
use ieee.std_logic_1164.all;

entity imm_bit_off is
    port(
         clk: in std_logic;
         Ins: in std_logic_vector(15 downto 0); 
         bit_addr: in std_logic_vector(2 downto 0);
         Ins_out: out std_logic_vector(15 downto 0)
         );
end entity imm_bit_off;

architecture behaviour of imm_bit_off is


    signal Imm8, Imm8f: std_logic_vector(7 downto 0);

begin


    offing_setup: process(clk)

    -- variable Imm8, Imm8f: std_logic_vector(7 downto 0);

begin
    -- Imm8 <= Ins(7 downto 0);
    -- Imm8f := Ins(7 downto 0);
    -- Ins_out(15 downto 8) <= Ins (15 downto 8);

    case bit_addr is

                        when "111" =>
                            Ins_out(0) <= not Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "110" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= not Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "101" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= not Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "100" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= not Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "011" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= not Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "010" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= not Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "001" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= not Ins(6);
                            Ins_out(7) <= Ins(7);
                        when "000" =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= not Ins(7);
                        when others =>
                            Ins_out(0) <= Ins(0);
                            Ins_out(1) <= Ins(1);
                            Ins_out(2) <= Ins(2);
                            Ins_out(3) <= Ins(3);
                            Ins_out(4) <= Ins(4);
                            Ins_out(5) <= Ins(5);
                            Ins_out(6) <= Ins(6);
                            Ins_out(7) <= Ins(7);
    end case;

    -- Ins_out(7 downto 0) <= Imm8f(7 downto 0);
    Ins_out(15 downto 8) <= Ins (15 downto 8);


    end process offing_setup;
end behaviour;
