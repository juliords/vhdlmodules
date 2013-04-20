----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:54:59 04/09/2013 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

entity ClockDivider is
	Generic ( 
		by_value : integer
	);
	Port ( 
		reset	: in  STD_LOGIC;
		clock : in  STD_LOGIC;
		pulse	: out STD_LOGIC
	);
end ClockDivider;

architecture Behavioral of ClockDivider is

	constant len 		: integer := integer(ceil(log2(real(by_value))));
	signal 	count 	: STD_LOGIC_VECTOR(len-1 downto 0);
	signal 	msb_ff 	: STD_LOGIC;

begin
	
	pulse <= msb_ff and (not count(len-1));

	process (reset, clock)
	begin
		if reset = '1' then
			msb_ff <= '0';
		elsif rising_edge(clock) then
			msb_ff <= count(len-1);
		end if;
	end process;

	process (reset, clock)
	begin
		if reset = '1' then
			count <= (others=>'0');
		elsif rising_edge(clock) then
			if count = by_value-1 then
				count <= (others=>'0');
			else
				count <= count + 1;
			end if;
		end if;
	end process;

end Behavioral;

