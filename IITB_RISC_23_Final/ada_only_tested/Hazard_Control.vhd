library ieee;
use ieee.std_logic_1164.all;

entity Hazard_Control is
    port(    
        clk             : in std_logic;

        ALU             : in std_logic_vector(15 downto 0);
        ALU_MEM         : in std_logic_vector(15 downto 0);
        MEM_DATA        : in std_logic_vector(15 downto 0);
        WB              : in std_logic_vector(15 downto 0);
        IB1             : in std_logic_vector(15 downto 0);
        IB2             : in std_logic_vector(15 downto 0);
        IB3             : in std_logic_vector(15 downto 0);
        IB4             : in std_logic_vector(15 downto 0);
        IB5             : in std_logic_vector(15 downto 0);
        Ra_Addr         : in std_logic_vector(2 downto 0);
        Rb_Addr         : in std_logic_vector(2 downto 0);
        P_enc_addr      : in std_logic_vector(2 downto 0);
        DATA_FA         : out std_logic_vector(15 downto 0);
        DATA_FB         : out std_logic_vector(15 downto 0);
        DATA_R0         : out std_logic_vector(15 downto 0);
        Ins_outB        : out std_logic_vector(15 downto 0); 
        A_dataF         : out std_logic;
        B_dataF         : out std_logic;
        BF1_en          : out std_logic;
        BF2_en          : out std_logic;
        BF3_en          : out std_logic;
        BF4_en          : out std_logic;
        BF5_en          : out std_logic;
        R0_pass_mux     : out std_logic_vector(1 downto 0);
        Ins_mux_s       : out std_logic;
        R0_wr_en        : out std_logic;

        ---NEW SIGNALS
        R0_Hazard_out   : out std_logic;
        Temp_data_s_out : out std_logic_vector(1 downto 0);
        ---BHAI 2 signals aur, yeh Buffer 5 se lene hai  : OK
        C2              : in std_logic; 
        Z2              : in std_logic

        );
end entity Hazard_Control;

architecture Behaviour of Hazard_Control is

    component imm_bit_off is
        port(
             clk: in std_logic;
             Ins: in std_logic_vector(15 downto 0); 
             bit_addr: in std_logic_vector(2 downto 0);
             Ins_out: out std_logic_vector(15 downto 0));
    end component;

    Signal     BF1_dis: std_logic :='0';

begin
    BF1_en <= not(BF1_dis);
    BF2_en <= '1';
    BF3_en <= '1';
    BF4_en <= '1';
    BF5_en <= '1';

    -- BF2_en <= not(BF2_dis); ---NEVER DISABLED 
    -- BF3_en <= not(BF3_dis);
    -- BF4_en <= not(BF4_dis);
    -- BF5_en <= not(BF5_dis);


    Imm_offing: imm_bit_off port map (
            clk => clk,
            Ins => IB1,
            bit_addr => P_enc_addr,
            Ins_out => Ins_outB);

Forwarding_Line: process(IB2, IB3, IB4, IB5) 
    variable Op2, Op3, Op4, Op5: std_logic_vector(3 downto 0);
    variable Src1, Src2, Dest3, Dest4, Dest5: std_logic_vector(2 downto 0);
    variable Cpl: std_logic;
    variable CZ: std_logic_vector(1 downto 0);

begin
    Op2:= IB2(15 downto 12);
    Op3:= IB3(15 downto 12);
    Op4:= IB4(15 downto 12);
    Op5:= IB5(15 downto 12);
    Cpl:= IB2(2);
    CZ:= IB2(1 downto 0);

    if(Op3="0011" or Op3="0100"or Op3="1100" or Op3="1101") then --finding Destination Addresses
        Dest3:=IB3(11 downto 9);
    elsif(Op3="0000") then
        Dest3:=IB3(8 downto 6);
    elsif(Op3="0001" or Op3="0010") then
        Dest3:=IB3(5 downto 3);
    elsif (Op3="0110") then
        Dest3:=P_enc_addr;  
    elsif(Op3="1000" or Op3="1001" or Op3="1010" or Op3="1111")then
        Dest3:="000";
    else
        Dest3:= "UUU";
    end if;

    if(Op4="0011" or Op4="0100" or Op3="1100" or Op3="1101") then
        Dest4:=IB4(11 downto 9);
    elsif(Op4="0000") then
        Dest4:=IB4(8 downto 6);
    elsif(Op4="0001" or Op4="0010") then
        Dest4:=IB4(5 downto 3);
    elsif (Op4="0110") then
        Dest4:=P_enc_addr;
    elsif(Op4="1000" or Op4="1001" or Op4="1010" or Op4="1111")then
        Dest4:="000";
    else
        Dest4:= "UUU";
    end if;

    if(Op5="0011" or Op5="0100" or Op3="1100" or Op3="1101") then
        Dest5:=IB5(11 downto 9);
    elsif(Op5="0000") then
        Dest5:=IB5(8 downto 6);
    elsif(Op5="0001" or Op5="0010") then
        Dest5:=IB5(5 downto 3);
    elsif (Op5="0110") then
        Dest5:=P_enc_addr;
    elsif(Op5="1000" or Op5="1001" or Op5="1010" or Op5="1111")then
        Dest5:="000";
    else
        Dest5:= "UUU";
    end if;

    if(Op2="0001" or Op2="0010" or Op2="0101" or Op2="1000" or Op2="1001" or Op2="1010") then
        Src1:= Ra_Addr;
        Src2:= Rb_Addr;
    elsif(Op2="0110" or Op2="1101" or Op2="1111")then
        Src1:=Ra_Addr;
        Src2:= "UUU";
    elsif(Op2="0000" or Op2="0100")then
        Src1:= "UUU";
        Src2:=Rb_Addr;
    elsif(Op2="0111") then
        Src1:= P_enc_addr;
        Src2:= Ra_Addr;
    else
        Src1:= "UUU";
        Src2:= "UUU";
    end if;

    if(not(Src1="UUU"))then
    if(Src1=Dest3) then
        DATA_FA <= ALU;
        A_dataF <= '1';
    elsif (Src1=Dest4) then
        DATA_FA <= ALU_MEM;
        A_dataF <= '1';
    elsif (Src1=Dest5) then
        DATA_FA <= WB;
        A_dataF <= '1';
    else
        A_dataF <= '0';
    end if;
    else
        A_dataF <= '0';
    end if;

    if(not(Src2="UUU"))then
    if(Src2=Dest3) then
        DATA_FB <= ALU;
        B_dataF <= '1';
    elsif (Src2=Dest4) then
        DATA_FA <= ALU_MEM;
        B_dataF <= '1';
    elsif (Src2=Dest5) then
        DATA_FB <= WB;
        B_dataF <= '1';
    else
        B_dataF <= '0';
    end if;
    else
        B_dataF <= '0';
    end if;
