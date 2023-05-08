-- Compile Tested

library ieee;
use ieee.std_logic_1164.all;

--The Second stage of INSTRUCTION DECODE is assembled here :

entity INS_DECODE is
    port(
        --Ra_mux_s, Rc_mux_s: in std_logic;    
        Ins_in         : in std_logic_vector(15 downto 0);
        Ra_addr        : out std_logic_vector(2 downto 0);     
        Rb_addr        : out std_logic_vector(2 downto 0);     
        Rc_addr        : out std_logic_vector(2 downto 0);     
        Ra_mux         : out std_logic_vector(2 downto 0); 
        Rc_mux         : out std_logic_vector(2 downto 0); 
        P_enc_addr     : out std_logic_vector(2 downto 0);
        imm9_out       : out std_logic_vector(8 downto 0);
        imm6_out       : out std_logic_vector(5 downto 0)
        );
end entity INS_DECODE;



architecture Structure of INS_DECODE is

component Ins_Decoder is
    port (Ins: in std_logic_vector(15 downto 0);
         Ra_Addr, Rb_Addr, Rc_Addr: out std_logic_vector(2 downto 0);
         imm9: out std_logic_vector(8 downto 0);
         imm6: out std_logic_vector(5 downto 0);
         imm8: out std_logic_vector(7 downto 0));
end component;

component priority_encoder IS
    port (
        PE_in : IN std_logic_vector(7 DOWNTO 0);
        PE_out : OUT std_logic_vector(2 DOWNTO 0)
    );
end component;

component Mux_2to1_3 is
    port(
        i_select    : in std_logic;
        i_data0     : in std_logic_vector(2 downto 0);
        i_data1     : in std_logic_vector(2 downto 0);
        o_data      : out std_logic_vector(2 downto 0)
    );
end component;

component Stage2_Control_Unit is
    port(
        Ins     : in std_logic_vector(15 downto 0);
        Ra_mux_s        : out std_logic;
        Rc_mux_s        : out std_logic
    );
end component;


signal ID_to_PE: std_logic_vector(7 downto 0);
signal PE_value, Ra_Temp, Rb_Temp, Rc_Temp: std_logic_vector(2 downto 0);
signal c_Ra_mux_s, c_Rc_mux_s : std_logic;

begin

Instruction_Decoder_INST: Ins_Decoder port map(
                                          Ins => Ins_in,
                                          Ra_Addr => Ra_Temp,
                                          Rb_Addr => Rb_Temp,
                                          Rc_Addr => Rc_Temp,
                                          imm9 => imm9_out,
                                          imm6 => imm6_out,
                                          imm8 => ID_to_PE
                                          );

Priority_Encoder_INST: priority_encoder port map(
                                            PE_in => ID_to_PE,
                                            PE_out => PE_value
                                            );

Ra_addr <= Ra_Temp;     
Rb_addr <= Rb_Temp;
Rc_addr <= Rc_Temp;               
P_enc_addr <= PE_value;

Ra_select_mux_INST: Mux_2to1_3 port map(
                                   i_select => c_Ra_mux_s,-- Ra_mux_s;
                                   i_data0 => Ra_Temp,
                                   i_data1 => PE_value,
                                   o_data => Ra_mux
                                   );

Rc_select_mux_INST: Mux_2to1_3 port map(
                                    i_select => c_Rc_mux_s,-- Rc_mux_s;
                                    i_data0 => Rc_Temp,
                                    i_data1 => PE_value,
                                    o_data => Rc_mux
                                    );

s2_control_INST: Stage2_Control_Unit
    port map(
        Ins     => Ins_in,
        Ra_mux_s        => c_Ra_mux_s,
        Rc_mux_s        => c_Rc_mux_s
    );

end Structure;
