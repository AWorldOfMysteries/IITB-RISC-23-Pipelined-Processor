-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Buffer2_IDC_RR is
    port(
        i_rst                                       : in std_logic;
        i_en                                        : in std_logic;
        i_clk                                       : in std_logic;
        i_b2_Ra_Addr                                : in std_logic_vector(2 downto 0);
        i_b2_Rb_Addr                                : in std_logic_vector(2 downto 0);
        i_b2_Rc_Addr                                : in std_logic_vector(2 downto 0);
        i_b2_imm9                                   : in std_logic_vector(8 downto 0);
        i_b2_imm6                                   : in std_logic_vector(5 downto 0);
        i_b2_pc, i_ins                              : in std_logic_vector(15 downto 0);
        o_b2_Ra_Addr                                : out std_logic_vector(2 downto 0);
        o_b2_Rb_Addr                                : out std_logic_vector(2 downto 0);
        o_b2_Rc_Addr                                : out std_logic_vector(2 downto 0);
        o_b2_imm9                                   : out std_logic_vector(8 downto 0);
        o_b2_imm6                                   : out std_logic_vector(5 downto 0);
        o_b2_pc, o_ins                              : out std_logic_vector(15 downto 0)
    );
end entity Buffer2_IDC_RR;

architecture arch_Buffer2_IDC_RR of Buffer2_IDC_RR is
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            o_b2_Ra_Addr    <= "UUU";
            o_b2_Rb_Addr    <= "UUU";
            o_b2_Rc_Addr    <= "UUU";
            o_b2_imm9       <= "UUUUUUUUU";
            o_b2_imm6       <= "UUUUUU";
            o_ins           <= x"0000";
            o_b2_pc  <= x"0000";              
        elsif(rising_edge(i_clk)) then
            if(i_en='1') then
                o_b2_Ra_Addr <= i_b2_Ra_Addr;
                o_b2_Rb_Addr <= i_b2_Rb_Addr;
                o_b2_Rc_Addr <= i_b2_Rc_Addr;
                o_b2_imm9 <= i_b2_imm9;
                o_b2_imm6 <= i_b2_imm6;
                o_b2_pc  <= i_b2_pc;
                o_ins <= i_ins;
            end if;
        end if;
    end process;
end architecture arch_Buffer2_IDC_RR;
