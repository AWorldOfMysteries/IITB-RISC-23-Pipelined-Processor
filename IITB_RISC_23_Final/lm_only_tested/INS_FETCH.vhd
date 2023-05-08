-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;

--The first stage of INSTRUCTION FETCH is assembled here :
--Who controls the write enable for R0 (Unsolved)
-- Ins memory and adder pc left to check


entity INS_FETCH is
    port(
        Ins_mux_s               : in std_logic;
        R0_pass_mux             : in std_logic_vector(1 downto 0);
        HC_Ins_in               : in std_logic_vector(15 downto 0);   
        ALU_frwrd_in, Mem_frwrd_in         : in std_logic_vector(15 downto 0);   ---Name change
        R0_dataRF               : in std_logic_vector(15 downto 0);
        Ins_addr_out_B          : out std_logic_vector(15 downto 0);
        R0_datain_RF            : out std_logic_vector(15 downto 0);
        Ins_out_B               : out std_logic_vector(15 downto 0)
        
        
        );

end entity INS_FETCH;

architecture structure of INS_FETCH is

component Ins_Memory is
    port(addr_in: in std_logic_vector(15 downto 0);
         data_out: out std_logic_vector(15 downto 0));
end component;

component Mux_4to1_16 is
    port(
        i_select    : in std_logic_vector(1 downto 0);
        i_data00     : in std_logic_vector(15 downto 0);
        i_data01     : in std_logic_vector(15 downto 0);
        i_data10     : in std_logic_vector(15 downto 0);
        i_data11     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
        );
end component;

component Mux_2to1_16 is
    port(
        i_select    : in std_logic;
        i_data0     : in std_logic_vector(15 downto 0);
        i_data1     : in std_logic_vector(15 downto 0);
        o_data      : out std_logic_vector(15 downto 0)
    );
end component;

component Adder_pc is
    port(
        ADDER_IN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ADDER_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
end component;

-- component Stage1_Control_Unit is
--     port(
--         control_inp     : in std_logic_vector(15 downto 0);
--         R0_Mux          : out std_logic;
--         Ins_Mux         : out std_logic
--     );
-- end component;

signal R0_to_IM, Ins_to_Iout: std_logic_vector(15 downto 0);
-- signal c_R0_Mux             : std_logic;
-- signal c_Ins_Mux            : std_logic;


begin

Ins_addr_out_B <= R0_to_IM;

R0_select_Mux_INST: Mux_4to1_16 port map(i_select => R0_pass_mux,
                                        i_data00 => R0_dataRF,
                                        i_data01 => ALU_frwrd_in,
                                        i_data10 => Mem_frwrd_in,
                                        i_data11 => x"0000",
                                        o_data => R0_to_IM
                                    );
Instruction_Memory_INST: Ins_Memory port map(
                                        addr_in => R0_to_IM,
                                        data_out => Ins_to_Iout
                                        );
Instruction_out_Mux_INST: Mux_2to1_16 port map(i_select => Ins_mux_s,
                                          i_data0 => Ins_to_Iout,
                                          i_data1 => HC_ins_in,
                                          o_data => Ins_out_B
                                            );
PC_Adder_INST: Adder_pc port map(
                            ADDER_IN => R0_to_IM,
                            ADDER_OUT => R0_datain_RF 
                            );

-- s1_control_INST: Stage1_Control_Unit
--     port map(
--     control_inp     => HC_ins_in,    --say -- To be changed    --??
--     R0_Mux          => c_R0_Mux,
--     Ins_Mux         => c_Ins_Mux
--     );


end architecture structure;