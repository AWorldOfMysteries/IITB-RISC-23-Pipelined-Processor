library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Buffer4_EX_MA is
    port(
        i_rst                   : in std_logic;
        i_en                    : in std_logic;
        i_clk                   : in std_logic;
        i_Rc_addr               : in std_logic_vector(2 downto 0);
        o_Rc_addr               : out std_logic_vector(2 downto 0);
        i_ALU1_output           : in std_logic_vector(15 downto 0);
        i_ALU2_output           : in std_logic_vector(15 downto 0);
        -- i_Mem_data              : in std_logic_vector(15 downto 0);
        i_Ra_data               : in std_logic_vector(15 downto 0);
        i_PC_in                 : in std_logic_vector(15 downto 0);
        i_Ins_in                : in std_logic_vector(15 downto 0);
        i_C1_in                 : in std_logic;
        i_C2_in                 : in std_logic;
        i_Z1_in                 : in std_logic;
        i_Z2_in                 : in std_logic;
        o_ALU1_output           : out std_logic_vector(15 downto 0);
        o_ALU2_output           : out std_logic_vector(15 downto 0);
        -- o_Mem_data              : out std_logic_vector(15 downto 0);
        o_Ra_data               : out std_logic_vector(15 downto 0);
        o_PC_in                 : out std_logic_vector(15 downto 0);
        o_Ins_in                : out std_logic_vector(15 downto 0);
        o_C1_in                 : out std_logic;
        o_C2_in                 : out std_logic;
        o_Z1_in                 : out std_logic;
        o_Z2_in                 : out std_logic
    );
end entity Buffer4_EX_MA;

architecture arch_Buffer4_EX_MA of Buffer4_EX_MA is
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            o_ALU1_output <= x"0000";
            o_ALU2_output <= x"0000";
            -- o_Mem_data <= x"0000";
            o_Ra_data <= x"0000";
            o_PC_in <= x"0000";
            o_Ins_in <= x"E000";
            o_Rc_addr <= "UUU";
            o_C1_in <= '0';
            o_C2_in <= '0';
            o_Z1_in <= '0';
            o_Z2_in <= '0';                 
        elsif(rising_edge(i_clk)) then
            if(i_en='1' and i_rst='0') then
                o_ALU1_output <= i_ALU1_output;
                o_ALU2_output <= i_ALU2_output;
                -- o_Mem_data <= i_Mem_data;
                o_Ra_data <= i_Ra_data;
                o_PC_in <= i_PC_in;
                o_Ins_in <= i_Ins_in;
                o_Rc_addr <= i_Rc_addr;
                o_C1_in <= i_C1_in;
                o_C2_in <= i_C2_in;
                o_Z1_in <= i_Z1_in;
                o_Z2_in <= i_Z2_in;

        
            end if;
        end if;
    end process;
end architecture arch_Buffer4_EX_MA;
