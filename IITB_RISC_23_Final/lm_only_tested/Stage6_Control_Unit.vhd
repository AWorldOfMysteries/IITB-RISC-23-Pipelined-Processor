-- COMPILE CHECKED

library ieee;
use ieee.std_logic_1164.all;

entity Stage6_Control_Unit is
    port(
        Ins             : in std_logic_vector(15 downto 0);
        C1_old          : in std_logic;
        Z1_old          : in std_logic;
        R0_Hazard       : in std_logic;
        RF_wr_en        : out std_logic;
        WB_mux_s        : out std_logic_vector(1 downto 0)
    );
end entity Stage6_Control_Unit;




architecture Behaviour of Stage6_Control_Unit is


begin

    Controller_6: process(Ins)

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
                    RF_wr_en <= not(R0_hazard);
                    WB_mux_s <= "00";
                elsif(CZ="01") then     --ADZ
                    RF_wr_en <= not(R0_hazard) and (Z1_old);
                    WB_mux_s <= "00";
                elsif(CZ="10") then     --ADC
                    RF_wr_en <= not(R0_hazard) and (C1_old);
                    WB_mux_s <= "00";
                elsif(CZ="11") then     --AWC
                    RF_wr_en <= not(R0_hazard);
                    WB_mux_s <= "00";
                end if;

            elsif(Cpl='1') then
                if(CZ="00") then        --ACA
                    RF_wr_en <= not(R0_hazard);
                    WB_mux_s <= "00";
                elsif(CZ="01") then     --ACZ
                    RF_wr_en <= not(R0_hazard) and (Z1_old);
                    WB_mux_s <= "00";
                elsif(CZ="10") then     --ACC
                    RF_wr_en <= not(R0_hazard) and (C1_old);
                    WB_mux_s <= "00";
                elsif(CZ="11") then     --ACW
                    RF_wr_en <= not(R0_hazard);
                    WB_mux_s <= "00";
                end if;
            end if;


        when "0000" =>                  --ADI
            RF_wr_en <= not(R0_hazard);
            WB_mux_s <= "00";
        
        when "0010" =>                  --NAND Instructions
                if (Cpl='0') then
                    if(CZ="00") then    --NDU
                        RF_wr_en <= not(R0_hazard);
                        WB_mux_s <= "00";

                    elsif(CZ="01") then --NDZ
                        RF_wr_en <= not(R0_hazard) and (Z1_old);
                        WB_mux_s <= "00";

                    elsif(CZ="10") then --NDC
                        RF_wr_en <= not(R0_hazard) and (C1_old);
                        WB_mux_s <= "00";
                    end if;
                
                elsif (Cpl='1') then
                    if(CZ="00") then    --NCU
                        RF_wr_en <= not(R0_hazard);
                        WB_mux_s <= "00";

                    elsif(CZ="01") then --NCZ
                        RF_wr_en <= not(R0_hazard) and (Z1_old);
                        WB_mux_s <= "00";

                    elsif(CZ="10") then --NCC
                        RF_wr_en <= not(R0_hazard) and (C1_old);
                        WB_mux_s <= "00";
                    end if;
                end if;
        
                    when "0011" =>                  --LLI
                        RF_wr_en <=not(R0_hazard);
                        WB_mux_s <="00";
        
                    when "0100" =>                  --LW
                        RF_wr_en <=not(R0_hazard);
                        WB_mux_s <="01";
        
                    when "0101" =>                  --SW
                        RF_wr_en <='0';
                        WB_mux_s <="00";
        
                    when "0110" =>                  --LM
                        RF_wr_en <=not(R0_hazard);
                        WB_mux_s <="01";
        
                    when "0111" =>                  --SM
                        RF_wr_en <='0';
                        WB_mux_s <="00";
        
                    when "1000" =>                  --BEQ
                        RF_wr_en <='0';
                        WB_mux_s <="00";
        
                    when "1001" =>                  --BLT         
                        RF_wr_en <='0';
                        WB_mux_s <="00";
        
                    when "1010" =>                  --BLE [OPCODE of this INS is wrong in the Problem Sheet; BLE:1010]
                        RF_wr_en <='0';
                        WB_mux_s <="00";
        
                    when "1100" =>                  --JAL
                        RF_wr_en <='1';
                        WB_mux_s <="11";
        
                    when "1101" =>                  --JLR
                        RF_wr_en <='1';
                        WB_mux_s <="11";
        
                    when "1111" =>                  --JLI
                        RF_wr_en <='0';
                        WB_mux_s <="11";
        
                    when others=>
                        RF_wr_en <='0';
                        WB_mux_s <="00";
                end case;


    end process Controller_6;
end Behaviour;