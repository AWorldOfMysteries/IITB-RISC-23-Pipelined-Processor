library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage3_Control_Unit is
    port(
        Ins         : in std_logic_vector(15 downto 0);
        Sign_mux_s    : out std_logic_vector(1 downto 0);
        ALU1A_mux_s              : out std_logic_vector(1 downto 0);
        ALU1B_mux_s              : out std_logic_vector(2 downto 0)
    );
end entity Stage3_Control_Unit;

architecture arch_Stage3_Control_Unit of Stage3_Control_Unit is

begin
    Controller_3: process(Ins)

    variable Op: std_logic_vector(3 downto 0);
    variable Cpl: std_logic;
    variable CZ: std_logic_vector(1 downto 0);
begin
    Op  := Ins(15 downto 12);
    Cpl := Ins(2);
    CZ  := Ins(1 downto 0);

    case Op is

        when "0001" =>                  -- Addition Instructions
            if(Cpl='0') then
                if(CZ="00") then        --ADA    
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";
                elsif(CZ="01") then     --ADZ
                            ALU1A_mux_s <= "00"; 
                            ALU1B_mux_s <= "000";
                            Sign_mux_s  <= "00";
                elsif(CZ="10") then     --ADC
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "000";
                            Sign_mux_s  <= "00";
                elsif(CZ="11") then     --AWC
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "000";
                            Sign_mux_s  <= "00";
                end if;

            elsif(Cpl='1') then
                if(CZ="00") then        --ACA
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "010";
                            Sign_mux_s  <= "00";
                elsif(CZ="01") then     --ACZ
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "010";
                            Sign_mux_s  <= "00";
                elsif(CZ="10") then     --ACC
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "010";
                            Sign_mux_s  <= "00";
                elsif(CZ="11") then     --ACW
                            ALU1A_mux_s <= "00";
                            ALU1B_mux_s <= "010";
                            Sign_mux_s  <= "00";
                end if;
            end if;


        when "0000" =>                  --ADI
                        ALU1A_mux_s <= "01";
                        ALU1B_mux_s <= "000";
                        Sign_mux_s  <= "00";
        
        when "0010" =>                  --NAND Instructions
                if (Cpl='0') then
                    if(CZ="00") then    --NDU
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";

                    elsif(CZ="01") then --NDZ
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";

                    elsif(CZ="10") then --NDC
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";
                    end if;
                
                elsif (Cpl='1') then
                    if(CZ="00") then    --NCU
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "010";
                    Sign_mux_s  <= "00";

                    elsif(CZ="01") then --NCZ
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "010";
                    Sign_mux_s  <= "00";

                    elsif(CZ="10") then --NCC
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "010";
                    Sign_mux_s  <= "00";
                    end if;
                end if;

        when "0011" =>                  --LLI
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "011";
                    Sign_mux_s  <= "11";
        
        when "0100" =>                  --LW
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";

        when "0101" =>                  --SW
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";
        
        when "0110" =>                  --LM
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "011";
                    Sign_mux_s  <= "00";

        when "0111" =>                  --SM
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "00";

        when "1000" =>                  --BEQ
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "001";
                    Sign_mux_s  <= "01";
        
        when "1001" =>                  --BLT         
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "001";
                    Sign_mux_s  <= "01";

        when "1010" =>                  --BLE [OPCODE of this INS is wrong in the Problem Sheet; BLE:1010]
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "001";
                    Sign_mux_s  <= "01";

        when "1100" =>                  --JAL
                    ALU1A_mux_s <= "01";
                    ALU1B_mux_s <= "001";
                    Sign_mux_s  <= "10";
        
        when "1101" =>                  --JLR
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "011";
                    Sign_mux_s  <= "00";
        
        when "1111" =>                  --JLI
                    ALU1A_mux_s <= "00";
                    ALU1B_mux_s <= "000";
                    Sign_mux_s  <= "10";

        when others=>
        null;

end case;


end process Controller_3;





end architecture arch_Stage3_Control_Unit;