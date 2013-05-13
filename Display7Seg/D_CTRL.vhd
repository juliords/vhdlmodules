library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_CTRL is
port (
		clk 		: in  std_logic;
      bcd1 		: in  std_logic_vector(3 downto 0);  --BCD input
		bcd2 		: in  std_logic_vector(3 downto 0);  --BCD input
      segment7 : out std_logic_vector(6 downto 0);  -- 7 bit decoded output.
		cat 		: out std_logic
    );
end D_CTRL;
--'a' corresponds to MSB of segment7 and g corresponds to LSB of segment7.
architecture Behavioral of D_CTRL is

	signal seg7_int 	: std_logic_vector(6 downto 0);
	signal bcd 			: std_logic_vector(3 downto 0);

begin

	cat <= clk;
	segment7 <= not seg7_int;

	process (clk,bcd1,bcd2)
	BEGIN
		if clk = '1' then
			bcd <= bcd1;
		else
			bcd <= bcd2;
		end if;

		case  bcd is
			WHEN "0000"=>seg7_int<="0000001";
			WHEN "0001"=>seg7_int<="1001111";
			WHEN "0010"=>seg7_int<="0010010";
			WHEN "0011"=>seg7_int<="0000110";
			WHEN "0100"=>seg7_int<="1001100";
			WHEN "0101"=>seg7_int<="0100100";
			WHEN "0110"=>seg7_int<="0100000";
			WHEN "0111"=>seg7_int<="0001111";
			WHEN "1000"=>seg7_int<="0000000";
			WHEN "1001"=>seg7_int<="0000100";
			WHEN "1010"=>seg7_int<="0001000";
			WHEN "1011"=>seg7_int<="1100000";
			WHEN "1100"=>seg7_int<="0110001";
			WHEN "1101"=>seg7_int<="1000010";
			WHEN "1110"=>seg7_int<="0110000";
			WHEN "1111"=>seg7_int<="0111000";
		 --nothing is displayed when a number more than 9 is given as input. 
			when others=> seg7_int <="1111111"; 
		end case;
	end process;

end Behavioral;

