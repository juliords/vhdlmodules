----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:58:10 04/09/2013 
-- Design Name: 
-- Module Name:    ClkDiv_tb - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClkDiv_tb is
end ClkDiv_tb;

architecture Behavioral of ClkDiv_tb is

	component ClockDivider is
		Generic ( 
			by_value : integer
		);
		Port ( 
			reset	: in  STD_LOGIC;
			clock : in  STD_LOGIC;
			pulse	: out STD_LOGIC
		);
	end component;

	signal rst 		: std_logic;
	signal clkIn 	: std_logic;
	signal clkOut 	: std_logic;
	constant T: time := 20 ns;

begin

	rst <= '1', '0' after T/4;

	Test_inst : ClockDivider
		generic map ( by_value => 1025 )
		port map(
			reset 	=> rst,
			clock 	=> clkIn,
			pulse 	=> clkOut
		);
	
	process
   begin
      clkIn <= '1';
      wait for T/2;
      clkIn <= '0';
      wait for T/2;
   end process;
	
end Behavioral;

