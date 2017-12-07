----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:40:39 10/20/2017 
-- Design Name: 
-- Module Name:    roundCount - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity roundCount is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (3 downto 0));
end roundCount;

architecture Behavioral of roundCount is
	signal temp : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal en	: STD_LOGIC := '0';
begin

	process(clk, clr)
	begin
		
		
		if rising_edge(clk) then
			if clr = '1' then
				temp <= X"B";
			else
				if temp < X"B" then
					temp <= temp + 1;
				else
					temp <= X"0";
				end if;
			end if;
		end if;
	end process;
	
	q <= temp;

end Behavioral;