end process Forwarding_Line;    ----SEEMS GOOD






R0_Updating_Hazard: process(IB1, IB3, IB4)

        variable Op1, Op5: std_logic_vector(3 downto 0);
        variable Dest1, Dest5: std_logic_vector(2 downto 0);

    begin
        Op1 := IB1(15 downto 12);
        Op5 := IB5(15 downto 12);

    if(Op1="0011" or Op1="0100") then --finding Destination Addresses
        Dest1:=IB1(11 downto 9);
    elsif(Op1="0000") then
        Dest1:=IB1(8 downto 6);
    elsif(Op1="0001" or Op1="0010") then
        Dest1:=IB1(5 downto 3);
    elsif (Op1="0110") then
        Dest1:=P_enc_addr;
    elsif(Op1="1000" or Op1="1001" or Op1="1010" or Op1="1100" or Op1="1101" or Op1="1111" or Op1="1011")then
        Dest1:="000";
    else
        Dest1:= "UUU";
    end if;

    if(Dest1="000")then

        if(IB1=IB4) then
            if(Op1="0110" or Op1="0100") then
                R0_pass_mux <= "10";
                -- DATA_R0 <= MEM_DATA;
                BF1_dis <= '0';
            else
                null;
            end if;

        elsif (IB1=IB3) then
            if(not(Op1 = "0110") and not(Op1 = "0100")) then
                R0_pass_mux <= "01";
                -- DATA_R0 <= ALU;
                BF1_dis <= '0';
            else
                null;
            end if;
        else
        BF1_dis <= '1';
        end if;
    else
        R0_pass_mux <= "00";
        BF1_dis <= '0';
    end if;


    if(Op5="0011" or Op5="0100") then --finding Destination Addresses
        Dest5:=IB1(11 downto 9);
    elsif(Op5="0000") then
        Dest5:=IB1(8 downto 6);
    elsif(Op5="0001" or Op5="0010") then
        Dest5:=IB1(5 downto 3);
    elsif (Op5="0110") then
        Dest5:=P_enc_addr;
    elsif(Op5="1000" or Op5="1001" or Op5="1010" or Op5="1100" or Op5="1101" or Op5="1111")then
        Dest5:="000";
    else
        Dest5:= "UUU";
    end if;

    if(Dest5="000")then
        R0_Hazard_out <= '1';
    else
        R0_Hazard_out <= '0';
    end if;

end process R0_Updating_Hazard;


LM_SM_Management: process(IB1, IB2, IB3, IB4, IB5)

        variable Op1, Op2, Op3, Op4, Op5: std_logic_vector(3 downto 0);
        variable Imm8: std_logic_vector(7 downto 0);

    begin
        Op1 := IB1(15 downto 12);
        Op2 := IB2(15 downto 12);
        Op3 := IB3(15 downto 12);
        Op4 := IB4(15 downto 12);
        Op5 := IB5(15 downto 12);

        Imm8 := IB1(7 downto 0);
        if((Op1="0110" or Op1="0111") and (Imm8(7)='1' or Imm8(6)='1' or Imm8(5)='1' or Imm8(4)='1' or Imm8(3)='1' or Imm8(2)='1' or Imm8(1)='1' or Imm8(0)='1')) then
            Ins_mux_s <= '1';
            R0_wr_en <= '0';    --- TRUE IF THIS IS THE ONLY CASE WHERE R0_wr_en is DISABLED [got another case: Conditional Jumps BLEs]
            --Additional Control signals to be added here
        elsif(Op4="1000") then
            Ins_mux_s <= '0';
            R0_wr_en <= Z2 and not(C2);
        elsif(Op4="1001") then
            Ins_mux_s <= '0';
            R0_wr_en <= C2 and not(Z2);
        elsif(Op4="1010") then
            Ins_mux_s <= '0';
            R0_wr_en <= C2 or Z2;
        else
            Ins_mux_s <= '0';
            R0_wr_en <= '1';   
        end if;

        if((Op2="0110" and Op3="0110") or (Op2="0111" and Op3="0111"))then
            Temp_Data_s_out <= "10";
        elsif (Op2="0111" and Op3 /= "0111") then
            Temp_Data_s_out <= "01";
        else
            Temp_Data_s_out <= "00";
        end if;

end process LM_SM_Management;
end Behaviour;

---IF R0 values show wrong then possible solution can be defining separate component logic for R0_Wr_en



