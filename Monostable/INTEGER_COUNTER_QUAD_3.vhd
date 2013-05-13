----------------------------------------------------------------------------------
-- Company:        CETUC - Optoelectronics Laboratory
-- Engineer: 		 Gustavo Castro do Amaral
-- Create Date:    10:05:20 01/23/2013
-- Module Name:    INTERFACE - Behavioral 
-- Project Name:   IPCD_QUAD
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity INTEGER_COUNTER_QUAD_3 is
	generic(
		Clock_Cycles : INTEGER);
	port(
		clock        : IN STD_LOGIC;
		
		enable_IN    : IN STD_LOGIC;
		
		enable_OUT   : OUT STD_LOGIC);
end INTEGER_COUNTER_QUAD_3;

architecture Behavioral of INTEGER_COUNTER_QUAD_3 is

begin

	CLOCK_DIVISION : block

		signal DIV_ACC : integer range 0 to Clock_Cycles := 0;
		
		type CKDIV is (hold, count, transition);
		signal divState : CKDIV := hold;
		
	begin	
	
		with divState select
			enable_OUT <= '1' when transition,
						     '0' when others;
	
		ckDiv_FSM: process (clock)
		begin
			if(clock'event and clock = '1') then
				case divState is
					
					when hold =>
						if(enable_IN = '1') then
							divState <= count;
						end if;
					
					when count =>
						if(DIV_ACC = Clock_Cycles) then
							DIV_ACC <= 0;
							divState <= transition;
						else
							DIV_ACC <= DIV_ACC + 1;
						end if;
						
					when transition =>
						divState <= hold;
						
					when others => NULL;
					
				end case;
			end if;
		end process ckDiv_FSM;
		
	end block CLOCK_DIVISION;

end Behavioral;