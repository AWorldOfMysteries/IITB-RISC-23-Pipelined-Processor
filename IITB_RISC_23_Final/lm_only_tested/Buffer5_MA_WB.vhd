library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Buffer5_MA_WB is
    port(
        i_rst                               : in std_logic;
        i_en                                : in std_logic;
        i_clk                               : in std_logic;
        i_C1_in                             : in std_logic;
        i_C2_in                             : in std_logic;
        i_Z1_in                             : in std_logic;
        i_Z2_in                             : in std_logic;

        i_C1_old_in                         : in std_logic;
        i_Z1_old_in                         : in std_logic;

        i_ALU1_dataout                      : in std_logic_vector(15 downto 0);
        i_ALU2_dataout                      : in std_logic_vector(15 downto 0);
        i_Mem_dataout                       : in std_logic_vector(15 downto 0);
        i_Dest_addr                         : in std_logic_vector(2 downto 0);
        i_Ins_in                            : in std_logic_vector(15 downto 0);        
        i_PC_in                             : in std_logic_vector(15 downto 0);    
        o_C1_in                             : out std_logic;
        o_C2_in                             : out std_logic;
        o_Z1_in                             : out std_logic;
        o_Z2_in                             : out std_logic;

        o_C1_old_out                        : out std_logic;
        o_Z1_old_out                        : out std_logic;

        o_ALU1_dataout                      : out std_logic_vector(15 downto 0);
        o_ALU2_dataout                      : out std_logic_vector(15 downto 0);
        o_Mem_dataout                       : out std_logic_vector(15 downto 0);
        o_Dest_addr                         : out std_logic_vector(2 downto 0);
        o_Ins_in                            : out std_logic_vector(15 downto 0);        
        o_PC_in                             : out std_logic_vector(15 downto 0) 
        -- ---Control Signals
        -- i_RF_en_to_WB   : in std_logic;
        -- o_RF_en_to_WB   : out std_logic;
        -- i_WB_mux_s: in std_logic;
        -- o_WB_mux_s: out std_logic;
    );
end entity Buffer5_MA_WB;

architecture arch_Buffer5_MA_WB of Buffer5_MA_WB is
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            o_C1_in <= '0';
            o_Z1_in <= '0';
            o_C2_in <= '0';
            o_Z2_in <= '0';

            o_C1_old_out <= '0';
            o_Z1_old_out <= '0'; 

            o_ALU1_dataout <= "UUUUUUUUUUUUUUUU";
            o_ALU2_dataout <= "UUUUUUUUUUUUUUUU";
            o_Mem_dataout <=  "UUUUUUUUUUUUUUUU";
            o_Dest_addr <= "UUU";

            o_Ins_in    <= "1110000000000000";
            o_PC_in     <= "0000000000000000";

            -- o_WB_mux_s <= '0';    
            -- o_RF_en_to_WB <= '0';
        elsif(rising_edge(i_clk)) then
            if(i_en='1') then
                o_C1_in <= i_C1_in;
                o_Z1_in <= i_Z1_in;
                o_C2_in <= i_C2_in;
                o_Z2_in <= i_Z2_in;

                o_C1_old_out <= i_C1_old_in;
                o_Z1_old_out <= i_Z1_old_in;

                o_ALU1_dataout <= i_ALU1_dataout;
                o_ALU2_dataout <= i_ALU2_dataout;
                o_Mem_dataout <=  i_Mem_dataout;
                o_Dest_addr <= i_Dest_addr;

                o_Ins_in    <= i_Ins_in;
                o_PC_in     <= i_PC_in ;
                -- o_WB_mux_s <= i_WB_mux_s; 
                -- o_RF_en_to_WB <= i_RF_en_to_WB;
            end if;
        end if;
    end process;
end architecture arch_Buffer5_MA_WB;
